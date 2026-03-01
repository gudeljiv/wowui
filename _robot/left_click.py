import time
import random
import keyboard
import mouse
import math
import pyautogui
import sys

running = False


def toggle(e):
    global running
    running = not running
    if running:
        print("Script started.")
        pyautogui.hotkey("home")
    else:
        print("Script paused.")
        pyautogui.hotkey("end")


def move_mouse_randomly():
    angle = random.uniform(0, 2 * 3.14159)
    radius = random.uniform(0, 15)
    x_offset = radius * math.cos(angle)
    y_offset = radius * math.sin(angle)
    mouse.move(x=x_offset, y=y_offset, absolute=False, duration=0.1)


def main():
    print("Script loaded. Press F12 to start/stop. Ctrl+C to exit.")
    keyboard.on_press_key("F12", toggle)

    try:
        while True:
            if running:
                # move_mouse_randomly()
                mouse.click()
                interval = random.uniform(0.9, 2.7)
                print(f"  Clicked. Next in {interval:.2f}s")
                time.sleep(interval)
            else:
                time.sleep(0.1)
    except KeyboardInterrupt:
        if running:
            pyautogui.hotkey("end")
        print("\nScript closed.")
        print("Script ended.")
        sys.exit(0)


if __name__ == "__main__":
    main()
