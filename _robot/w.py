from _skills import skills
import time

import cv2
import pyautogui

import os
import sys
import mss
import mss.tools
import numpy

from pynput import keyboard
from pyautogui import *
from os.path import isfile, join
from os import listdir
from os.path import exists
from skimage.metrics import structural_similarity

if sys.platform == "darwin":
    from AppKit import NSWorkspace
if sys.platform == "win32":
    import win32gui

aoe = False
debug = False
dprint = False

x = 6
y = 6
x_aoe = 17
y_aoe = 2
x_interrupt = 27
y_interrupt = 2
margin = 1

file_path = os.path.abspath(__file__)
dir_path = os.path.dirname(os.path.realpath(__file__))

abilities_folder = dir_path + "/images"
abilities_list = [f for f in listdir(abilities_folder) if isfile(join(abilities_folder, f))]

abilities = {}
for ability in abilities_list:
    cv2grey = cv2.cvtColor(cv2.imread(abilities_folder + "/" + ability), cv2.COLOR_BGR2GRAY)
    abilities[ability.replace(".png", "")] = cv2grey

print("Script loaded and ready...")


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
            start_time = time.time()

            if sys.platform == "darwin":
                active_window = NSWorkspace.sharedWorkspace().activeApplication()['NSApplicationName']
            if sys.platform == "win32":
                active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())

            p_main = {"top": 0, "left": 0, "width": x*2, "height": y*2}
            p_aoe = {"top": 0, "left": x_aoe, "width": 5, "height": 2}
            p_interrupt = {"top": 0, "left": x_interrupt, "width": 5, "height": 2}

            grabbed_image = dir_path + "/_main_{top}x{left}_{width}x{height}.png".format(**p_main)

            main_image = sct.grab(p_main)
            main = main_image.pixel(int(x/2), int(y/2))

            aoe_image = sct.grab(p_aoe)
            aoe = aoe_image.pixel(1, 1)
            # mss.tools.to_png(aoe_image.rgb, aoe_image.size, output="aoe_{top}x{left}_{width}x{height}.png".format(**p_aoe))

            interrupt_image = sct.grab(p_interrupt)
            interrupt = interrupt_image.pixel(1, 1)
            # mss.tools.to_png(interrupt_image.rgb, interrupt_image.size, output="interrupt_{top}x{left}_{width}x{height}.png".format(**p_interrupt))

            if not debug:
                # skipping combat, chat open ... any other reason (white -> skip, green -> combat)
                if aoe == (255, 255, 255):
                    continue

                # aoe indicator, white --> red
                if interrupt == (0, 255, 0):
                    if dprint:
                        print("interrupt", "f9", f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
                    pyautogui.hotkey("f9")

                if(active_window != "World of Warcraft" and sys.platform == "win32"):
                    continue
                if(active_window != "Wow" and sys.platform == "darwin"):
                    continue

                # grabbed image handling
                # mss.tools.to_png(main_image.rgb, main_image.size, output=grabbed_image)
                # img = cv2.imread(main_image)
                # grabbed = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
                # os.remove(grabbed_image)
                grabbed = cv2.cvtColor(numpy.array(main_image), cv2.COLOR_BGR2GRAY)

                # print("checking skills...", f"Finish in: {round(1000 * (time.time() - start_time))} ms ")

                # rotation
                for skill in skills:
                    start_skills_time = time.time()
                    for ability in abilities:
                        (score, diff) = structural_similarity(abilities[ability], grabbed, full=True)
                        # print(score*100, ability, skill["name"], f"Finish in: {round(1000 * (time.time() - start_time))} ms ", f"Finish in: {round(1000 * (time.time() - start_skills_time))} ms ")
                        if(score*100 > 90 and ability == skill["name"]):
                            if dprint:
                                print(ability, skill["name"], skill["key"], score*100, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
                            if "modifier" in skill.keys():
                                pyautogui.hotkey(skill["modifier"], skill["key"])
                            else:
                                pyautogui.hotkey(skill["key"])
            if debug:
                time.sleep(0.5)
                mss.tools.to_png(main_image.rgb, main_image.size, output=grabbed_image)
                print(grabbed_image, main, aoe, interrupt, active_window, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
