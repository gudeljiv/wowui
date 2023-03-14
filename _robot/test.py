from skimage.metrics import structural_similarity
from os.path import exists
from os import listdir
from os.path import isfile, join
from pyautogui import *
from pynput import keyboard
from libs.resources_new import data
from libs.resources_new import monitor_settings

import time
import pyautogui

import os
import mss
import mss.tools
import math
import pyperclip

# myScreenshot = pyautogui.screenshot()
# myScreenshot.save(r'file name.png')

if (os.name == "posix"):
    from AppKit import NSScreen
    from AppKit import NSWorkspace
else:
    import win32gui
    from win32api import GetSystemMetrics


combat = False
debug = False
mill = False
dprint = False
pause = True
wow_class = "warrior"
wow_class_loaded = wow_class

if os.name == "posix":
    screen_width = NSScreen.mainScreen().frame().size.width
    screen_height = NSScreen.mainScreen().frame().size.height
else:
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

if os.name == "posix":
    abilities_folder = dir_path + "/images/" + monitor
    slash = "/"
else:
    abilities_folder = dir_path + "\images\\" + monitor
    slash = "\\"

if not os.path.exists(abilities_folder):
    os.makedirs(abilities_folder)


skills_loaded = "warrior"
print("Script loaded and ready.", "Monitor:", screen_width, screen_height, os.name)


def on_press(key):
    global debug, dprint, pause, mill

    try:
        if key == keyboard.Key.f12:
            debug = not debug
            print("debug:", debug)
    except:
        return


def parse_hex_color(string):
    if string.startswith("#"):
        string = string[1:]
    r = int(string[0:2], 16)  # red color value
    g = int(string[2:4], 16)  # green color value
    b = int(string[4:6], 16)  # blue color value
    return r, g, b


def color_similarity(base_col_val, oth_col_val):
    return math.sqrt(sum((base_col_val[i]-oth_col_val[i])**2 for i in range(3)))


def print_debug(no, xclass, skill, image):
    # no = '{0: <4}'.format(no)
    # xclass = '{0: <15}'.format(xclass)
    # skill = '{0: <25}'.format(skill)
    # image = '{0: <100}'.format(image)
    print(no, xclass, skill)


classes = {
    "warrior", "druid", "rogue", "warlock", "mage", "hunter", "death knight", "priest", "paladin", "shaman"
}

time1 = 0.2
time2 = 0.1

count = 0
number = 0

s, t = "", ""
color_distance = 10


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


debug_folder = dir_path + "/images/_/"
x = 100
y = 100
with keyboard.Listener(on_press=on_press) as listener:

    with mss.mss() as sct:

        while True:
            time.sleep(1)

            p_main = {"top": 1000, "left": 500, "width": x, "height": y}
            # p_secondary = {"top": 2, "left":  p_offgcd_left, "width": x, "height": y}

            if debug:
                print({"top": screen_width-(x/2), "left": screen_height-(y/2), "width": x, "height": y}, screen_width, screen_height)
                main_image = sct.grab(p_main)
                # secondary_iamge = sct.grab(p_secondary)
                mss.tools.to_png(main_image.rgb, main_image.size, output=debug_folder + "99. main.png".format(**p_main))
                # mss.tools.to_png(secondary_iamge.rgb, secondary_iamge.size, output=debug_folder + "100. secondary.png".format(**p_secondary))
