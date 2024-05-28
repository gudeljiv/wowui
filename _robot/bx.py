import win32api
import win32con
import win32gui
import time

# Find the window by title
window_title = "World of Warcraft"

# Find the window handle
hwnd = win32gui.FindWindow(None, window_title)
print(hwnd)

if hwnd:
    # Get the handle of the child window (edit control)
    hwnd_child = win32gui.FindWindowEx(hwnd, None, None, None)
    print(hwnd_child)

    if hwnd_child:
        # Set focus to the child window
        win32gui.SetForegroundWindow(hwnd)

        # Send 'x' keydown and keyup messages to the window
        win32api.SendMessage(hwnd_child, win32con.WM_KEYDOWN, win32con.VK_X, 0)
        win32api.SendMessage(hwnd_child, win32con.WM_KEYUP, win32con.VK_X, 0)
    else:
        print("Child window not found")
else:
    print("Window not found")
