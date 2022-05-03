from pyautogui import *
import pyautogui
import time
import keyboard
import random
from time import gmtime, strftime
from pynput import keyboard
import win32gui


# x = 1535
# y = 1150

x = 1285
y = 865


def on_press(key):
    global debug
    global dprint

    # try:
    #     # if key == keyboard.Key.f12:
    #     time.sleep(1)
    #     active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())
    #     cursorx, cursory = pyautogui.position()
    #     print("x:", x, "y:", y, "|| rgb:", pyautogui.pixel(x, y), "|| cursor:", cursorx, cursory, pyautogui.screenshot().getpixel((cursorx, cursorx)))
    # except:
    #     return


with keyboard.Listener(on_press=on_press) as listener:

    while True:
        time.sleep(1)
        active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())
        cursorx, cursory = pyautogui.position()
        print("x:", x, "y:", y, "|| rgb:", pyautogui.pixel(x, y), "|| cursor:", cursorx, cursory)
