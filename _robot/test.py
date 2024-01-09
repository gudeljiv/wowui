import sys

if len(sys.argv) != 2:
    mode = "wotlk"
else:
    mode = sys.argv[1]

if mode == "wotlk":
    from libs.resources_wotlk import data
    from libs.resources_wotlk import monitor_settings
    from libs.resources_wotlk import keyCodeMap
else:
    from libs.resources_classic import data
    from libs.resources_classic import monitor_settings
    from libs.resources_classic import keyCodeMap


from libs.interception import *
from libs.ctypes_custom import KeyPress as cKeyPress
from win32api import GetSystemMetrics
import win32gui
import random
import math
import numpy
import mss.tools
import mss
import sys
import os
import multiprocessing
import pyautogui
import cv2
import _thread
import time
from datetime import datetime as dt
from skimage import metrics
from os.path import exists
from os import listdir
from os.path import isfile, join
from pyautogui import *
from pynput import keyboard
import pyperclip
from PIL import Image


driver = interception()

combat = False
dprint = False
debug = False
pause = True
wow_class = "warrior"
color_distance = 10

screen_width = GetSystemMetrics(0)
screen_height = GetSystemMetrics(1)

monitor = str(screen_width)

x = monitor_settings[monitor]["x"]
y = monitor_settings[monitor]["y"]
c_width = monitor_settings[monitor]["c_width"]
c_height = monitor_settings[monitor]["c_height"]
p_offgcd_left = monitor_settings[monitor]["p_offgcd_left"]
p_combat_left = monitor_settings[monitor]["p_combat_left"]
p_interrupt_left = monitor_settings[monitor]["p_interrupt_left"]
p_behind_left = monitor_settings[monitor]["p_behind_left"]
p_clss_left = monitor_settings[monitor]["p_clss_left"]

file_path = os.path.abspath(__file__)
dir_path = os.path.dirname(os.path.realpath(__file__))

abilities_folder = dir_path + r"\images\\" + mode + r"\\" + monitor
debug_folder = dir_path + r"\images\\_\\"

# default class
wow_class_loaded = wow_class
print("Script loaded and ready.", "Monitor:", screen_width, screen_height, dt.now().strftime("%H:%M:%S"))
print("PRINT:", dprint)
print("DEBUG:", debug)
print("ROTATION:", not pause)
print("MODE:", mode.upper())
print("CLASS:", wow_class_loaded.upper())


def parse_hex_color(string):
    if string.startswith("#"):
        string = string[1:]
    r = int(string[0:2], 16)  # red color value
    g = int(string[2:4], 16)  # green color value
    b = int(string[4:6], 16)  # blue color value
    return r, g, b


def color_similarity(base_col_val, oth_col_val):
    return math.sqrt(sum((base_col_val[i] - oth_col_val[i]) ** 2 for i in range(3)))


def get_class(clss, color_distance):
    found_class = False
    global wow_class
    for item in data["colors"]:
        for c in data["colors"][item]:
            rgb = parse_hex_color(c)
            if color_similarity(rgb, clss) <= color_distance:
                found_class = True
                wow_class = item

    return found_class, wow_class


def load_skills_main(wow_class):
    # load main ability skills
    main_abilities = dict()
    try:
        for skill in data[wow_class]["main"]:
            if not skill["name"] in main_abilities:
                main_abilities[skill["name"]] = {}

            image = abilities_folder + "/" + wow_class + "/" + skill["name"] + " M.png"
            if not os.path.isfile(image):
                print(skill["name"], "MISSING")
                continue
            else:
                main_abilities[skill["name"]]["image"] = cv2.imread(image)

            if "modifier" in skill.keys():
                main_abilities[skill["name"]]["modifier"] = skill["modifier"]
            main_abilities[skill["name"]]["key"] = skill["key"]
            main_abilities[skill["name"]]["name"] = skill["name"]
    except Exception as e:
        print("main abilities missing", wow_class, dt.now().strftime("%H:%M:%S"))

    return main_abilities


