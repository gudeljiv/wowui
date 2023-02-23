from _resources import skills
from _resources import color
from _resources import monitor_settings
import time

import cv2
import pyautogui

import os
import sys
import mss
import mss.tools
import numpy
import math

if (os.name == "posix"):
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
abilities_folder = dir_path + "\images\\" + monitor

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

            pyautogui.hotkey("h")
