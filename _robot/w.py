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
dprint = False

x = 1280
y = 860
x_aoe = 1210
y_aoe = 1100
x_interrupt = 1200
y_interrupt = 1100

skills = [

    # first system settings
    {"name": "battle shout", "key": "f4", "r": 193, "g": 115, "b": 110, "rgb": (193, 115, 110)},
    {"name": "sunder armor", "key": "g", "r": 189, "g": 126, "b": 116, "rgb": (189, 126, 116), "aoe": False},
    {"name": "mortal strike", "key": "f11", "r": 147, "g": 145, "b": 146, "rgb": (147, 145, 146), "aoe": False},
    {"name": "heroic strike", "key": "2", "r": 153, "g": 150, "b": 154, "rgb": (153, 150, 154), "aoe": False},
    {"name": "rend", "key": "5", "r": 80, "g": 2, "b": 0, "rgb": (80, 2, 0)},
    {"name": "overpower", "key": "4", "r": 89, "g": 97, "b": 107, "rgb": (89, 97, 107)},
    {"name": "cleave", "key": "3", "r": 128, "g": 128, "b": 126, "rgb": (128, 128, 126), "aoe": True},
    {"name": "revenge", "key": "1", "r": 205, "g": 195, "b": 195, "rgb": (205, 195, 195)},
    {"name": "execute", "key": "f", "r": 76, "g": 17, "b": 21, "rgb": (76, 17, 21)},
    {"name": "whirlwind", "key": "6", "r": 105, "g": 212, "b": 240, "rgb": (105, 210, 240)},

    # second system settings
    # {"name": "battle shout", "key": "f4", "r": 193, "g": 115, "b": 110, "rgb": (193, 115, 110)},
    # {"name": "sunder armor", "key": "g", "r": 189, "g": 126, "b": 116, "rgb": (189, 126, 116)},
    # {"name": "mortal strike", "key": "f11", "r": 147, "g": 145, "b": 146, "rgb": (147, 145, 146)},
    # {"name": "rend", "key": "5", "r": 79, "g": 2, "b": 0, "rgb": (79, 2, 0)},
    # {"name": "overpower", "key": "4", "r": 88, "g": 99, "b": 107, "rgb": (88, 99, 107)},
    # {"name": "heroic strike", "key": "2", "r": 153, "g": 150, "b": 153, "rgb": (153, 150, 153), "aoe": False},
    # {"name": "cleave", "key": "3", "r": 153, "g": 150, "b": 153, "rgb": (153, 150, 153), "aoe": True},
    # {"name": "revenge", "key": "1", "r": 205, "g": 195, "b": 195, "rgb": (205, 195, 195)},
    # {"name": "execute", "key": "f", "r": 76, "g": 17, "b": 21, "rgb": (76, 17, 21)},
    # {"name": "whirlwind", "key": "6", "r": 105, "g": 210, "b": 240, "rgb": (105, 210, 240)},

    # {"name": "mongoose bite", "key": "f10", "r": 135, "g": 133, "b": 135, "rgb": (135, 133, 135)},
    # {"name": "healing potion", "key": "6", "r": 227, "g": 34, "b": 27, "rgb": (227, 34, 27)}
]


def on_press(key):
    global debug
    global dprint

    try:
        if key == keyboard.Key.f12:
            debug = not debug
            print("debug:", debug)
        if key == keyboard.Key.f8:
            dprint = not dprint
            print("dprint:", dprint)
    except:
        return


with keyboard.Listener(on_press=on_press) as listener:

    while True:

        time.sleep(0.01)
        active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

        # ako je chat otvoren.. ili nesto trece... ako je kockica bijela
        if pyautogui.pixel(x_aoe, y_aoe) == (255, 254, 255) and debug == False:
            # if dprint:
            # print("skipping", "...")
            continue

        if pyautogui.pixel(x_interrupt, y_interrupt) == (0, 254, 0):
            if dprint:
                print("interrupt", "f9")
            pyautogui.press("f9", presses=3)

        if debug:
            time.sleep(1)
            if dprint:
                print(pyautogui.pixel(x, y), pyautogui.pixel(x, y)[0], pyautogui.pixel(x, y)[1], pyautogui.pixel(x, y)[2])
                # print("coords:", pyautogui.pixel(x, y), active_window)
        else:
            if(active_window != "World of Warcraft"):
                continue

            for skill in skills:
                r = pyautogui.pixel(x, y)[0]
                g = pyautogui.pixel(x, y)[1]
                b = pyautogui.pixel(x, y)[2]
                margin = 5

               # if pyautogui.pixel(x, y) == skill["rgb"]:
                if (skill["r"] - margin <= r <= skill["r"] + margin) and (skill["g"] - margin <= g <= skill["g"] + margin) and (skill["b"] - margin <= b <= skill["b"] + margin):
                    if dprint:
                        print(skill["name"], skill["key"], skill["rgb"], pyautogui.pixel(x, y))
                    pyautogui.press(skill["key"])
