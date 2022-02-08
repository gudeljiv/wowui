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
x_RotationFrame = 1210
y_RotationFrame = 1100

skills = [
    {"name": "rend", "key": "5", "r": 79, "g": 2, "b": 0, "rgb": (79, 2, 0)},
    {"name": "battle shout", "key": "f4", "r": 193, "g": 115, "b": 110, "rgb": (193, 115, 110)},
    {"name": "overpower", "key": "4", "r": 89, "g": 97, "b": 107, "rgb": (89, 97, 107)},
    {"name": "heroic strike", "key": "2", "r": 153, "g": 150, "b": 153, "rgb": (153, 150, 153), "aoe": False},
    {"name": "cleave", "key": "3", "r": 153, "g": 150, "b": 153, "rgb": (153, 150, 153), "aoe": True},
    {"name": "sunder armor", "key": "g", "r": 189, "g": 126, "b": 116, "rgb": (189, 126, 116)},
    {"name": "revenge", "key": "1", "r": 205, "g": 195, "b": 195, "rgb": (205, 195, 195)},
    {"name": "execute", "key": "f", "r": 76, "g": 17, "b": 21, "rgb": (76, 17, 21)},
    {"name": "mortal strike", "key": "f11", "r": 147, "g": 145, "b": 146, "rgb": (147, 145, 146)},
    {"name": "whirlwind", "key": "6", "r": 105, "g": 212, "b": 240, "rgb": (105, 212, 240)}
    # {"name": "healing potion", "key": "6", "r": 227, "g": 34, "b": 27, "rgb": (227, 34, 27)}
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

        time.sleep(0.25)

        active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

        # ako je chat otvoren.. ili nesto trece... ako je kockica bijela
        if pyautogui.pixel(x_RotationFrame, y_RotationFrame) == (255, 254, 255):
            continue

        if pyautogui.pixel(x_RotationFrame, y_RotationFrame) == (0, 254, 0):
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
                # print(pyautogui.pixel(x, y), skill["rgb"], pyautogui.pixel(x, y) == skill["rgb"])
                if pyautogui.pixel(x, y) == skill["rgb"]:
                    # if pyautogui.pixel(x, y)[0] == skill["r"] and pyautogui.pixel(x, y)[1] == skill["g"] and pyautogui.pixel(x, y)[2] == skill["b"]:
                    if "aoe" in skill and skill["aoe"] == aoe:
                        print(skill["name"], skill["key"])
                        pyautogui.press(skill["key"], presses=3)

                    if not "aoe" in skill:
                        print(skill["name"], skill["key"])
                        pyautogui.press(skill["key"], presses=3)
