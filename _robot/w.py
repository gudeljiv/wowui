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
import win32gui
import math

from pynput import keyboard
from pyautogui import *
from os.path import isfile, join
from os import listdir
from os.path import exists
from skimage.metrics import structural_similarity
from win32api import GetSystemMetrics

combat = False
debug = False
dprint = False
pause = True
wow_class = "warrior"

screen_width = GetSystemMetrics(0)
screen_height = GetSystemMetrics(1)

monitor = "4k"
if screen_width == 2560:
    monitor = "2k"

x = 10
y = 10
if monitor == "2k":
    x = 7
    y = 7

file_path = os.path.abspath(__file__)
dir_path = os.path.dirname(os.path.realpath(__file__))

abilities_folder = dir_path + "/images/" + monitor
abilities_list = [f for f in listdir(abilities_folder) if isfile(join(abilities_folder, f))]

abilities = {}
for ability in abilities_list:
    cv2grey = cv2.cvtColor(cv2.imread(abilities_folder + "/" + ability), cv2.COLOR_BGR2GRAY)
    abilities[ability.replace(".png", "")] = cv2grey


print("Script loaded and ready.", "Rotation is paused.", "Monitor:", monitor, abilities_folder)


def on_press(key):
    global debug
    global dprint
    global pause

    try:
        if key == keyboard.Key.f7:
            debug = not debug
            print("debug:", debug)
        if key == keyboard.Key.f12:
            pause = not pause
            if pause:
                if dprint:
                    print("Rotation is paused")
                pyautogui.hotkey("shift", "f2")
            else:
                if dprint:
                    print("Rotation is not paused")
                pyautogui.hotkey("shift", "f1")
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

            p_main = {"top": 0, "left": 0, "width": x*2, "height": y*2}
            p_combat = {"top": 0, "left": monitor == "2k" and 17 or 24, "width": 7, "height": 7}
            p_interrupt = {"top": 0, "left": monitor == "2k" and 27 or 42, "width": 7, "height": 7}
            p_behind = {"top": 0, "left": monitor == "2k" and 38 or 62, "width": 7, "height": 7}
            p_clss = {"top": 0, "left": monitor == "2k" and 49 or 74, "width": 7, "height": 7}

            grabbed_image = dir_path + "/_main.png".format(**p_main)

            main_image = sct.grab(p_main)
            main = main_image.pixel(int(x/2), int(y/2))

            combat_image = sct.grab(p_combat)
            combat = combat_image.pixel(5, 5)
            # mss.tools.to_png(combat_image.rgb, combat_image.size, output="_robot/combat.png".format(**p_combat))

            interrupt_image = sct.grab(p_interrupt)
            interrupt = interrupt_image.pixel(5, 5)
            # mss.tools.to_png(interrupt_image.rgb, interrupt_image.size, output="_robot/interrupt.png".format(**p_interrupt))

            behind_image = sct.grab(p_behind)
            behind = behind_image.pixel(5, 5)
            # mss.tools.to_png(behind_image.rgb, behind_image.size, output="_robot/behind.png".format(**p_behind))

            clss_image = sct.grab(p_clss)
            clss = clss_image.pixel(5, 5)
            # mss.tools.to_png(clss_image.rgb, clss_image.size, output="_robot/clss.png".format(**p_clss))
            hex = '#%02x%02x%02x' % clss

            color_distance = 1000
            # print(hex)
            for c in color:
                rgb = parse_hex_color(c)
                if color_similarity(rgb, clss) < color_distance:
                    color_distance = color_similarity(rgb, clss)
                    hex = c

            try:
                wow_class = color[hex]
            except:
                wow_class = "warrior"

            # print(clss, '#%02x%02x%02x' % clss, wow_class)
            # print(active_window, combat, interrupt, wow_class)

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
                        print("interrupt", "f9", f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
                    pyautogui.hotkey("f9")

                grabbed = cv2.cvtColor(numpy.array(main_image), cv2.COLOR_BGR2GRAY)

                # print(hex, wow_class)

                # rotation
                for skill in skills[wow_class]:
                    start_skills_time = time.time()
                    for ability in abilities:
                        # mss.tools.to_png(main_image.rgb, main_image.size, output=grabbed_image)
                        (score, diff) = structural_similarity(abilities[ability], grabbed, full=True)
                        # print(score*100, ability, skill["name"], f"Finish in: {round(1000 * (time.time() - start_time))} ms ", f"Finish in: {round(1000 * (time.time() - start_skills_time))} ms ")
                        if(score*100 > 90 and ability == skill["name"]):
                            if dprint:
                                print(ability, skill["name"], skill["key"], score*100, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")

                            if "modifier" in skill.keys():
                                pyautogui.hotkey(skill["modifier"],  skill["key"])
                            else:
                                pyautogui.hotkey(skill["key"])

            if debug:
                time.sleep(0.5)
                mss.tools.to_png(main_image.rgb, main_image.size, output=grabbed_image)
                print(grabbed_image, main, combat, interrupt, active_window, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
