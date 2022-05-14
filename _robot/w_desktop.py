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

x = 1285
y = 865
x_aoe = 1210
y_aoe = 1100
x_interrupt = 1200
y_interrupt = 1100

skills = [
    {"name": "battle shout", "key": "f4", "rgb": (60, 39, 96)},
    {"name": "demoralizing shout", "key": "f5", "rgb": (0, 134, 55)},

    {"name": "sunder armor", "key": "g", "rgb": (187, 115, 115)},

    {"name": "mortal strike", "key": "f11", "rgb": (144, 142, 144)},
    {"name": "bloodthirst", "key": "f11", "rgb": (66, 0, 0)},
    {"name": "heroic strike", "key": "2", "rgb": (255, 255, 255)},
    {"name": "cleave", "key": "3", "rgb": (152, 149, 153)},
    {"name": "whirlwind", "key": "6", "rgb": (139, 233, 255)},
    {"name": "execute", "key": "f", "rgb": (128, 103, 86)},

    {"name": "rend", "key": "5", "rgb": (220, 64, 64)},
    {"name": "overpower", "key": "4", "rgb": (0, 48, 73)},
    {"name": "revenge", "key": "1", "rgb": (80, 59, 55)},

    {"name": "rampage", "key": "home", "rgb": (31, 1, 0)},
    {"name": "sweeping strikes", "key": "r", "modifier": "alt", "rgb": (255, 187, 0)},
    {"name": "victory rush", "key": "e", "modifier": "shift", "rgb": (246, 164, 101)},
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

        if pyautogui.pixel(x_interrupt, y_interrupt) == (0, 255, 0):
            if dprint:
                print("interrupt", "f9")
            pyautogui.hotkey("f9")
            continue

        if debug:
            time.sleep(1)
            if dprint:
                print(active_window, pyautogui.pixel(x, y))
        else:

            if(active_window != "World of Warcraft"):
                continue

            for skill in skills:
                r_live = pyautogui.pixel(x, y)[0]
                g_live = pyautogui.pixel(x, y)[1]
                b_live = pyautogui.pixel(x, y)[2]
                r_local = skill["rgb"][0]
                g_local = skill["rgb"][1]
                b_local = skill["rgb"][2]
                margin = 5

                if (r_local - margin <= r_live <= r_local + margin) and (g_local - margin <= g_live <= g_local + margin) and (b_local - margin <= b_live <= b_local + margin):
                    if dprint:
                        print(skill["name"], skill["key"], skill["rgb"], pyautogui.pixel(x, y))
                    if "modifier" in skill.keys():
                        pyautogui.hotkey(skill["modifier"], skill["key"])
                    else:
                        pyautogui.hotkey(skill["key"])
