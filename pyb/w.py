from pyautogui import *
import pyautogui
import time
import keyboard
import random

aoe = False
rotate = True

x = 1280
y = 860

while 1 == 2:
     time.sleep(1)
     print(pyautogui.pixel(1280, 860))

while True:
    if keyboard.is_pressed("K"):
        if not aoe:
            time.sleep(0.1)
            print("AOE")
            # pyautogui.press("enter")
            # pyautogui.write('/run print("PB starting")')
            # pyautogui.press("enter")
        else:
            time.sleep(0.1)
            print("SINGLE TARGET")
            # pyautogui.press("enter")
            # pyautogui.write('/run print("PB stoping")')
            # pyautogui.press("enter")
        aoe = not aoe
    
    if rotate:
        if pyautogui.pixel(x, y)[0] == 79 and pyautogui.pixel(x, y)[1] == 2 and pyautogui.pixel(x, y)[2] == 0:
            print("rend")
            pyautogui.press("5", presses=3)
        if pyautogui.pixel(x, y)[0] == 193 and pyautogui.pixel(x, y)[1] == 115 and pyautogui.pixel(x, y)[2] == 110:
            print("battle shout")
            pyautogui.press("F4", presses=3)
        if pyautogui.pixel(x, y)[0] == 153 and pyautogui.pixel(x, y)[1] == 150 and pyautogui.pixel(x, y)[2] == 153:
            if not aoe:
                print("heroic strike")
                pyautogui.press("2", presses=3)
            else:
                print("cleave")
                pyautogui.press("3", presses=3)
        if pyautogui.pixel(x, y)[0] == 89 and pyautogui.pixel(x, y)[1] == 97 and pyautogui.pixel(x, y)[2] == 107:
            print("overpower")
            pyautogui.press("4", presses=3)

    
