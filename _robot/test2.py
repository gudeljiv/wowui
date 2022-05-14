import time
import mss.tools
import mss
import os
import keyboard
from pynput import keyboard
import win32gui
from pyautogui import *
import pyautogui

aoe = False
debug = False
dprint = False

x = 1535
y = 1150
x_aoe = 1445
y_aoe = 1470
x_interrupt = 1430
y_interrupt = 1470

margin = 1

skills = [
    {"name": "battle shout", "key": "f4", "rgb": (157, 90, 85)},
    {"name": "demoralizing shout", "key": "f5", "rgb": (9, 9, 0)},
    {"name": "sunder armor", "key": "g", "rgb": (185, 120, 110)},
    {"name": "bloodthirst", "key": "f11", "rgb": (240, 108, 68)},
    {"name": "rend", "key": "5", "rgb": (9, 0, 0)},
    {"name": "overpower", "key": "4", "rgb": (87, 96, 101)},
    {"name": "heroic strike", "key": "2", "rgb": (105, 92, 97)},
    {"name": "cleave", "key": "3", "rgb": (107, 106, 107)},
    {"name": "revenge", "key": "1", "rgb": (198, 194, 189)},
    {"name": "execute", "key": "f", "rgb": (138, 83, 55)},
    {"name": "whirlwind", "key": "6", "rgb": (80, 182, 231)},
    {"name": "rampage", "key": "home", "rgb": (233, 128, 67)},
    {"name": "sweeping strikes", "key": "r", "modifier": "alt", "rgb": (178, 100, 0)},
    {"name": "victory rush", "key": "e", "modifier": "shift", "rgb": (200, 82, 37)},
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

    with mss.mss() as sct:

        while True:

            active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

            start_time = time.time()
            p_main = {"top": y-margin, "left": x-margin, "width": margin*2, "height": margin*2}
            p_aoe = {"top": y_aoe-margin, "left": x_aoe-margin, "width": margin*2, "height": margin*2}
            p_interrupt = {"top": y_interrupt-margin, "left": x_interrupt-margin, "width": margin*2, "height": margin*2}

            # Grab the pixel data
            main = sct.grab(p_main).pixel(0, 0)
            aoe = sct.grab(p_aoe).pixel(0, 0)
            interrupt = sct.grab(p_interrupt).pixel(0, 0)

            if aoe == (255, 254, 255) and debug == False:
                if dprint:
                    print("skipping",  f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
                continue

            if interrupt == (0, 254, 0):
                if dprint:
                    print("interrupt", "f9", f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
                pyautogui.hotkey("f9")

            if(active_window != "World of Warcraft" and not debug):
                if dprint:
                    print(active_window, "skipping", f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
                continue

            # rotation
            for skill in skills:
                r_live = main[0]
                g_live = main[1]
                b_live = main[2]
                r_local = skill["rgb"][0]
                g_local = skill["rgb"][1]
                b_local = skill["rgb"][2]
                pixel_error = 5

                if (r_local - pixel_error <= r_live <= r_local + pixel_error) and (g_local - pixel_error <= g_live <= g_local + pixel_error) and (b_local - pixel_error <= b_live <= b_local + pixel_error):
                    if dprint:
                        print(skill["name"], skill["key"], skill["rgb"], main)
                    if "modifier" in skill.keys():
                        pyautogui.hotkey(skill["modifier"], skill["key"])
                    else:
                        pyautogui.hotkey(skill["key"])

            if debug:
                print(main, main[0], main[1], main[2], aoe, interrupt, active_window, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
