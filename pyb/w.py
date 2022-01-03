from pyautogui import *
import pyautogui
import time
import keyboard
import random
from time import gmtime, strftime

aoe = False
debug = False

x = 1280
y = 860

skills = [
    {"name": "battle shout", "key": "f4", "r": 193, "g": 115, "b": 110},
    {"name": "heroic strike", "aoe": False,
        "key": "2", "r": 153, "g": 150, "b": 153},
    {"name": "cleave", "aoe": True,
        "key": "3", "r": 153, "g": 150, "b": 153},
    {"name": "overpower", "key": "2", "r": 153, "g": 150, "b": 153},
    {"name": "sunder armor", "key": "g", "r": 189, "g": 126, "b": 116},
    # {"name": "overpower", "key": "2", "r": 153, "g": 150, "b": 153},
    # {"name": "overpower", "key": "2", "r": 153, "g": 150, "b": 153},
    # {"name": "overpower", "key": "2", "r": 153, "g": 150, "b": 153},
    # {"name": "overpower", "key": "2", "r": 153, "g": 150, "b": 153},
    # {"name": "overpower", "key": "2", "r": 153, "g": 150, "b": 153},
    # {"name": "overpower", "key": "2", "r": 153, "g": 150, "b": 153},
    # {"name": "overpower", "key": "2", "r": 153, "g": 150, "b": 153},
    # {"name": "overpower", "key": "2", "r": 153, "g": 150, "b": 153}
]

while 1 == 2:
    time.sleep(1)
    print(pyautogui.pixel(x, y))


while True:

    if keyboard.is_pressed("f12"):
        debug = not debug

    if keyboard.is_pressed("z"):
        aoe = not aoe

    if debug:
        time.sleep(1)
        print(pyautogui.pixel(x, y))
    else:
        for skill in skills:
            if pyautogui.pixel(x, y)[0] == skill["r"] and pyautogui.pixel(x, y)[1] == skill["g"] and pyautogui.pixel(x, y)[2] == skill["b"]:

                if aoe and "aoe" in skill and not skill["aoe"]:
                    continue
                if not aoe and "aoe" in skill and skill["aoe"]:
                    continue

                print(skill["name"])
                pyautogui.press(skill["key"], presses=3)

    # if pyautogui.pixel(x, y)[0] == 79 and pyautogui.pixel(x, y)[1] == 2 and pyautogui.pixel(x, y)[2] == 0:
    #     print("rend")
    #     pyautogui.press("5", presses=3)
    # if pyautogui.pixel(x, y)[0] == 193 and pyautogui.pixel(x, y)[1] == 115 and pyautogui.pixel(x, y)[2] == 110:
    #     print("battle shout")
    #     pyautogui.press("F4", presses=3)
    # if pyautogui.pixel(x, y)[0] == 153 and pyautogui.pixel(x, y)[1] == 150 and pyautogui.pixel(x, y)[2] == 153:
    #     if aoe:
    #         print("cleave")
    #         pyautogui.press("3", presses=3)
    #     else:
    #         print("heroic strike")
    #         pyautogui.press("2", presses=3)
    # if pyautogui.pixel(x, y)[0] == 89 and pyautogui.pixel(x, y)[1] == 97 and pyautogui.pixel(x, y)[2] == 107:
    #     print("overpower")
    #     pyautogui.press("4", presses=3)
    # if pyautogui.pixel(x, y)[0] == 189 and pyautogui.pixel(x, y)[1] == 126 and pyautogui.pixel(x, y)[2] == 116:
    #     print("sunder armor")
    #     pyautogui.press("G", presses=3)
