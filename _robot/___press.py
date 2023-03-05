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

import random

pyautogui.PAUSE = 1

combat = False
debug = False
mill = False
dprint = False
pause = True
wow_class = "warrior"


def on_press(key):
    global debug, dprint, pause, mill

    if key == keyboard.Key.f12:
        print(pause)
        pause = not pause
        if pause:
            print("Rotation is paused")
            pyautogui.PAUSE = 1
            pyautogui.FAILSAFE = False
        else:
            print("Rotation is not paused")
            pyautogui.PAUSE = 0.1
            pyautogui.FAILSAFE = True


with keyboard.Listener(on_press=on_press) as listener:
    with mss.mss() as sct:
        while True:

            time.sleep(random.uniform(0, 1))
            if not pause:
                # print(pyautogui.position())
                pyautogui.click(2580, 625)
                # time.sleep(0.1)
                # pyautogui.click(350, 974)
                # time.sleep(0.1)
                # pyautogui.click(2525, 1990)
                time.sleep(0.5)
                pyautogui.hotkey("x")
