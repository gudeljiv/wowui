import pyautogui
import time
import win32gui
import win32api
import win32con

x_interrupt = 1200
y_interrupt = 1100

while True:

    active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

    time.sleep(1)
    print(pyautogui.pixel(x_interrupt, y_interrupt))
