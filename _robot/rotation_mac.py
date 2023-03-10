from libs.resources import skills
from libs.resources import color
from libs.resources import monitor_settings
from libs.resources import keyCodeMap


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
import random

from AppKit import NSScreen
from AppKit import NSWorkspace
from libs.resources import keyCodeMap_OSX

from pynput import keyboard
from pyautogui import *
from os.path import isfile, join
from os import listdir
from os.path import exists
from skimage.metrics import structural_similarity
from datetime import datetime


combat = False
dprint = False
debug = False
pause = True
wow_class = "warrior"
color_distance = 50

screen_width = NSScreen.mainScreen().frame().size.width
screen_height = NSScreen.mainScreen().frame().size.height

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

abilities_folder = dir_path + "/images/" + monitor
debug_folder = dir_path + "/images/_/"


# default class
wow_class_loaded = wow_class
print("Script loaded and ready.", "Monitor:", screen_width, screen_height, datetime.now().strftime("%H:%M:%S"))
print("print:", dprint)
print("debug:", debug)
print("rotation:", not pause)


def toKeyCode(c):
    keyCode = keyCodeMap[c]
    return int(keyCode, base=16)


def get_keyboard_driver():
    for i in range(MAX_DEVICES):
        if interception.is_keyboard(i):
            keyboard = i
            return keyboard


def PressKey(key):
    interception_press = key_stroke(key, interception_key_state.INTERCEPTION_KEY_DOWN.value, 0)
    driver.send(get_keyboard_driver(), interception_press)
    return interception_press


def ReleaseKey(interception_press):
    interception_press.state = interception_key_state.INTERCEPTION_KEY_UP.value
    driver.send(get_keyboard_driver(), interception_press)


def press_interception_key(key, modifier=False):

    m = modifier and toKeyCode(modifier.upper())

    if m:
        rm = PressKey(m)
    r = PressKey(toKeyCode(key.upper()))
    ReleaseKey(r)
    if m:
        ReleaseKey(rm)


