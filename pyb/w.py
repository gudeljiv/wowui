from pyautogui import *
import pyautogui
import time
import keyboard
import random
from time import gmtime, strftime
from pynput import keyboard

aoe = False
debug = False
first_press = True

x = 1280
y = 860

skills = [
    {"name": "rend", "key": "5", "r": 79, "g": 2, "b": 0},
    {"name": "battle shout", "key": "f4", "r": 193, "g": 115, "b": 110},
    {"name": "heroic strike", "key": "2", "r": 153, "g": 150, "b": 153, "aoe": False},
    {"name": "cleave", "key": "3", "r": 153, "g": 150, "b": 153, "aoe": True},
    {"name": "overpower", "key": "4", "r": 89, "g": 97, "b": 107},
    {"name": "sunder armor", "key": "g", "r": 189, "g": 126, "b": 116}
]

def on_press(key):
    global debug
    global aoe
    global first_press
    
    try:
        if key == keyboard.Key.f12:
            debug = not debug
            print("debug:", debug)
        elif key == keyboard.Key.f11:
            aoe = not aoe
            print("aoe:", aoe)
    except:
        return


with keyboard.Listener(on_press=on_press) as listener:
    while True:
        if debug:
            time.sleep(1)
            print("coords:", pyautogui.pixel(x, y))
        else:
            for skill in skills:
                if pyautogui.pixel(x, y)[0] == skill["r"] and pyautogui.pixel(x, y)[1] == skill["g"] and pyautogui.pixel(x, y)[2] == skill["b"]:
                    if "aoe" in skill and skill["aoe"] == aoe:
                        #print("ima", aoe, aoe == skill["aoe"], skill)
                        print(skill["name"], skill["key"])
                        pyautogui.press(skill["key"], presses=3)

                    if not "aoe" in skill:
                        #print("nema", aoe, skill)
                        print(skill["name"], skill["key"])
                        pyautogui.press(skill["key"], presses=3)

    listener.join()

