import sys

if len(sys.argv) != 2:
    mode = "wotlk"
else:
    mode = sys.argv[1]

if mode == "wotlk":
    from libs.resources_wotlk import data, monitor_settings
elif mode == "tbc":
    from libs.resources_tbc import data, monitor_settings
else:
    from libs.resources_classic import data, monitor_settings

import time
import pyautogui
import os
import mss
import mss.tools
import math
import pyperclip

if os.name == "posix":
    from AppKit import NSScreen
    from AppKit import NSWorkspace
else:
    import win32gui
    from win32api import GetSystemMetrics

from pynput import keyboard
from pyautogui import *
from os.path import isfile, join
from os import listdir
from os.path import exists
from skimage.metrics import structural_similarity
from datetime import datetime

combat = False
debug = False
mill = False
dprint = False
pause = True
wow_class = "warrior"
wow_class_loaded = wow_class

if os.name == "posix":
    screen_width = NSScreen.mainScreen().frame().size.width
    screen_height = NSScreen.mainScreen().frame().size.height
else:
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

file_path = os.path.abspath(__file__)
dir_path = os.path.dirname(os.path.realpath(__file__))

if os.name == "posix":
    abilities_folder = dir_path + "/images/" + mode + "/" + monitor
    slash = "/"
else:
    abilities_folder = dir_path + r"\images\\" + mode + r"\\" + monitor
    slash = "\\"

if not os.path.exists(abilities_folder):
    os.makedirs(abilities_folder)

skills_loaded = "warrior"
print("Script loaded and ready.", "Monitor:", screen_width, screen_height, datetime.now().strftime("%H:%M:%S"), os.name)
print("MODE:", mode.upper())
print("CLASS:", wow_class_loaded.upper())

# ---------------------------------------------------------------------------
# Timing constants — tweak here if screenshots still catch the wrong frame
# ---------------------------------------------------------------------------
CHAT_OPEN_WAIT = 0.08   # after pressing Enter to open chat
CLIP_VERIFY_TIMEOUT = 1.0  # max seconds to wait for clipboard to settle
CLIP_POLL = 0.03        # poll interval while verifying clipboard
PASTE_SETTLE = 0.08     # after Ctrl+V before pressing Enter
RENDER_WAIT = 0.40      # after command executes before taking screenshot
INTER_SKILL = 0.15      # gap between skills
# ---------------------------------------------------------------------------


def on_press(key):
    global debug, dprint, pause, mill
    try:
        if key == keyboard.Key.f12:
            debug = not debug
            print("debug:", debug)
    except:
        return


def parse_hex_color(string):
    if string.startswith("#"):
        string = string[1:]
    r = int(string[0:2], 16)
    g = int(string[2:4], 16)
    b = int(string[4:6], 16)
    return r, g, b


def color_similarity(base_col_val, oth_col_val):
    return math.sqrt(sum((base_col_val[i] - oth_col_val[i]) ** 2 for i in range(3)))


def print_debug(no, xclass, skill, id, image):
    print(no, xclass, skill, id)


def set_clipboard(text):
    """Copy text and wait until the clipboard actually contains it."""
    deadline = time.time() + CLIP_VERIFY_TIMEOUT
    while time.time() < deadline:
        pyperclip.copy(text)
        time.sleep(CLIP_POLL)
        if pyperclip.paste() == text:
            return True
    print(f"  [WARN] clipboard never settled for: {text}")
    return False


def send_command(command):
    """Open chat, paste verified clipboard content, execute. Returns True on success."""
    pyautogui.hotkey("enter")
    time.sleep(CHAT_OPEN_WAIT)

    if not set_clipboard(command):
        pyautogui.hotkey("escape")  # close chat without sending garbage
        return False

    if os.name == "posix":
        pyautogui.hotkey("command", "v")
    else:
        pyautogui.hotkey("ctrl", "v")

    time.sleep(PASTE_SETTLE)
    pyautogui.hotkey("enter")  # execute and close chat
    return True


def grab_screenshot(sct, region):
    """Wait for the game to render the new texture, then capture."""
    time.sleep(RENDER_WAIT)
    return sct.grab(region)


classes = {"warrior", "druid", "rogue", "warlock", "mage", "hunter", "death knight", "priest", "paladin", "shaman"}

count = 0
number = 0
s, t = "", ""
color_distance = 10


def get_class(clss, color_distance):
    found_class = False
    global wow_class
    for item in data["colors"]:
        for c in data["colors"][item]:
            rgb = parse_hex_color(c)
            if color_similarity(rgb, clss) <= color_distance:
                found_class = True
                wow_class = item
    return found_class, wow_class


