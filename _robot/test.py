from sys import platform

if platform == "darwin":
    active_window = NSWorkspace.sharedWorkspace().activeApplication()['NSApplicationName']

if platform == "win32":
    active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

# from AppKit import NSWorkspace

# activeAppName = NSWorkspace.sharedWorkspace().activeApplication()['NSApplicationName']

# active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())


print(active_window)
