from _skills import skills
from _colors import color
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

if monitor == "3840":
    x = 15
    y = 15
    c_width = 7
    c_height = 7
    p_offgcd_left = 21
    p_combat_left = 39
    p_interrupt_left = 57
    p_behind_left = 74
    p_clss_left = 88
if monitor == "2560":
    x = 12
    y = 12
    c_width = 5
    c_height = 5
    p_offgcd_left = 19
    p_combat_left = 40
    p_interrupt_left = 54
    p_behind_left = 64
    p_clss_left = 77
if monitor == "3072":
    x = 12
    y = 12
    c_width = 5
    c_height = 5
    p_offgcd_left = 19
    p_combat_left = 40
    p_interrupt_left = 54
    p_behind_left = 64
    p_clss_left = 77
if monitor == "2048.0":
    x = 8
    y = 8
    c_width = 5
    c_height = 5
    p_offgcd_left = 13
    p_combat_left = 24
    p_interrupt_left = 33
    p_behind_left = 43
    p_clss_left = 52

file_path = os.path.abspath(__file__)
dir_path = os.path.dirname(os.path.realpath(__file__))

if os.name == "posix":
    abilities_folder = dir_path + "/images/" + monitor
    slash = "/"
else:
    abilities_folder = dir_path + "\images\\" + monitor
    slash = "\\"

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


classes = {
    "warrior", "druid", "rogue", "warlock", "mage", "hunter", "death knight", "priest"
}

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

            if count > 0:
                quit()

            if debug:
                count = count + 1

                pyautogui.hotkey("enter")
                time.sleep(0.5)
                pyperclip.copy('/run RotationTextureFrame:Show()')
                if os.name == "posix":
                    pyautogui.hotkey('command', 'v')
                else:
                    pyautogui.hotkey('ctrl', 'v')
                pyautogui.hotkey("enter")

                for wclass in classes:

                    try:
                        for skill in skills[wclass]:
                            number = number + 1
                            print(number, wclass, skill["name"], abilities_folder + slash + skill["name"]+".png")
                            # /run RotationTextureFrame.texture:SetTexture(GetSpellTexture("23881"))
                            pyautogui.hotkey("enter")
                            time.sleep(0.3)
                            pyperclip.copy('/run RotationTextureFrame.texture:SetTexture(GetSpellTexture(' + str(skill["id"]) + '))')
                            if os.name == "posix":
                                pyautogui.hotkey('command', 'v')
                            else:
                                pyautogui.hotkey('ctrl', 'v')
                            pyautogui.hotkey("enter")
                            time.sleep(0.3)

                            m_image = abilities_folder + slash + str(skill["name"]) + ".png".format(**p_main)
                            main_image = sct.grab(p_main)
                            mss.tools.to_png(main_image.rgb, main_image.size, output=m_image)
                            time.sleep(0.3)

                        for skill in skills["offgcd"][wclass]:
                            number = number + 1
                            print(number, wclass, skill["name"], abilities_folder + slash + skill["name"]+".png")
                            # /run RotationTextureFrame.texture:SetTexture(GetSpellTexture("23881"))
                            pyautogui.hotkey("enter")
                            time.sleep(0.3)
                            pyperclip.copy('/run RotationTextureFrame.texture:SetTexture(GetSpellTexture(' + str(skill["id"]) + '))')
                            if os.name == "posix":
                                pyautogui.hotkey('command', 'v')
                            else:
                                pyautogui.hotkey('ctrl', 'v')
                            pyautogui.hotkey("enter")
                            time.sleep(0.3)

                            m_image = abilities_folder + slash + str(skill["name"]) + ".png".format(**p_main)
                            main_image = sct.grab(p_main)
                            mss.tools.to_png(main_image.rgb, main_image.size, output=m_image)
                            time.sleep(0.3)

                    except:
                        print("no class", wclass)

                for skill in skills["healing"]:
                    number = number + 1
                    print(number, wclass, skill["name"], abilities_folder + slash + skill["name"]+".png")
                    pyautogui.hotkey("enter")
                    time.sleep(0.3)
                    pyperclip.copy('/run RotationTextureFrame.texture:SetTexture(GetSpellTexture(' + str(skill["id"]) + '))')
                    if os.name == "posix":
                        pyautogui.hotkey('command', 'v')
                    else:
                        pyautogui.hotkey('ctrl', 'v')
                    pyautogui.hotkey("enter")
                    time.sleep(0.3)

                    m_image = abilities_folder + slash + str(skill["name"]) + ".png".format(**p_main)
                    main_image = sct.grab(p_main)
                    mss.tools.to_png(main_image.rgb, main_image.size, output=m_image)
                    time.sleep(0.3)

                pyautogui.hotkey("enter")
                time.sleep(0.5)
                pyperclip.copy('/run RotationTextureFrame:Hide()')
                if os.name == "posix":
                    pyautogui.hotkey('command', 'v')
                else:
                    pyautogui.hotkey('ctrl', 'v')
                pyautogui.hotkey("enter")
