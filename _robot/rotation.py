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
mill = False
dprint = False
pause = True
wow_class = "warrior"

screen_width = GetSystemMetrics(0)
screen_height = GetSystemMetrics(1)

monitor = str(screen_width)

if monitor == "3840":
    x = 10
    y = 10
    p_offgcd_left = 105
    p_combat_left = 24
    p_interrupt_left = 42
    p_behind_left = 62
    p_clss_left = 74
    p_rotation_left = 94
if monitor == "2560":
    x = 6
    y = 6
    p_offgcd_left = 70
    p_combat_left = 17
    p_interrupt_left = 27
    p_behind_left = 38
    p_clss_left = 49
    p_rotation_left = 60
if monitor == "3072":
    x = 9
    y = 9
    p_combat_left = 22
    p_offgcd_left = 93
    p_interrupt_left = 37
    p_behind_left = 53
    p_clss_left = 66
    p_rotation_left = 70

file_path = os.path.abspath(__file__)
dir_path = os.path.dirname(os.path.realpath(__file__))

abilities_folder = dir_path + "\images\\" + monitor
# abilities_list = [f for f in listdir(abilities_folder) if isfile(join(abilities_folder, f))]

healing = {}
for skill in skills["healing"]:
    healing[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/" + skill["name"]+".png"), cv2.COLOR_BGR2GRAY)

abilities = {}
# for ability in abilities_list:
#     cv2grey = cv2.cvtColor(cv2.imread(abilities_folder + "/" + ability), cv2.COLOR_BGR2GRAY)
#     abilities[ability.replace(".png", "")] = cv2grey

for skill in skills[wow_class]:
    abilities[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/" + skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
    abilities = {**abilities, **healing}


abilities_offgcd = {}
for skill in skills["offgcd"][wow_class]:
    abilities_offgcd[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/"+skill["name"]+".png"), cv2.COLOR_BGR2GRAY)

skills_loaded = "warrior"
print("Script loaded and ready.", "Rotation is paused.", "Monitor:", screen_width, screen_height)


def on_press(key):
    global debug, dprint, pause, mill

    # print(key)

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
            else:
                if dprint:
                    print("Rotation is not paused")
                pyautogui.hotkey("home")
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
            p_offgcd = {"top": 0, "left":  p_offgcd_left, "width": x*2, "height": y*2}
            p_combat = {"top": 0, "left": p_combat_left, "width": 7, "height": 7}
            p_interrupt = {"top": 0, "left": p_interrupt_left, "width": 7, "height": 7}
            p_behind = {"top": 0, "left": p_behind_left, "width": 7, "height": 7}
            p_clss = {"top": 0, "left": p_clss_left, "width": 7, "height": 7}
            p_rotation = {"top": 0, "left": p_rotation_left, "width": 7, "height": 7}

            grabbed_image = dir_path + "/images/_/main.png".format(**p_main)
            main_image = sct.grab(p_main)
            main = main_image.pixel(int(x/2), int(y/2))
            if debug:
                mss.tools.to_png(main_image.rgb, main_image.size, output=grabbed_image)

            q_image = dir_path + "/images/_/offgcd.png".format(**p_offgcd)
            offgcd_image = sct.grab(p_offgcd)
            offgcd = offgcd_image.pixel(int(x/2), int(y/2))
            if debug:
                mss.tools.to_png(offgcd_image.rgb, offgcd_image.size, output=q_image)

            combat_image = sct.grab(p_combat)
            combat = combat_image.pixel(5, 5)
            if debug:
                mss.tools.to_png(combat_image.rgb, combat_image.size, output="_robot/images/_/combat.png".format(**p_combat))

            interrupt_image = sct.grab(p_interrupt)
            interrupt = interrupt_image.pixel(5, 5)
            if debug:
                mss.tools.to_png(interrupt_image.rgb, interrupt_image.size, output="_robot/images/_/interrupt.png".format(**p_interrupt))

            behind_image = sct.grab(p_behind)
            behind = behind_image.pixel(5, 5)
            if debug:
                mss.tools.to_png(behind_image.rgb, behind_image.size, output="_robot/images/_/behind.png".format(**p_behind))

            clss_image = sct.grab(p_clss)
            clss = clss_image.pixel(5, 5)
            if debug:
                mss.tools.to_png(clss_image.rgb, clss_image.size, output="_robot/images/_/clss.png".format(**p_clss))

            hex = '#%02x%02x%02x' % clss

            # if dprint:
            #     print(hex)

            # matching closest class color to define in colors
            color_distance = 1000
            for c in color:
                rgb = parse_hex_color(c)
                if color_similarity(rgb, clss) <= color_distance:
                    color_distance = color_similarity(rgb, clss)
                    hex = c

            try:
                wow_class = color[hex]
            except:
                wow_class = "warrior"

            if skills_loaded != wow_class:
                print("class changed --> ", skills_loaded, wow_class)
                abilities = {}
                skills_loaded = wow_class
                for skill in skills[wow_class]:
                    try:
                        abilities[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/" + skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
                        abilities = {**abilities, **healing}
                    except:
                        print("missing spell in " + wow_class + " --> " + skill["name"])

                abilities_offgcd = {}
                try:
                    for skill in skills["offgcd"][wow_class]:
                        abilities_offgcd[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/"+skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
                except:
                    print("offgcd error missing class --> ", wow_class)

            # print(clss, '#%02x%02x%02x' % clss, wow_class)
            # print(hex, combat, interrupt, wow_class)
            # for skill in skills[wow_class]:
            #     print(skill)
            # time.sleep(1)
            # continue

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
                offgcd = cv2.cvtColor(numpy.array(offgcd_image), cv2.COLOR_BGR2GRAY)

                # if dprint:
                #     print("class", hex, wow_class)

                # rotation
                try:
                    for skill in skills[wow_class] + skills["healing"]:
                        for ability in abilities:
                            if ability == skill["name"]:
                                # mss.tools.to_png(main_image.rgb, main_image.size, output=grabbed_image)

                                try:
                                    (score, diff) = structural_similarity(abilities[ability], grabbed, full=True)
                                    if score*100 > 90:
                                        if dprint:
                                            print(ability, skill["name"], skill["key"], score*100, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")

                                        if "modifier" in skill.keys():
                                            pyautogui.hotkey(skill["modifier"],  skill["key"])
                                        else:
                                            pyautogui.hotkey(skill["key"])
                                except:
                                    print("score, diff not found for main ability")
                except:
                    print("error skill loop")

                try:
                    for skill in skills["offgcd"][wow_class]:
                        for ability in abilities_offgcd:
                            if ability == skill["name"]:

                                try:
                                    (score, diff) = structural_similarity(abilities_offgcd[ability], offgcd, full=True)
                                    if score*100 > 90:
                                        if dprint:
                                            print(ability, skill["name"], skill["key"], score*100, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")

                                        if "modifier" in skill.keys():
                                            pyautogui.hotkey(skill["modifier"],  skill["key"])
                                        else:
                                            pyautogui.hotkey(skill["key"])
                                except:
                                    print("score, diff not found for offgcd")
                except:
                    print("offgcd error missing class --> ", wow_class)

            # if debug:
            #     time.sleep(0.5)
            #     mss.tools.to_png(main_image.rgb, main_image.size, output=grabbed_image)
            #     print(grabbed_image, main, combat, interrupt, active_window, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")

            if mill:
                pyautogui.hotkey("y")
                time.sleep(0.5)
