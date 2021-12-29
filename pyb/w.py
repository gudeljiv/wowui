from pyautogui import *
import pyautogui
import time
import keyboard
import random
from time import gmtime, strftime

aoe = False
dps = True
tank = False

x = 1280
y = 860

while 1 == 2:
    time.sleep(1)
    print(pyautogui.pixel(1280, 860))

while True:

    if keyboard.is_pressed("F1"):
        time.sleep(0.1)
        dps = True
        tank = False
        aoe = False

    if keyboard.is_pressed("F2"):
        time.sleep(0.1)
        dps = True
        tank = False
        aoe = True

    if keyboard.is_pressed("F3"):
        time.sleep(0.1)
        dps = False
        tank = True
        aoe = False

    if keyboard.is_pressed("F4"):
        time.sleep(0.1)
        dps = False
        tank = True
        aoe = True

    if dps:
        if pyautogui.pixel(x, y)[0] == 79 and pyautogui.pixel(x, y)[1] == 2 and pyautogui.pixel(x, y)[2] == 0:
            print("rend")
            pyautogui.press("5", presses=3)
        if pyautogui.pixel(x, y)[0] == 193 and pyautogui.pixel(x, y)[1] == 115 and pyautogui.pixel(x, y)[2] == 110:
            print("battle shout")
            pyautogui.press("F4", presses=3)
        if pyautogui.pixel(x, y)[0] == 153 and pyautogui.pixel(x, y)[1] == 150 and pyautogui.pixel(x, y)[2] == 153:
            if aoe:
                print("cleave")
                pyautogui.press("3", presses=3)
            else:
                print("heroic strike")
                pyautogui.press("2", presses=3)
        if pyautogui.pixel(x, y)[0] == 89 and pyautogui.pixel(x, y)[1] == 97 and pyautogui.pixel(x, y)[2] == 107:
            print("overpower")
            pyautogui.press("4", presses=3)
        if pyautogui.pixel(x, y)[0] == 189 and pyautogui.pixel(x, y)[1] == 126 and pyautogui.pixel(x, y)[2] == 116:
            print("sunder armor")
            pyautogui.press("G", presses=3)

    if tank:
        if pyautogui.pixel(x, y)[0] == 79 and pyautogui.pixel(x, y)[1] == 2 and pyautogui.pixel(x, y)[2] == 0:
            print("rend")
            pyautogui.press("5", presses=3)
        if pyautogui.pixel(x, y)[0] == 193 and pyautogui.pixel(x, y)[1] == 115 and pyautogui.pixel(x, y)[2] == 110:
            print("battle shout")
            pyautogui.press("F4", presses=3)
        if pyautogui.pixel(x, y)[0] == 153 and pyautogui.pixel(x, y)[1] == 150 and pyautogui.pixel(x, y)[2] == 153:
            if aoe:
                print("cleave")
                pyautogui.press("3", presses=3)
            else:
                print("heroic strike")
                pyautogui.press("2", presses=3)
        if pyautogui.pixel(x, y)[0] == 89 and pyautogui.pixel(x, y)[1] == 97 and pyautogui.pixel(x, y)[2] == 107:
            print("overpower")
            pyautogui.press("4", presses=3)
        if pyautogui.pixel(x, y)[0] == 189 and pyautogui.pixel(x, y)[1] == 126 and pyautogui.pixel(x, y)[2] == 116:
            print("sunder armor")
            pyautogui.press("G", presses=3)
        if pyautogui.pixel(x, y)[0] == 189 and pyautogui.pixel(x, y)[1] == 126 and pyautogui.pixel(x, y)[2] == 116:
            print("revenge")
            pyautogui.press("1", presses=3)
