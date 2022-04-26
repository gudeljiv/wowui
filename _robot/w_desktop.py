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

x = 1535
y = 1150
x_aoe = 1445
y_aoe = 1470
x_interrupt = 1430
y_interrupt = 1470

skills = [
    {"name": "battle shout", "key": "f4", "rgb": (193, 115, 110)},
    {"name": "sunder armor", "key": "g", "rgb": (189, 126, 116)},
    {"name": "mortal strike", "key": "f11", "rgb": (147, 145, 146)},
    {"name": "bloodthirst", "key": "f11", "rgb": (208, 90, 57)},
    {"name": "heroic strike", "key": "2", "rgb": (153, 150, 154)},
    {"name": "rend", "key": "5", "rgb": (80, 2, 0)},
    {"name": "overpower", "key": "4", "rgb": (89, 97, 107)},
    {"name": "cleave", "key": "3", "rgb": (128, 128, 126)},
    {"name": "revenge", "key": "1", "rgb": (205, 195, 195)},
    {"name": "execute", "key": "f", "rgb": (76, 17, 21)},
    {"name": "whirlwind", "key": "6", "rgb": (105, 210, 240)},
    {"name": "rampage", "key": "home", "rgb": (175, 126, 90)},
    {"name": "sweeping strikes", "key": "r", "modifier": "alt", "rgb": (116, 49, 0)},
    {"name": "victory rush", "key": "e", "modifier": "shift", "rgb": (212, 92, 44)},
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
            pyautogui.hotkey("f9")

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
