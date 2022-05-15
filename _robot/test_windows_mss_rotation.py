import time
import mss.tools
import mss
import os
from os.path import exists
import keyboard
from pynput import keyboard
import win32gui
from pyautogui import *
import pyautogui
from _skills import skills
import cv2
from skimage.metrics import structural_similarity

aoe = False
debug = False
dprint = False

x = 6  # 1535
y = 6  # 1150
x_aoe = 17
y_aoe = 2
x_interrupt = 27
y_interrupt = 2

margin = 1


def on_press(key):
    global debug
    global dprint

    try:
        if key == keyboard.Key.f12:
            debug = not debug
            print("debug:", debug)
        if key == keyboard.Key.f8:
            dprint = not dprint
            print("dprint:", dprint)
    except:
        return


with keyboard.Listener(on_press=on_press) as listener:

    with mss.mss() as sct:

        while True:

            active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

            start_time = time.time()
            p_main = {"top": 0, "left": 0, "width": x*2, "height": y*2}
            p_aoe = {"top": 0, "left": x_aoe, "width": 5, "height": 2}
            p_interrupt = {"top": 0, "left": x_interrupt, "width": 5, "height": 2}

            output = "main_{top}x{left}_{width}x{height}.png".format(**p_main)

            # Grab the pixel data
            main_image = sct.grab(p_main)
            main = main_image.pixel(int(x/2), int(y/2))

            aoe_image = sct.grab(p_aoe)
            aoe = aoe_image.pixel(1, 1)
            # mss.tools.to_png(aoe_image.rgb, aoe_image.size, output="aoe_{top}x{left}_{width}x{height}.png".format(**p_aoe))

            interrupt_image = sct.grab(p_interrupt)
            interrupt = interrupt_image.pixel(1, 1)
            # mss.tools.to_png(interrupt_image.rgb, interrupt_image.size, output="interrupt_{top}x{left}_{width}x{height}.png".format(**p_interrupt))

            if not debug:

                if aoe == (255, 255, 255):
                    if dprint:
                        print("skipping",  f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
                    continue

                if interrupt == (0, 255, 0):
                    if dprint:
                        print("interrupt", "f9", f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
                    pyautogui.hotkey("f9")

                if(active_window != "World of Warcraft" and not debug):
                    if dprint:
                        print(active_window, "skipping", f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
                    continue

                # rotation
                mss.tools.to_png(main_image.rgb, main_image.size, output=output)
                for skill in skills:

                    input = "images/" + skill["name"] + ".png"
                    if exists(input):

                        image = cv2.imread(input)
                        temp = cv2.imread(output)
                        before_gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
                        after_gray = cv2.cvtColor(temp, cv2.COLOR_BGR2GRAY)

                        (score, diff) = structural_similarity(before_gray, after_gray, full=True)

                        if(score*100 > 90):
                            print(skill["name"], skill["key"])

                            if "modifier" in skill.keys():
                                pyautogui.hotkey(skill["modifier"], skill["key"])
                            else:
                                pyautogui.hotkey(skill["key"])

            if debug:
                time.sleep(0.5)
                mss.tools.to_png(main_image.rgb, main_image.size, output=output)
                print(output, main, aoe, interrupt, active_window, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
