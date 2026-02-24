import time
import random
import keyboard
import mouse
import math


def move_mouse_randomly():
    angle = random.uniform(0, 2 * 3.14159)
    radius = random.uniform(0, 15)
    x_offset = radius * math.cos(angle)
    y_offset = radius * math.sin(angle)
    mouse.move(x=x_offset, y=y_offset, absolute=False, duration=0.1)


def main():
    print("Script started but paused until F12 is pressed.")
    keyboard.wait("F12")
    print("Script started. Press F12 to stop.")

    running = True
    while running:
        # move_mouse_randomly()
        mouse.click()

        interval = random.uniform(0.9, 2.7)
        time.sleep(interval)

        # Check if F12 is pressed to stop the script
        if keyboard.is_pressed("F12"):
            running = False
            print("Script stopped.")


if __name__ == "__main__":
    main()