def load_skills_secondary(wow_class):
    # load secondary ability skills
    secondary_abilities = dict()
    try:
        for skill in data[wow_class]["secondary"]:
            if not skill["name"] in secondary_abilities:
                secondary_abilities[skill["name"]] = {}

            image = abilities_folder + "/" + wow_class + "/" + skill["name"] + " O.png"
            if not os.path.isfile(image):
                print(skill["name"], "MISSING")
                continue
            else:
                secondary_abilities[skill["name"]]["image"] = cv2.imread(image)

            if "modifier" in skill.keys():
                secondary_abilities[skill["name"]]["modifier"] = skill["modifier"]
            secondary_abilities[skill["name"]]["key"] = skill["key"]
            secondary_abilities[skill["name"]]["name"] = skill["name"]
    except Exception as e:
        print("offgcd abilities missing", wow_class, dt.now().strftime("%H:%M:%S"))

    return secondary_abilities


main_abilities = load_skills_main(wow_class)
secondary_abilities = load_skills_secondary(wow_class)

print(abilities_folder)

with mss.mss() as sct:
    while True:
        time.sleep(random.uniform(0.005, 0.01))

        # active_window = win32gui.GetWindowText(win32gui.GetForegroundWindow())
        # if active_window != "World of Warcraft":
        #     time.sleep(2)
        #     continue

        # defining regions
        p_whole = {"top": 0, "left": 0, "width": 150, "height": 30}
        p_main = {"top": 0, "left": 0, "width": 19, "height": 19}
        p_offgcd = {"top": 0, "left": 19, "width": 19, "height": 19}
        # p_combat = {"top": 0, "left": p_combat_left, "width": c_width, "height": c_height}
        # p_interrupt = {"top": 0, "left": p_interrupt_left, "width": c_width, "height": c_height}
        # p_behind = {"top": 0, "left": p_behind_left, "width": c_width, "height": c_height}
        p_clss = {"top": 0, "left": p_clss_left, "width": c_width, "height": c_height}

        # grabbing images from regions
        whole_image = sct.grab(p_whole)
        main_image = sct.grab(p_main)
        offgcd_image = sct.grab(p_offgcd)
        # combat = sct.grab(p_combat).pixel(math.floor(c_width / 2), math.floor(c_height / 2))
        # interrupt = sct.grab(p_interrupt).pixel(math.floor(c_width / 2), math.floor(c_height / 2))
        # behind = sct.grab(p_behind).pixel(math.floor(c_width / 2), math.floor(c_height / 2))
        clss = sct.grab(p_clss).pixel(math.floor(c_width / 2), math.floor(c_height / 2))

        found_class, wow_class = get_class(clss, color_distance)
        if wow_class_loaded != wow_class:
            # print("class changed: ", wow_class_loaded, "->", wow_class, "..", hex, clss, color_distance, color[hex], dt.now().strftime("%H:%M:%S"))
            print("CLASS:", wow_class_loaded.upper(), "->", wow_class.upper())
            main_abilities = load_skills_main(wow_class)
            secondary_abilities = load_skills_secondary(wow_class)
            wow_class_loaded = wow_class

        mss.tools.to_png(whole_image.rgb, whole_image.size, output=debug_folder + "0. whole.png".format(**p_whole))
        mss.tools.to_png(main_image.rgb, main_image.size, output=debug_folder + "1. main.png".format(**p_main))
        mss.tools.to_png(offgcd_image.rgb, offgcd_image.size, output=debug_folder + "6. offgcd.png".format(**p_offgcd))

        big = cv2.imread("C:\\Games\\wowui\\_robot\\images\\_\\0. whole.png")
        # Assuming main_abilities is defined elsewhere in your code
        for key, ability in main_abilities.items():
            if ability["name"] != "mangle":
                continue

            small = ability["image"]

            # Convert images to grayscale (if needed)
            small_gray = cv2.cvtColor(small, cv2.COLOR_BGR2GRAY)
            big_gray = cv2.cvtColor(big, cv2.COLOR_BGR2GRAY)

            result = cv2.matchTemplate(big_gray, small_gray, cv2.TM_CCOEFF_NORMED)

            # Set a threshold to find the matching locations
            threshold = 0.8
            loc = numpy.where(result >= threshold)

            for pt in zip(*loc[::-1]):
                # pt is the top-left corner of the match
                bottom_right = (pt[0] + small.shape[1], pt[1] + small.shape[0])
                cv2.rectangle(big, pt, bottom_right, (0, 255, 0), 2)

                # Printing the coordinates of the match
                print(f"Coordinates for {ability['name']}: Top-left: {pt}, Bottom-right: {bottom_right}")

            # cv2.imshow("Matching", big)
            # cv2.waitKey(0)
            # cv2.destroyAllWindows()

            sys.exit()
