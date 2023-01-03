from _resources import skills
from _resources import color
from _resources import monitor_settings
import time

import cv2
import pyautogui

import os
import sys
import mss
import mss.tools
import numpy
import math
import pyperclip

if(os.name == "posix"):
    from AppKit import NSScreen
    from AppKit import NSWorkspace
else:
    import win32gui
    from win32api import GetSystemMetrics


from pynput import keyboard
from pyautogui import *
from os.path import isfile, join
from os import listdir
from os.path import exists
from skimage.metrics import structural_similarity
from datetime import datetime

combat = False
debug = False
mill = False
dprint = False
pause = True
wow_class = "warrior"

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
print("Script loaded and ready.", "Rotation is paused.", "Monitor:", screen_width, screen_height, datetime.now().strftime("%H:%M:%S"), os.name)


def on_press(key):
    global debug, dprint, pause, mill

    try:
        if key == keyboard.Key.f7:
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


classes = {
    "warrior", "druid", "rogue", "warlock", "mage", "hunter", "death knight", "priest", "paladin", "shaman"
}

time1 = 0.1
time2 = 0.1

count = 0
number = 0
with keyboard.Listener(on_press=on_press) as listener:

    with mss.mss() as sct:

        while True:
            start_time = time.time()

            p_main = {"top": 2, "left": 2, "width": x, "height": y}
            p_offgcd = {"top": 2, "left":  p_offgcd_left, "width": x, "height": y}
            p_combat = {"top": 0, "left": p_combat_left, "width": c_width, "height": c_height}
            p_interrupt = {"top": 0, "left": p_interrupt_left, "width": c_width, "height": c_height}
            p_behind = {"top": 0, "left": p_behind_left, "width": c_width, "height": c_height}
            p_clss = {"top": 0, "left": p_clss_left, "width": c_width, "height": c_height}

            clss_image = sct.grab(p_clss)
            clss = clss_image.pixel(math.floor(c_width/2), math.floor(c_height/2))
            hex = '#%02x%02x%02x' % clss

            # matching closest class color to define in colors
            color_distance = 50
            found_class = False
            for c in color:
                rgb = parse_hex_color(c)
                # print(color[c], c, rgb, clss, color_similarity(rgb, clss))
                if color_similarity(rgb, clss) <= color_distance:
                    color_distance = color_similarity(rgb, clss)
                    hex = c
                    found_class = True

            if not found_class:
                continue

            try:
                wow_class = color[hex]
            except:
                wow_class = "warrior"

            if count > 0:
                quit()

            if debug:
                count = count + 1

                pyautogui.hotkey("enter")
                pyperclip.copy('/run RotationTextureFrame1:Show()')
                if os.name == "posix":
                    pyautogui.hotkey('command', 'v')
                else:
                    pyautogui.hotkey('ctrl', 'v')
                pyautogui.hotkey("enter")

                time.sleep(time1)

                pyautogui.hotkey("enter")
                pyperclip.copy('/run RotationTextureFrame2:Show()')
                if os.name == "posix":
                    pyautogui.hotkey('command', 'v')
                else:
                    pyautogui.hotkey('ctrl', 'v')
                pyautogui.hotkey("enter")

                # for wow_class in classes:

                try:
                    for skill in skills[wow_class]:
                        number = number + 1
                        print(number, wow_class, skill["name"], abilities_folder + slash + skill["name"] + " M.png")
                        pyautogui.hotkey("enter")
                        pyperclip.copy('/run RotationTextureFrame1.texture:SetTexture(' + str(skill["type"]) + '(' + str(skill["id"]) + '))')
                        if os.name == "posix":
                            pyautogui.hotkey('command', 'v')
                        else:
                            pyautogui.hotkey('ctrl', 'v')
                        pyautogui.hotkey("enter")

                        time.sleep(time1)
                        m_image = abilities_folder + slash + str(skill["name"]) + " M.png".format(**p_main)
                        main_image = sct.grab(p_main)
                        mss.tools.to_png(main_image.rgb, main_image.size, output=m_image)
                        time.sleep(time2)

                    for skill in skills["offgcd"][wow_class]:
                        number = number + 1
                        print(number, wow_class, skill["name"], abilities_folder + slash + skill["name"] + " O.png")
                        # /run RotationTextureFrame.texture:SetTexture(GetSpellTexture("23881"))
                        pyautogui.hotkey("enter")
                        pyperclip.copy('/run RotationTextureFrame2.texture:SetTexture(' + str(skill["type"]) + '(' + str(skill["id"]) + '))')
                        if os.name == "posix":
                            pyautogui.hotkey('command', 'v')
                        else:
                            pyautogui.hotkey('ctrl', 'v')
                        pyautogui.hotkey("enter")

                        time.sleep(time1)
                        o_image = abilities_folder + slash + str(skill["name"]) + " O.png".format(**p_offgcd)
                        offgcd_image = sct.grab(p_offgcd)
                        mss.tools.to_png(offgcd_image.rgb, offgcd_image.size, output=o_image)
                        time.sleep(time2)

                except:
                    print("no class", wow_class)

                for skill in skills["healing"]:
                    number = number + 1
                    print(number, wow_class, skill["name"], abilities_folder + slash + skill["name"] + " H.png")
                    pyautogui.hotkey("enter")
                    pyperclip.copy('/run RotationTextureFrame1.texture:SetTexture(' + str(skill["type"]) + '(' + str(skill["id"]) + '))')
                    if os.name == "posix":
                        pyautogui.hotkey('command', 'v')
                    else:
                        pyautogui.hotkey('ctrl', 'v')
                    pyautogui.hotkey("enter")

                    time.sleep(time1)
                    m_image = abilities_folder + slash + str(skill["name"]) + " H.png".format(**p_main)
                    main_image = sct.grab(p_main)
                    mss.tools.to_png(main_image.rgb, main_image.size, output=m_image)
                    time.sleep(time2)

                pyautogui.hotkey("enter")
                pyperclip.copy('/run RotationTextureFrame1:Hide()')
                if os.name == "posix":
                    pyautogui.hotkey('command', 'v')
                else:
                    pyautogui.hotkey('ctrl', 'v')
                pyautogui.hotkey("enter")

                time.sleep(time1)

                pyautogui.hotkey("enter")
                pyperclip.copy('/run RotationTextureFrame2:Hide()')
                if os.name == "posix":
                    pyautogui.hotkey('command', 'v')
                else:
                    pyautogui.hotkey('ctrl', 'v')
                pyautogui.hotkey("enter")