try:
    with keyboard.Listener(on_press=on_press) as listener:
        with mss.mss() as sct:
            while True:
                start_time = time.time()

                p_main      = {"top": 2, "left": 2,               "width": x,       "height": y}
                p_offgcd    = {"top": 2, "left": p_offgcd_left,   "width": x,       "height": y}
                p_combat    = {"top": 0, "left": p_combat_left,   "width": c_width, "height": c_height}
                p_interrupt = {"top": 0, "left": p_interrupt_left,"width": c_width, "height": c_height}
                p_behind    = {"top": 0, "left": p_behind_left,   "width": c_width, "height": c_height}
                p_clss      = {"top": 0, "left": p_clss_left,     "width": c_width, "height": c_height}

                clss_image = sct.grab(p_clss)
                clss = clss_image.pixel(math.floor(c_width / 2), math.floor(c_height / 2))
                hex = "#%02x%02x%02x" % clss

                time.sleep(1)

                found_class = False
                found_class, wow_class = get_class(clss, color_distance)
                if not found_class:
                    print(found_class, wow_class, hex)
                    continue

                if wow_class_loaded != wow_class:
                    print("class:", wow_class_loaded.upper(), "->", wow_class.upper())
                    wow_class_loaded = wow_class

                folders = [
                    abilities_folder + slash + wow_class,
                    abilities_folder + slash + "healing",
                    abilities_folder + slash + "globals",
                ]
                for folder in folders:
                    if not os.path.exists(folder):
                        os.makedirs(folder)

                if count > 0:
                    quit()

                if debug:
                    count += 1

                    # --- main skills ---
                    for skill in data[wow_class]["main"]:
                        number += 1
                        t = skill["type"] == "GetSpellTexture" and 1 or 2
                        s = skill["id"]
                        if not send_command("/run xRTF(1," + str(t) + "," + str(s) + ")"):
                            continue
                        m_image = abilities_folder + slash + wow_class + slash + str(skill["name"]) + " M.png"
                        main_image = grab_screenshot(sct, p_main)
                        mss.tools.to_png(main_image.rgb, main_image.size, output=m_image)
                        print_debug(number, wow_class, skill["name"], skill["id"],
                                    abilities_folder + slash + wow_class + slash + skill["name"] + " M.png")
                        time.sleep(INTER_SKILL)

                    # --- secondary / off-gcd skills ---
                    for skill in data[wow_class]["secondary"]:
                        number += 1
                        t = skill["type"] == "GetSpellTexture" and 1 or 2
                        s = skill["id"]
                        if not send_command("/run xRTF(2," + str(t) + "," + str(s) + ")"):
                            continue
                        o_image = abilities_folder + slash + wow_class + slash + str(skill["name"]) + " O.png"
                        offgcd_image = grab_screenshot(sct, p_offgcd)
                        mss.tools.to_png(offgcd_image.rgb, offgcd_image.size, output=o_image)
                        print_debug(number, wow_class, skill["name"], skill["id"],
                                    abilities_folder + slash + wow_class + slash + skill["name"] + " O.png")
                        time.sleep(INTER_SKILL)

                    # --- healing skills ---
                    for skill in data["healing"]:
                        number += 1
                        t = skill["type"] == "GetSpellTexture" and 1 or 2
                        s = skill["id"]
                        if not send_command("/run xRTF(1," + str(t) + "," + str(s) + ")"):
                            continue
                        m_image = abilities_folder + slash + "healing" + slash + str(skill["name"]) + " H.png"
                        main_image = grab_screenshot(sct, p_main)
                        mss.tools.to_png(main_image.rgb, main_image.size, output=m_image)
                        print_debug(number, wow_class, skill["name"], skill["id"],
                                    abilities_folder + slash + "healing" + slash + skill["name"] + " H.png")
                        time.sleep(INTER_SKILL)

                    # --- global skills ---
                    for skill in data["globals"]:
                        number += 1
                        t = skill["type"] == "GetSpellTexture" and 1 or 2
                        s = skill["id"]
                        if not send_command("/run xRTF(1," + str(t) + "," + str(s) + ")"):
                            continue
                        m_image = abilities_folder + slash + "globals" + slash + str(skill["name"]) + " G.png"
                        main_image = grab_screenshot(sct, p_main)
                        mss.tools.to_png(main_image.rgb, main_image.size, output=m_image)
                        print_debug(number, wow_class, skill["name"], skill["id"],
                                    abilities_folder + slash + "globals" + slash + skill["name"] + " G.png")
                        time.sleep(INTER_SKILL)

                    # --- hide frames ---
                    send_command("/run xRTFH(1)")
                    send_command("/run xRTFH(2)")

except KeyboardInterrupt:
    print("\nScript closed.")
    sys.exit(0)
