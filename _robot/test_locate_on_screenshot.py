import cv2
import numpy as np
import pyautogui as pg
from pynput import keyboard
import os
import sys
import mss
import mss.tools
import numpy
import math
import pyperclip
import time

debug = False


def on_press(key):
    global debug, dprint, pause, mill

    if key.char == "+":
        debug = not debug
        print("debug:", debug)


with keyboard.Listener(on_press=on_press) as listener:

    with mss.mss() as sct:

        while True:

            if debug:

                time.sleep(1)

                screenshot = pg.screenshot("screenshot.png")
                screenshot = cv2.cvtColor(np.array(screenshot), cv2.COLOR_RGB2BGR)

# # board = pg.locateOnScreen('board.png')

# # display screenshot in a window
# cv2.imshow('Screenshot', screenshot)

# # escape condition
# cv2.waitKey(0)

# # clean up windows
# cv2.destroyAllWindows()
