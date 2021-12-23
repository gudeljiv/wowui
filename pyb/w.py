from pyautogui import *
import pyautogui
import time
import keyboard
import random

# X: 1283 Y:  861 RGB: (199,  78,  82) rend
# X: 1283 Y:  856 RGB: ( 28,  13,  58) battle shout
# X: 1286 Y:  858 RGB: (219, 119,  48) heroic strike

while keyboard.is_pressed("F12") == False:
    if pyautogui.pixel(1283, 861)[0] == 199 and pyautogui.pixel(1283, 861)[1] == 78 and pyautogui.pixel(1283, 861)[2] == 82:
        print("rend")
        pyautogui.press("5")

    if pyautogui.pixel(1283, 856)[0] == 28 and pyautogui.pixel(1283, 856)[1] == 13 and pyautogui.pixel(1283, 856)[2] == 58:
        print("battle shout")
        pyautogui.press("F4")

    if pyautogui.pixel(1286, 858)[0] == 219 and pyautogui.pixel(1286, 858)[1] == 119 and pyautogui.pixel(1286, 858)[2] == 48:
        print("heroic strike")
        pyautogui.press("2")
