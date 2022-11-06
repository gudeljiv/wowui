from _skills import skills
from _colors import color
import time

import cv2
import pyautogui

import os
import sys
import mss
import mss.tools
import numpy
import math
import pyperclip

if(os.name == "posix"):
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

if os.name == "posix":
    screen_width = NSScreen.mainScreen().frame().size.width
    screen_height = NSScreen.mainScreen().frame().size.height
else:
    screen_width = GetSystemMetrics(0)
    screen_height = GetSystemMetrics(1)

monitor = str(screen_width)

if monitor == "3840":
    x = 15
    y = 15
    c_width = 7
    c_height = 7
    p_offgcd_left = 21
    p_combat_left = 39
    p_interrupt_left = 57
    p_behind_left = 74
    p_clss_left = 88
if monitor == "2560":
    x = 8
    y = 8
    c_width = 5
    c_height = 5
    p_offgcd_left = 15
    p_combat_left = 26
    p_interrupt_left = 37
    p_behind_left = 47
    p_clss_left = 60
if monitor == "3072":
    x = 12
    y = 12
    c_width = 5
    c_height = 5
    p_offgcd_left = 19
    p_combat_left = 40
    p_interrupt_left = 54
    p_behind_left = 64
    p_clss_left = 77
if monitor == "2048.0":
    x = 8
    y = 8
    c_width = 5
    c_height = 5
    p_offgcd_left = 13
    p_combat_left = 24
    p_interrupt_left = 33
    p_behind_left = 43
    p_clss_left = 52

file_path = os.path.abspath(__file__)
dir_path = os.path.dirname(os.path.realpath(__file__))

if os.name == "posix":
    abilities_folder = dir_path + "/images/" + monitor
else:
    abilities_folder = dir_path + "\images\\" + monitor

