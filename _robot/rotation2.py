import sys
import os
import math
import random
import time
import threading

import numpy
import mss
import mss.tools
import cv2
import pyautogui
import win32gui
from win32api import GetSystemMetrics
from datetime import datetime as dt
from pynput import keyboard
from skimage import metrics
from os.path import isfile

# --- Mode selection ---
mode = sys.argv[1] if len(sys.argv) == 2 else "wotlk"

if mode == "wotlk":
    from libs.resources_wotlk import data, monitor_settings, keyCodeMap
elif mode == "tbc":
    from libs.resources_tbc import data, monitor_settings, keyCodeMap
else:
    from libs.resources_classic import data, monitor_settings, keyCodeMap

from libs.ctypes_custom import KeyPress as cKeyPress

# --- Constants ---
SCORE_THRESHOLD = 0.90
COLOR_DISTANCE = 10
WOW_WINDOW = "World of Warcraft"
COMBAT_SKIP = (255, 255, 255)
INTERRUPT_COLOR = (0, 255, 0)
INTERRUPT_KEY = "F9"

# --- State ---
dprint = False
debug = False
pause = False
wow_class = "warrior"
out_of_combat = False

# --- Screen / monitor setup ---
screen_width = GetSystemMetrics(0)
screen_height = GetSystemMetrics(1)
monitor = str(screen_width)

x = monitor_settings[monitor]["x"]
y = monitor_settings[monitor]["y"]
c_width = monitor_settings[monitor]["c_width"]
c_height = monitor_settings[monitor]["c_height"]
p_offgcd_left = monitor_settings[monitor]["p_offgcd_left"]
p_combat_left = monitor_settings[monitor]["p_combat_left"]
p_interrupt_left = monitor_settings[monitor]["p_interrupt_left"]
p_behind_left = monitor_settings[monitor]["p_behind_left"]
p_clss_left = monitor_settings[monitor]["p_clss_left"]

dir_path = os.path.dirname(os.path.realpath(__file__))
abilities_folder = os.path.join(dir_path, "images", mode, monitor)
debug_folder = os.path.join(dir_path, "images", "_")

# Pre-compute static capture regions — these never change, no need to rebuild each loop
p_main = {"top": 2, "left": 2, "width": x, "height": y}
p_offgcd = {"top": 2, "left": p_offgcd_left, "width": x, "height": y}
p_combat = {"top": 0, "left": p_combat_left, "width": c_width, "height": c_height}
p_interrupt = {"top": 0, "left": p_interrupt_left, "width": c_width, "height": c_height}
p_behind = {"top": 0, "left": p_behind_left, "width": c_width, "height": c_height}
p_clss = {"top": 0, "left": p_clss_left, "width": c_width, "height": c_height}

# Pre-compute center pixel coordinates for small region grabs
cx = math.floor(c_width / 2)
cy = math.floor(c_height / 2)

# Lock prevents multiple rotation threads from piling up when SSIM is slow
_rotation_lock = threading.Lock()

wow_class_loaded = wow_class
print("Script loaded and ready.", "Monitor:", screen_width, screen_height, dt.now().strftime("%H:%M:%S"))
print("PRINT:", dprint)
print("DEBUG:", debug)
print("F12: ACTIVE")
print("MODE:", mode.upper())
print("CLASS:", wow_class_loaded.upper())
pyautogui.hotkey("ctrl", "f12")


# --- Key press ---
def press_interception_key(key, modifier=False):
    cKeyPress(key, modifier)


# --- Hotkey listener ---
def on_press(key):
    global dprint, pause, debug, out_of_combat
    try:
        if key == keyboard.Key.f8:
            dprint = not dprint
            print("PRINT:", dprint)
        elif key == keyboard.Key.f11:
            debug = not debug
            print("DEBUG:", debug)
        elif key == keyboard.Key.f12:
            pause = not pause
            print("ROTATION:", not pause)
            if pause:
                pyautogui.hotkey("alt", "f12")
                pyautogui.hotkey("end")
                out_of_combat = True
                pyautogui.PAUSE = 1
                pyautogui.FAILSAFE = False
            else:
                pyautogui.hotkey("ctrl", "f12")
                pyautogui.PAUSE = 0.05
                pyautogui.FAILSAFE = True
    except Exception:
        pass


# --- Color helpers ---
def parse_hex_color(string):
    s = string.lstrip("#")
    return int(s[0:2], 16), int(s[2:4], 16), int(s[4:6], 16)


