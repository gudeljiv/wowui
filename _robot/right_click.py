import time
import random
import keyboard
import mouse


def move_mouse_randomly():
    x_offset = random.uniform(-20, 20)
    y_offset = random.uniform(-20, 20)
    mouse.move(x=x_offset, y=y_offset, absolute=False, duration=0.1)


def main():
    print("Script started but paused until F12 is pressed.")
    keyboard.wait("F12")
    print("Script started. Press F12 to stop.")

    running = True
    while running:
        move_mouse_randomly()
        mouse.right_click()

        interval = random.uniform(0.9, 2.7)
        time.sleep(interval)

        # Check if F12 is pressed to stop the script
        if keyboard.is_pressed("F12"):
            running = False
            print("Script stopped.")


if __name__ == "__main__":
    main()