healing = {}
try:
    for skill in skills["healing"]:
        healing[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/" + skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
except:
    print("healing abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))

abilities = {}
try:
    for skill in skills[wow_class]:
        abilities[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/" + skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
        abilities = {**abilities, **healing}
except:
    print("main abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))


abilities_offgcd = {}
try:
    for skill in skills["offgcd"][wow_class]:
        abilities_offgcd[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/"+skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
except:
    print("offgcd abilities missing", wow_class, datetime.now().strftime("%H:%M:%S"))

skills_loaded = "warrior"
print("Script loaded and ready.", "Rotation is paused.", "Monitor:", screen_width, screen_height, datetime.now().strftime("%H:%M:%S"))


def on_press(key):
    global debug, dprint, pause, mill

    try:
        if key == keyboard.Key.pause:
            mill = not mill

        if key == keyboard.Key.f7:
            debug = not debug
            print("debug:", debug)
        if key == keyboard.Key.f12:
            pause = not pause
            if pause:
                if dprint:
                    print("Rotation is paused")
                pyautogui.hotkey("end")
                # pyautogui.PAUSE = 2
            else:
                if dprint:
                    print("Rotation is not paused")
                pyautogui.hotkey("home")
                # pyautogui.PAUSE = 0
        if key == keyboard.Key.f8:
            dprint = not dprint
            print("dprint:", dprint)
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


with keyboard.Listener(on_press=on_press) as listener:

    with mss.mss() as sct:

        while True:
            start_time = time.time()
            active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

            p_main = {"top": 2, "left": 2, "width": x, "height": y}
            p_offgcd = {"top": 2, "left":  p_offgcd_left, "width": x, "height": y}
            p_combat = {"top": 0, "left": p_combat_left, "width": c_width, "height": c_height}
            p_interrupt = {"top": 0, "left": p_interrupt_left, "width": c_width, "height": c_height}
            p_behind = {"top": 0, "left": p_behind_left, "width": c_width, "height": c_height}
            p_clss = {"top": 0, "left": p_clss_left, "width": c_width, "height": c_height}
            # p_rotation = {"top": 0, "left": p_rotation_left, "width": c_width, "height": c_height}

            grabbed_image = dir_path + "/images/_/1. main.png".format(**p_main)
            main_image = sct.grab(p_main)
            # main = main_image.pixel(int(x/2), int(y/2))
            if debug:
                mss.tools.to_png(main_image.rgb, main_image.size, output=grabbed_image)

            q_image = dir_path + "/images/_/6. offgcd.png".format(**p_offgcd)
            offgcd_image = sct.grab(p_offgcd)
            # offgcd = offgcd_image.pixel(int(x/2), int(y/2))
            if debug:
                mss.tools.to_png(offgcd_image.rgb, offgcd_image.size, output=q_image)

            combat_image = sct.grab(p_combat)
            combat = combat_image.pixel(math.floor(c_width/2), math.floor(c_height/2))
            if debug:
                mss.tools.to_png(combat_image.rgb, combat_image.size, output="_robot/images/_/2. combat.png".format(**p_combat))

            interrupt_image = sct.grab(p_interrupt)
            interrupt = interrupt_image.pixel(math.floor(c_width/2), math.floor(c_height/2))
            if debug:
                mss.tools.to_png(interrupt_image.rgb, interrupt_image.size, output="_robot/images/_/3. interrupt.png".format(**p_interrupt))

            behind_image = sct.grab(p_behind)
            behind = behind_image.pixel(math.floor(c_width/2), math.floor(c_height/2))
            if debug:
                mss.tools.to_png(behind_image.rgb, behind_image.size, output="_robot/images/_/4. behind.png".format(**p_behind))

            clss_image = sct.grab(p_clss)
            clss = clss_image.pixel(math.floor(c_width/2), math.floor(c_height/2))
            if debug:
                mss.tools.to_png(clss_image.rgb, clss_image.size, output="_robot/images/_/5. clss.png".format(**p_clss))

            hex = '#%02x%02x%02x' % clss

            # matching closest class color to define in colors
            color_distance = 50
            found_class = False
            for c in color:
                rgb = parse_hex_color(c)
                # print(color[c], c, rgb, clss, color_similarity(rgb, clss))
                if color_similarity(rgb, clss) <= color_distance:
                    color_distance = color_similarity(rgb, clss)
                    hex = c
                    found_class = True

            if not found_class:
                continue

            try:
                wow_class = color[hex]
            except:
                wow_class = "warrior"

            if skills_loaded != wow_class:
                print("class changed: ", skills_loaded, "->", wow_class, "..", hex, clss, color_distance, color[hex], datetime.now().strftime("%H:%M:%S"))
                abilities = {}
                skills_loaded = wow_class
                for skill in skills[wow_class]:
                    try:
                        abilities[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/" + skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
                        abilities = {**abilities, **healing}
                    except:
                        print("missing spell in ", wow_class, " --> ", skill["name"], datetime.now().strftime("%H:%M:%S"))

                abilities_offgcd = {}
                try:
                    for skill in skills["offgcd"][wow_class]:
                        abilities_offgcd[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/"+skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
                except:
                    print("offgcd error missing class --> ", wow_class, datetime.now().strftime("%H:%M:%S"))

            if not debug and not pause:

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

                grabbed = cv2.cvtColor(numpy.array(main_image), cv2.COLOR_BGR2GRAY)
                offgcd = cv2.cvtColor(numpy.array(offgcd_image), cv2.COLOR_BGR2GRAY)

                # rotation
                try:
                    for skill in skills[wow_class] + skills["healing"]:
                        for ability in abilities:
                            if ability == skill["name"]:
                                try:
                                    (score, diff) = structural_similarity(abilities[ability], grabbed, full=True)
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

                try:
                    if skills["offgcd"] and skills["offgcd"][wow_class]:
                        for skill in skills["offgcd"][wow_class]:
                            for ability in abilities_offgcd:
                                if ability == skill["name"]:

                                    try:
                                        (score, diff) = structural_similarity(abilities_offgcd[ability], offgcd, full=True)
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

            # if debug:
            #     time.sleep(0.5)
            #     mss.tools.to_png(main_image.rgb, main_image.size, output=grabbed_image)
            #     print(grabbed_image, main, combat, interrupt, active_window, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")

            if mill:
                pyautogui.hotkey("x")
                time.sleep(0.5)