def color_similarity(a, b):
    return math.sqrt((a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2 + (a[2] - b[2]) ** 2)


def get_class(clss, distance):
    global wow_class
    found = False
    for item, colors in data["colors"].items():
        for c in colors:
            if color_similarity(parse_hex_color(c), clss) <= distance:
                found = True
                wow_class = item
    return found, wow_class


# --- Unified skill loader ---
_SKILL_SUFFIX = {"healing": " H.png", "globals": " G.png", "main": " M.png", "secondary": " O.png"}


def load_skills(wow_class, skill_type):
    skills = {}
    try:
        if skill_type in ("healing", "globals"):
            skill_list = data[skill_type]
            subfolder = skill_type
        else:
            skill_list = data[wow_class][skill_type]
            subfolder = wow_class

        suffix = _SKILL_SUFFIX[skill_type]

        for skill in skill_list:
            name = skill["name"]
            image_path = os.path.join(abilities_folder, subfolder, name + suffix)
            if not isfile(image_path):
                print(name, "MISSING")
                continue
            entry = {
                "image": cv2.imread(image_path),
                "key": skill["key"],
                "name": name,
            }
            if "modifier" in skill:
                entry["modifier"] = skill["modifier"]
            if "pause" in skill:
                entry["pause"] = skill["pause"]
            skills[name] = entry

    except Exception as e:
        print(f"{skill_type} abilities missing for {wow_class}", dt.now().strftime("%H:%M:%S"))
        print(e)

    return skills


# --- Debug printer ---
def print_debug(ability, score, start_time):
    skill = f"{ability['name']:<25}"
    modifier = f"{ability.get('modifier', 'none'):<8}"
    key = f"{ability['key']:<5}"
    sc = f"{score * 100:.2f}%"
    ms = f"{round(1000 * (time.time() - start_time))} ms"
    print(skill, modifier, key, sc, ms, dt.now().strftime("%H:%M:%S"))


# --- Rotation thread ---
def run_rotation(main_skill, secondary_skill, main_abilities, secondary_abilities, start_time):
    if not _rotation_lock.acquire(blocking=False):
        return  # Previous rotation still running — skip this tick
    try:
        for ability in main_abilities.values():
            try:
                score = metrics.structural_similarity(ability["image"], main_skill, channel_axis=2)
                if score > SCORE_THRESHOLD:
                    if dprint:
                        print_debug(ability, score, start_time)
                    press_interception_key(ability["key"], ability.get("modifier", False))
                    if ability.get("pause"):
                        time.sleep(ability["pause"])
            except Exception as e:
                print("SSIM failed for main ability", ability["name"], dt.now().strftime("%H:%M:%S"))
                print(e)

        if data[wow_class].get("secondary"):
            for ability in secondary_abilities.values():
                try:
                    score = metrics.structural_similarity(ability["image"], secondary_skill, channel_axis=2)
                    if score > SCORE_THRESHOLD:
                        if dprint:
                            print_debug(ability, score, start_time)
                        press_interception_key(ability["key"], ability.get("modifier", False))
                except Exception as e:
                    print("SSIM failed for offgcd", ability["name"], dt.now().strftime("%H:%M:%S"))
                    print(e)
    finally:
        _rotation_lock.release()


# --- Initial skill load ---
healing = load_skills(wow_class, "healing")
global_skills = load_skills(wow_class, "globals")
main_abilities = {**load_skills(wow_class, "main"), **healing, **global_skills}
secondary_abilities = load_skills(wow_class, "secondary")


# --- Main loop ---
with keyboard.Listener(on_press=on_press) as listener:
    with mss.mss() as sct:
        while True:
            try:
                time.sleep(random.uniform(0.005, 0.01))
                start_time = time.time()

                active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())
                if active_window != WOW_WINDOW:
                    time.sleep(2)
                    continue

                # Grab screen regions
                main_image = sct.grab(p_main)
                offgcd_image = sct.grab(p_offgcd)
                combat = sct.grab(p_combat).pixel(cx, cy)
                interrupt = sct.grab(p_interrupt).pixel(cx, cy)
                clss = sct.grab(p_clss).pixel(cx, cy)

                if debug:
                    mss.tools.to_png(main_image.rgb, main_image.size, output=os.path.join(debug_folder, "1. main.png"))
                    mss.tools.to_png(offgcd_image.rgb, offgcd_image.size, output=os.path.join(debug_folder, "6. offgcd.png"))

                # Class detection
                found_class, wow_class = get_class(clss, COLOR_DISTANCE)
                if not found_class:
                    time.sleep(0.5)
                    pyautogui.hotkey("end" if pause else "home")
                    continue

                # Reload skills if class changed
                if wow_class_loaded != wow_class:
                    print("CLASS:", wow_class_loaded.upper(), "->", wow_class.upper())
                    main_abilities = {**load_skills(wow_class, "main"), **healing, **global_skills}
                    secondary_abilities = load_skills(wow_class, "secondary")
                    wow_class_loaded = wow_class
                    pyautogui.hotkey("end" if pause else "home")

                if not pause:
                    if combat == COMBAT_SKIP:
                        if not out_of_combat:
                            out_of_combat = True
                            pyautogui.hotkey("end")
                        continue
                    else:
                        if out_of_combat:
                            out_of_combat = False
                            pyautogui.hotkey("home")

                    if interrupt == INTERRUPT_COLOR:
                        press_interception_key(INTERRUPT_KEY)
                        continue

                    main_skill = numpy.array(main_image)[:, :, :3]
                    secondary_skill = numpy.array(offgcd_image)[:, :, :3]

                    t = threading.Thread(
                        target=run_rotation,
                        args=(main_skill, secondary_skill, main_abilities, secondary_abilities, start_time),
                        daemon=True,
                    )
                    t.start()

            except KeyboardInterrupt:
                print("Script unloaded and closed.", "Monitor:", screen_width, screen_height, dt.now().strftime("%H:%M:%S"))
                try:
                    sys.exit(130)
                except SystemExit:
                    os._exit(130)
