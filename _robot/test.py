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
    x = 10
    y = 10
    c_width = 7
    c_height = 7
    p_offgcd_left = 105
    p_combat_left = 24
    p_interrupt_left = 42
    p_behind_left = 62
    p_clss_left = 74
    p_rotation_left = 94
if monitor == "2560":
    x = 6
    y = 6
    c_width = 7
    c_height = 7
    p_offgcd_left = 70
    p_combat_left = 17
    p_interrupt_left = 27
    p_behind_left = 38
    p_clss_left = 49
    p_rotation_left = 60
if monitor == "3072":
    x = 9
    y = 9
    c_width = 7
    c_height = 7
    p_combat_left = 22
    p_offgcd_left = 93
    p_interrupt_left = 37
    p_behind_left = 53
    p_clss_left = 66
    p_rotation_left = 70
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

abilities_folder = dir_path + "\images\\" + monitor
# abilities_list = [f for f in listdir(abilities_folder) if isfile(join(abilities_folder, f))]

print(abilities_folder)

healing = {}
try:
    for skill in skills["healing"]:
        healing[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/" + skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
except:
    print("healing skills missing", datetime.now().strftime("%H:%M:%S"))

abilities = {}
# for ability in abilities_list:
#     cv2grey = cv2.cvtColor(cv2.imread(abilities_folder + "/" + ability), cv2.COLOR_BGR2GRAY)
#     abilities[ability.replace(".png", "")] = cv2grey
try:
    for skill in skills[wow_class]:
        abilities[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/" + skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
        abilities = {**abilities, **healing}
except:
    print("main skills missing", datetime.now().strftime("%H:%M:%S"))


abilities_offgcd = {}
try:
    for skill in skills["offgcd"][wow_class]:
        abilities_offgcd[skill["name"]] = cv2.cvtColor(cv2.imread(abilities_folder + "/"+skill["name"]+".png"), cv2.COLOR_BGR2GRAY)
except:
    print("offgcd skills missing", datetime.now().strftime("%H:%M:%S"))


skills_loaded = "warrior"
print("Script loaded and ready.", "Rotation is paused.", "Monitor:", screen_width, screen_height, datetime.now().strftime("%H:%M:%S"))


def on_press(key):
    global debug, dprint, pause, mill
    # print(key)
    if key == keyboard.Key.f7:
        debug = not debug
        print("debug:", debug)


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
            if os.name == "posix":
                active_window = NSWorkspace.sharedWorkspace().activeApplication()["NSApplicationBundleIdentifier"]
            else:
                active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

            # print(active_window)

            if active_window != "com.blizzard.worldofwarcraft":
                continue

            if debug:
                p_main = {"top": 2, "left": 2, "width": x, "height": y}
                p_offgcd = {"top": 2, "left":  p_offgcd_left, "width": x, "height": y}
                p_combat = {"top": 0, "left": p_combat_left, "width": c_width, "height": c_height}
                p_interrupt = {"top": 0, "left": p_interrupt_left, "width": c_width, "height": c_height}
                p_behind = {"top": 0, "left": p_behind_left, "width": c_width, "height": c_height}
                p_clss = {"top": 0, "left": p_clss_left, "width": c_width, "height": c_height}

                grabbed_image = dir_path + "/images/_/1. main.png".format(**p_main)
                main_image = sct.grab(p_main)
                mss.tools.to_png(main_image.rgb, main_image.size, output=grabbed_image)

                q_image = dir_path + "/images/_/6. offgcd.png".format(**p_offgcd)
                offgcd_image = sct.grab(p_offgcd)
                mss.tools.to_png(offgcd_image.rgb, offgcd_image.size, output=q_image)

                combat_image = sct.grab(p_combat)
                combat = combat_image.pixel(math.floor(c_width/2), math.floor(c_height/2))
                mss.tools.to_png(combat_image.rgb, combat_image.size, output="_robot/images/_/2. combat.png".format(**p_combat))

                interrupt_image = sct.grab(p_interrupt)
                interrupt = interrupt_image.pixel(math.floor(c_width/2), math.floor(c_height/2))
                mss.tools.to_png(interrupt_image.rgb, interrupt_image.size, output="_robot/images/_/3. interrupt.png".format(**p_interrupt))

                behind_image = sct.grab(p_behind)
                behind = behind_image.pixel(math.floor(c_width/2), math.floor(c_height/2))
                mss.tools.to_png(behind_image.rgb, behind_image.size, output="_robot/images/_/4. behind.png".format(**p_behind))

                clss_image = sct.grab(p_clss)
                clss = clss_image.pixel(math.floor(c_width/2), math.floor(c_height/2))
                mss.tools.to_png(clss_image.rgb, clss_image.size, output="_robot/images/_/5. clss.png".format(**p_clss))

                hex = '#%02x%02x%02x' % clss



