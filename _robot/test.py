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
    x = 12
    y = 12
    c_width = 5
    c_height = 5
    p_offgcd_left = 19
    p_combat_left = 40
    p_interrupt_left = 54
    p_behind_left = 64
    p_clss_left = 77
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

print("Script loaded and ready.", "Rotation is paused.", "Monitor:", screen_width, screen_height, datetime.now().strftime("%H:%M:%S"))


def on_press(key):
    global debug, dprint, pause, mill
    # print(key)
    if key == keyboard.Key.f7:
        debug = not debug
        print("debug:", debug)


with keyboard.Listener(on_press=on_press) as listener:

    with mss.mss() as sct:

        while True:
            start_time = time.time()

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
