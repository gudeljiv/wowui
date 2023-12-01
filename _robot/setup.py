import sys

if len(sys.argv) != 2:
    mode = "wotlk"
else:
    mode = sys.argv[1]

if mode == "wotlk":
    from libs.resources_wotlk import data
    from libs.resources_wotlk import monitor_settings
else:
    from libs.resources_classic import data
    from libs.resources_classic import monitor_settings

import time
import pyautogui

import os
import mss
import mss.tools
import math
import pyperclip

if (os.name == "posix"):
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
    abilities_folder = dir_path + "/images/" + mode + "/" + monitor
    slash = "/"
else:
    abilities_folder = dir_path + r"\images\\" + mode + r"\\" + monitor
    slash = "\\"

if not os.path.exists(abilities_folder):
    os.makedirs(abilities_folder)


skills_loaded = "warrior"
print("Script loaded and ready.", "Monitor:", screen_width,
      screen_height, datetime.now().strftime("%H:%M:%S"), os.name)
print("MODE:", mode.upper())
print("CLASS:", wow_class_loaded.upper())


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

time1 = 0.25
time2 = 0.75

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


with keyboard.Listener(on_press=on_press) as listener:

    with mss.mss() as sct:

        while True:
            start_time = time.time()
            # time.sleep(1)

            p_main = {"top": 2, "left": 2, "width": x, "height": y}
            p_offgcd = {"top": 2, "left":  p_offgcd_left,
                        "width": x, "height": y}
            p_combat = {"top": 0, "left": p_combat_left,
                        "width": c_width, "height": c_height}
            p_interrupt = {"top": 0, "left": p_interrupt_left,
                           "width": c_width, "height": c_height}
            p_behind = {"top": 0, "left": p_behind_left,
                        "width": c_width, "height": c_height}
            p_clss = {"top": 0, "left": p_clss_left,
                      "width": c_width, "height": c_height}

            clss_image = sct.grab(p_clss)
            clss = clss_image.pixel(math.floor(
                c_width/2), math.floor(c_height/2))
            hex = '#%02x%02x%02x' % clss

            time.sleep(1)
            # matching closest class color to define in colors
            found_class = False

            found_class, wow_class = get_class(clss, color_distance)
            # print(found_class, wow_class, hex)
            if not found_class:
                continue

            if wow_class_loaded != wow_class:
                print("class:", wow_class_loaded.upper(),
                      "->", wow_class.upper())
                wow_class_loaded = wow_class

            folders = [abilities_folder + slash + wow_class, abilities_folder +
                       slash + "healing", abilities_folder + slash + "globals"]

            for folder in folders:
                if not os.path.exists(folder):
                    os.makedirs(folder)
                # else:
                #     for f in os.listdir(folder):
                #         os.remove(os.path.join(folder, f))

            if count > 0:
                quit()

            if debug:
                count = count + 1

                # pyautogui.hotkey("enter")
                # pyperclip.copy('/run RotationTextureFrame1:Show()')
                # if os.name == "posix":
                #     pyautogui.hotkey('command', 'v')
                # else:
                #     pyautogui.hotkey('ctrl', 'v')
                # time.sleep(time1)
                # pyautogui.hotkey("enter")

                # pyautogui.hotkey("enter")
                # pyperclip.copy('/run RotationTextureFrame2:Show()')
                # if os.name == "posix":
                #     pyautogui.hotkey('command', 'v')
                # else:
                #     pyautogui.hotkey('ctrl', 'v')
                # time.sleep(time1)
                # pyautogui.hotkey("enter")

                # for wow_class in classes:

                for skill in data[wow_class]["main"]:
                    number = number + 1
                    main_image = False
                    pyautogui.hotkey("enter")
                    # pyperclip.copy('/run RotationTextureFrame1.texture:SetTexture(' + str(skill["type"]) + '(' + str(skill["id"]) + '))')
                    t = skill["type"] == "GetSpellTexture" and 1 or 2
                    s = skill["id"]
                    time.sleep(time1)
                    pyperclip.copy(
                        '/run xRTF(1,' + str(t) + ',' + str(s) + ')')
                    if os.name == "posix":
                        pyautogui.hotkey('command', 'v')
                    else:
                        pyautogui.hotkey('ctrl', 'v')
                    time.sleep(time1)
                    pyautogui.hotkey("enter")
                    time.sleep(time1)
                    time.sleep(time1)

                    m_image = abilities_folder + slash + wow_class + \
                        slash + str(skill["name"]) + " M.png".format(**p_main)
                    main_image = sct.grab(p_main)
                    mss.tools.to_png(
                        main_image.rgb, main_image.size, output=m_image)
                    print_debug(number, wow_class, skill["name"], abilities_folder +
                                slash + wow_class + slash + skill["name"] + " M.png")
                    time.sleep(time2)

                for skill in data[wow_class]["secondary"]:
                    number = number + 1
                    offgcd_image = False
                    pyautogui.hotkey("enter")
                    # pyperclip.copy('/run RotationTextureFrame2.texture:SetTexture(' + str(skill["type"]) + '(' + str(skill["id"]) + '))')
                    t = skill["type"] == "GetSpellTexture" and 1 or 2
                    s = skill["id"]
                    time.sleep(time1)
                    pyperclip.copy(
                        '/run xRTF(2,' + str(t) + ',' + str(s) + ')')
                    if os.name == "posix":
                        pyautogui.hotkey('command', 'v')
                    else:
                        pyautogui.hotkey('ctrl', 'v')
                    time.sleep(time1)
                    pyautogui.hotkey("enter")
                    time.sleep(time1)
                    time.sleep(time1)

                    o_image = abilities_folder + slash + wow_class + slash + \
                        str(skill["name"]) + " O.png".format(**p_offgcd)
                    offgcd_image = sct.grab(p_offgcd)
                    mss.tools.to_png(offgcd_image.rgb,
                                     offgcd_image.size, output=o_image)
                    print_debug(
                        number, wow_class, skill["name"], abilities_folder + slash + skill["name"] + " O.png")
                    time.sleep(time2)

                for skill in data["healing"]:
                    number = number + 1
                    main_image = False
                    pyautogui.hotkey("enter")
                    # pyperclip.copy('/run RotationTextureFrame1.texture:SetTexture(' + str(skill["type"]) + '(' + str(skill["id"]) + '))')
                    t = skill["type"] == "GetSpellTexture" and 1 or 2
                    s = skill["id"]
                    time.sleep(time1)
                    pyperclip.copy(
                        '/run xRTF(1,' + str(t) + ',' + str(s) + ')')
                    if os.name == "posix":
                        pyautogui.hotkey('command', 'v')
                    else:
                        pyautogui.hotkey('ctrl', 'v')
                    time.sleep(time1)
                    pyautogui.hotkey("enter")
                    time.sleep(time1)
                    time.sleep(time1)

                    m_image = abilities_folder + slash + "healing" + \
                        slash + str(skill["name"]) + " H.png".format(**p_main)
                    main_image = sct.grab(p_main)
                    mss.tools.to_png(
                        main_image.rgb, main_image.size, output=m_image)
                    print_debug(number, wow_class, skill["name"], abilities_folder +
                                slash + "healing" + slash + skill["name"] + " H.png")
                    time.sleep(time2)

                for skill in data["globals"]:
                    number = number + 1
                    main_image = False
                    pyautogui.hotkey("enter")
                    # pyperclip.copy('/run RotationTextureFrame1.texture:SetTexture(' + str(skill["type"]) + '(' + str(skill["id"]) + '))')
                    t = skill["type"] == "GetSpellTexture" and 1 or 2
                    s = skill["id"]
                    time.sleep(time1)
                    pyperclip.copy(
                        '/run xRTF(2,' + str(t) + ',' + str(s) + ')')
                    if os.name == "posix":
                        pyautogui.hotkey('command', 'v')
                    else:
                        pyautogui.hotkey('ctrl', 'v')
                    time.sleep(time1)
                    pyautogui.hotkey("enter")
                    time.sleep(time1)
                    time.sleep(time1)

                    m_image = abilities_folder + slash + "globals" + \
                        slash + str(skill["name"]) + " G.png".format(**p_main)
                    main_image = sct.grab(p_main)
                    mss.tools.to_png(
                        main_image.rgb, main_image.size, output=m_image)
                    print_debug(number, wow_class, skill["name"], abilities_folder +
                                slash + "globals" + slash + skill["name"] + " G.png")
                    time.sleep(time2)

                pyautogui.hotkey("enter")
                pyperclip.copy('/run xRTFH(1)')
                if os.name == "posix":
                    pyautogui.hotkey('command', 'v')
                else:
                    pyautogui.hotkey('ctrl', 'v')
                time.sleep(time1)
                pyautogui.hotkey("enter")

                pyautogui.hotkey("enter")
                pyperclip.copy('/run xRTFH(2)')
                if os.name == "posix":
                    pyautogui.hotkey('command', 'v')
                else:
                    pyautogui.hotkey('ctrl', 'v')
                time.sleep(time1)
                pyautogui.hotkey("enter")
