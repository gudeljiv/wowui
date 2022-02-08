import pyautogui
import time
import win32gui
import win32api
import win32con

while True:

    active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

    time.sleep(1)
    win32api.SetCursorPos((100, 100))
    pyautogui.press("b")
    print("b", active_window)