def on_press(key):
    global dprint, pause, debug

    try:
        if key == keyboard.Key.f8:
            dprint = not dprint
            print("print:", dprint)

        if key == keyboard.Key.f11:
            debug = not debug
            print("debug:", debug)

        if key == keyboard.Key.f12:
            pause = not pause
            print("rotation:", not pause)
            if pause:
                pyautogui.hotkey("end")
                pyautogui.PAUSE = 1
                pyautogui.FAILSAFE = False
            else:
                pyautogui.hotkey("home")
                pyautogui.PAUSE = 0.1
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
    healing = dict()
    try:
        for skill in skills["healing"]:
            if not skill["name"] in healing:
                healing[skill["name"]] = {}
            healing[skill["name"]]["image"] = cv2.imread(abilities_folder + "/" + "healing" + "/" + skill["name"] + " H.png")
            if "modifier" in skill.keys():
                healing[skill["name"]]["modifier"] = skill["modifier"]
            healing[skill["name"]]["key"] = skill["key"]
            healing[skill["name"]]["name"] = skill["name"]
    except Exception as e:
        print(e)
        print("healing abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))

    return healing


def load_skills_globals(wow_class):
    # load global kills
    global_skills = dict()
    try:
        for skill in skills["globals"]:
            if not skill["name"] in global_skills:
                global_skills[skill["name"]] = {}
            global_skills[skill["name"]]["image"] = cv2.imread(abilities_folder + "/" + "globals" + "/" + skill["name"] + " G.png")
            if "modifier" in skill.keys():
                global_skills[skill["name"]]["modifier"] = skill["modifier"]
            global_skills[skill["name"]]["key"] = skill["key"]
            global_skills[skill["name"]]["name"] = skill["name"]
    except Exception as e:
        print(e)
        print("global abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))

    return global_skills


def load_skills_main(wow_class):
    # load main ability skills
    main_abilities = dict()
    try:
        for skill in skills[wow_class]:
            if not skill["name"] in main_abilities:
                main_abilities[skill["name"]] = {}
            main_abilities[skill["name"]]["image"] = cv2.imread(abilities_folder + "/" + wow_class + "/" + skill["name"] + " M.png")
            if "modifier" in skill.keys():
                main_abilities[skill["name"]]["modifier"] = skill["modifier"]
            main_abilities[skill["name"]]["key"] = skill["key"]
            main_abilities[skill["name"]]["name"] = skill["name"]
    except Exception as e:
        print(e)
        print("main abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))

    return main_abilities


def load_skills_secondary(wow_class):
    # load secondary ability skills
    secondary_abilities = dict()
    try:
        for skill in skills["offgcd"][wow_class]:
            if not skill["name"] in secondary_abilities:
                secondary_abilities[skill["name"]] = {}
            secondary_abilities[skill["name"]]["image"] = cv2.imread(abilities_folder + "/" + wow_class + "/" + skill["name"] + " O.png")
            if "modifier" in skill.keys():
                secondary_abilities[skill["name"]]["modifier"] = skill["modifier"]
            secondary_abilities[skill["name"]]["key"] = skill["key"]
            secondary_abilities[skill["name"]]["name"] = skill["name"]
    except Exception as e:
        print(e)
        print("offgcd abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))

    return secondary_abilities


def print_debug(ability, score=False):
    skill = '{0: <25}'.format(ability["name"])
    modifier = "modifier" in ability.keys() and '{0: <8}'.format(ability["modifier"]) or '{0: <8}'.format("none")
    key = '{0: <5}'.format(ability["key"])
    score = '{0: <8}'.format('{:.2f}'.format(score*100))
    ms = '{0: <8}'.format(f"{round(1000 * (time.time() - start_time))} ms")
    dtime = '{0: <20}'.format(datetime.now().strftime("%H:%M:%S"))
    print(skill, modifier, key, score, ms, dtime)


def main_rotation(main_skill, main_abilities):
    global pause
    try:
        for key, ability in main_abilities.items():
            try:
                score = structural_similarity(ability["image"], main_skill, channel_axis=2)
                if score*100 > 90:
                    if dprint:
                        print_debug(ability, score)

                    if "modifier" in ability.keys():
                        pyautogui.hotkey(keyCodeMap_OSX[ability["modifier"].upper()], ability["key"])
                    else:
                        pyautogui.hotkey(ability["key"])
            except Exception as e:
                print(e)
                print("score, diff not found for main ability", ability["name"], datetime.now().strftime("%H:%M:%S"))
                pause = True
    except Exception as e:
        print(e)
        print("error skill loop", datetime.now().strftime("%H:%M:%S"))
        pause = True


def secondary_rotation(secondary_skill, secondary_abilities):
    global pause
    try:
        if skills["offgcd"] and skills["offgcd"][wow_class]:
            for key, ability in secondary_abilities.items():
                try:
                    score = structural_similarity(ability["image"], secondary_skill, channel_axis=2)
                    if score*100 > 90:
                        if dprint:
                            print_debug(ability, score)

                        if "modifier" in ability.keys():
                            pyautogui.hotkey(keyCodeMap_OSX[ability["modifier"].upper()], ability["key"])
                        else:
                            pyautogui.hotkey(ability["key"])
                except Exception as e:
                    print(e)
                    print("score, diff not found for offgcd", ability["name"], datetime.now().strftime("%H:%M:%S"))
                    pause = True
    except Exception as e:
        print(e)
        print("offgcd error missing class --> ", wow_class, datetime.now().strftime("%H:%M:%S"))
        pause = True


# load skills for default class -- warrior
healing = load_skills_healing(wow_class)
global_skills = load_skills_globals(wow_class)
main_abilities = load_skills_main(wow_class)
main_abilities = {**main_abilities, **healing, **global_skills}
secondary_abilities = load_skills_secondary(wow_class)


def whole_rotation(main_skill, secondary_skill, main_abilities, secondary_abilities):
    main_rotation(main_skill, main_abilities)
    secondary_rotation(secondary_skill, secondary_abilities)


with keyboard.Listener(on_press=on_press) as listener:

    with mss.mss() as sct:

        while True:

            try:
                time.sleep(random.uniform(0.001, 0.03))

                start_time = time.time()

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

                if debug:
                    mss.tools.to_png(main_image.rgb, main_image.size, output=debug_folder + "1. main.png".format(**p_main))
                    mss.tools.to_png(offgcd_image.rgb, offgcd_image.size, output=debug_folder + "6. offgcd.png".format(**p_offgcd))

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
                    # print("class changed: ", wow_class_loaded, "->", wow_class, "..", hex, clss, color_distance, color[hex], datetime.now().strftime("%H:%M:%S"))
                    print("class changed:", wow_class_loaded.upper(), "->", wow_class.upper())
                    main_abilities = load_skills_main(wow_class)
                    secondary_abilities = load_skills_secondary(wow_class)
                    main_abilities = {**main_abilities, **healing, **global_skills}
                    wow_class_loaded = wow_class
                    pyautogui.hotkey(pause and "end" or "home")

    # actual rotation
                if not pause:

                    # skipping combat, chat open
                    # any other reason
                    # (white -> skip, green -> combat)
                    if combat == (255, 255, 255):
                        continue

    # interrupt indicator
                    # white --> green
                    if interrupt == (0, 255, 0):
                        pyautogui.hotkey("f9")

                    main_skill = numpy.array(main_image)[:, :, :3]
                    secondary_skill = numpy.array(offgcd_image)[:, :, :3]

        # rotation
                    main_rotation(main_skill, main_abilities)
                    secondary_rotation(secondary_skill, secondary_abilities)

            except KeyboardInterrupt:
                print("Script unloaded and closed.", "Monitor:", screen_width, screen_height, datetime.now().strftime("%H:%M:%S"))
                try:
                    sys.exit(130)
                except SystemExit:
                    os._exit(130)
