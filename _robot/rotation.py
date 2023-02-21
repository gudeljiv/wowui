from _resources import skills
from _resources import color
from _resources import monitor_settings

import time
import _thread

import cv2
import pyautogui

import os
import sys
import mss
import mss.tools
import numpy
import math
import pyperclip
import random

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
dprint = False
pause = True
wow_class = "warrior"
color_distance = 50

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
    abilities_folder = dir_path + "/images/" + monitor
else:
    abilities_folder = dir_path + "\images\\" + monitor

# default class
wow_class_loaded = wow_class
print("Script loaded and ready.", "Rotation is paused.", "Monitor:", screen_width, screen_height, datetime.now().strftime("%H:%M:%S"))


def on_press(key):
    global dprint, pause

    try:
        if key == keyboard.Key.f8:
            dprint = not dprint
            print("dprint:", dprint)

        if key == keyboard.Key.f12:
            pause = not pause
            if pause:
                if dprint:
                    print("Rotation is paused")
                pyautogui.hotkey("end")
                pyautogui.PAUSE = 1
                pyautogui.FAILSAFE = False
            else:
                if dprint:
                    print("Rotation is not paused")
                pyautogui.hotkey("home")
                pyautogui.PAUSE = 0.05
                pyautogui.FAILSAFE = True
    except:
        return


def parse_hex_color(string):
    if string.startswith("#"):
        string = string[1:]
    r = int(string[0:2], 16)  # red color value
    g = int(string[2:4], 16)  # green color value
    b = int(string[4:6], 16)  # blue color value
    return r, g, b


def color_similarity(base_col_val, oth_col_val):
    return math.sqrt(sum((base_col_val[i]-oth_col_val[i])**2 for i in range(3)))


def get_class(clss, color_distance):
    hex = '#%02x%02x%02x' % clss
    found_class = False
    for c in color:
        rgb = parse_hex_color(c)
        # print(color[c], c, rgb, clss, color_similarity(rgb, clss))
        if color_similarity(rgb, clss) <= color_distance:
            color_distance = color_similarity(rgb, clss)
            hex = c
            found_class = True

    return found_class, hex


