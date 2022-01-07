from pyautogui import *
import pyautogui
import time
import keyboard
import random
from time import gmtime, strftime
from pynput import keyboard
import win32gui

aoe = False
debug = False

x = 1280
y = 860

skills = [
    {"name": "rend", "key": "5", "r": 79, "g": 2, "b": 0, "rgb": "(79,2,0)"},
    {"name": "battle shout", "key": "f4", "r": 193, "g": 115, "b": 110, "rgb": "(193,115,110)"},
    {"name": "overpower", "key": "4", "r": 89, "g": 97, "b": 107, "rgb": "(89,97,107)"},
    {"name": "heroic strike", "key": "2", "r": 153, "g": 150, "b": 153, "rgb": "(153,150,153)", "aoe": False},
    {"name": "cleave", "key": "3", "r": 153, "g": 150, "b": 153, "rgb": "(153,150,153)", "aoe": True},
    {"name": "sunder armor", "key": "g", "r": 189, "g": 126, "b": 116, "rgb": "(189,126,116)"},
    {"name": "revenge", "key": "1", "r": 205, "g": 195, "b": 195, "rgb": "(205,195,195)"}
]


def on_press(key):
    global debug
    global aoe

    try:
        if key == keyboard.Key.f12:
            debug = not debug
            print("debug:", debug)
    except:
        return


with keyboard.Listener(on_press=on_press) as listener:
    while True:

        active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

        # if pyautogui.pixel(1210, 1100)[0] == 0 and pyautogui.pixel(1210, 1100)[1] == 254 and pyautogui.pixel(1210, 1100)[2] == 0:
        if pyautogui.pixel(1210, 1100) == (0, 254, 0):
            aoe = False
        else:
            aoe = True

        if debug:
            time.sleep(1)
            print("coords:", pyautogui.pixel(x, y), active_window)
        else:
            if(active_window != "World of Warcraft"):
                continue

            for skill in skills:
                if pyautogui.pixel(x, y) == skill["rgb"]:
                    # if pyautogui.pixel(x, y)[0] == skill["r"] and pyautogui.pixel(x, y)[1] == skill["g"] and pyautogui.pixel(x, y)[2] == skill["b"]:
                    if "aoe" in skill and skill["aoe"] == aoe:
                        print(skill["name"], skill["key"])
                        pyautogui.press(skill["key"], presses=3)

                    if not "aoe" in skill:
                        print(skill["name"], skill["key"])
                        pyautogui.press(skill["key"], presses=3)