def load_skills_healing(wow_class):
    # load healing spells
    healing = {}
    try:
        for skill in skills["healing"]:
            healing[skill["name"]] = cv2.imread(abilities_folder + "/" + "healing" + "/" + skill["name"] + " H.png")
    except:
        print("healing abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))

    return healing


def load_skills_globals(wow_class):
    # load global kills
    global_skills = {}
    try:
        for skill in skills["globals"]:
            global_skills[skill["name"]] = cv2.imread(abilities_folder + "/" + "globals" + "/" + skill["name"] + " G.png")
    except:
        print("global abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))

    return global_skills


def load_skills_main(wow_class):
    # load main ability skills
    main_abilities = {}
    try:
        for skill in skills[wow_class]:
            main_abilities[skill["name"]] = cv2.imread(abilities_folder + "/" + wow_class + "/" + skill["name"] + " M.png")
    except:
        print("main abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))

    return main_abilities


def load_skills_secondary(wow_class):
    # load secondary ability skills
    secondary_abilities = {}
    try:
        for skill in skills["offgcd"][wow_class]:
            secondary_abilities[skill["name"]] = cv2.imread(abilities_folder + "/" + wow_class + "/" + skill["name"] + " O.png")
    except:
        print("offgcd abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))

    return secondary_abilities


def main_rotation():
    try:
        for skill in skills[wow_class] + skills["healing"] + skills["globals"]:
            for ability in main_abilities:
                if ability == skill["name"]:
                    try:
                        score = structural_similarity(main_abilities[ability], main_skill, channel_axis=2)
                        if score*100 > 90:
                            if dprint:
                                print(ability, skill["name"], skill["key"], score*100, f"Finish in: {round(1000 * (time.time() - start_time))} ms ", datetime.now().strftime("%H:%M:%S"))

                            if "modifier" in skill.keys():
                                pyautogui.hotkey(skill["modifier"],  skill["key"])
                            else:
                                pyautogui.hotkey(skill["key"])
                    except:
                        print("score, diff not found for main ability", ability, skill["name"], datetime.now().strftime("%H:%M:%S"))
    except:
        print("error skill loop", datetime.now().strftime("%H:%M:%S"))


def secondary_rotation():
    try:
        if skills["offgcd"] and skills["offgcd"][wow_class]:
            for skill in skills["offgcd"][wow_class]:
                for ability in secondary_abilities:
                    if ability == skill["name"]:
                        try:
                            score = structural_similarity(secondary_abilities[ability], secondary_skill, channel_axis=2)
                            if score*100 > 90:
                                if dprint:
                                    print(ability, skill["name"], skill["key"], score*100,
                                          f"Finish in: {round(1000 * (time.time() - start_time))} ms ", datetime.now().strftime("%H:%M:%S"))

                                if "modifier" in skill.keys():
                                    pyautogui.hotkey(skill["modifier"],  skill["key"])
                                else:
                                    pyautogui.hotkey(skill["key"])
                        except:
                            print("score, diff not found for offgcd", ability, skill["name"], datetime.now().strftime("%H:%M:%S"))
    except:
        print("offgcd error missing class --> ", wow_class, datetime.now().strftime("%H:%M:%S"))


# load skills for default class -- warrior
healing = load_skills_healing(wow_class)
global_skills = load_skills_globals(wow_class)
main_abilities = load_skills_main(wow_class)
main_abilities = {**main_abilities, **healing, **global_skills}
secondary_abilities = load_skills_secondary(wow_class)

with keyboard.Listener(on_press=on_press) as listener:

    with mss.mss() as sct:

        while True:

            time.sleep(random.uniform(0.001, 0.1))

            start_time = time.time()
            if os.name != "posix":
                active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

# defining regions
            p_main = {"top": 2, "left": 2, "width": x, "height": y}
            p_offgcd = {"top": 2, "left":  p_offgcd_left, "width": x, "height": y}
            p_combat = {"top": 0, "left": p_combat_left, "width": c_width, "height": c_height}
            p_interrupt = {"top": 0, "left": p_interrupt_left, "width": c_width, "height": c_height}
            p_behind = {"top": 0, "left": p_behind_left, "width": c_width, "height": c_height}
            p_clss = {"top": 0, "left": p_clss_left, "width": c_width, "height": c_height}

# grabbing images from regions
            main_image = sct.grab(p_main)
            offgcd_image = sct.grab(p_offgcd)
            combat = sct.grab(p_combat).pixel(math.floor(c_width/2), math.floor(c_height/2))
            interrupt = sct.grab(p_interrupt).pixel(math.floor(c_width/2), math.floor(c_height/2))
            behind = sct.grab(p_behind).pixel(math.floor(c_width/2), math.floor(c_height/2))
            clss = sct.grab(p_clss).pixel(math.floor(c_width/2), math.floor(c_height/2))


# matching closest class color to define in colors
            found_class, hex = get_class(clss, color_distance)
            if not found_class:
                continue

# defining class
            try:
                wow_class = color[hex]
            except:
                wow_class = "warrior"

# loading skills for a class if changed
            if wow_class_loaded != wow_class:
                print("class changed: ", wow_class_loaded, "->", wow_class, "..", hex, clss, color_distance, color[hex], datetime.now().strftime("%H:%M:%S"))
                main_abilities = load_skills_main(wow_class)
                secondary_abilities = load_skills_secondary(wow_class)
                main_abilities = {**main_abilities, **healing, **global_skills}
                wow_class_loaded = wow_class

# actual rotation
            if not pause:

                if os.name != "posix":
                    if active_window != "World of Warcraft":
                        continue

                # skipping combat, chat open
                # any other reason
                # (white -> skip, green -> combat)
                if combat == (255, 255, 255):
                    continue

# interrupt indicator
                # white --> green
                if interrupt == (0, 255, 0):
                    if dprint:
                        print("interrupt", "f9", f"Finish in: {round(1000 * (time.time() - start_time))} ms ", datetime.now().strftime("%H:%M:%S"))
                    pyautogui.hotkey("f9")

                main_skill = numpy.array(main_image)[:, :, :3]
                secondary_skill = numpy.array(offgcd_image)[:, :, :3]

    # rotation
                _thread.start_new_thread(main_rotation, ())
                _thread.start_new_thread(secondary_rotation, ())
