from libs.ctypes_custom import KeyPress as cKeyPress
import time
from libs.interception import *
driver = interception()


def get_keyboard_driver():
    for i in range(MAX_DEVICES):
        if interception.is_keyboard(i):
            keyboard = i
            return keyboard


# def press_interception_key(key):
#     interception_press = key_stroke(key, interception_key_state.INTERCEPTION_KEY_DOWN.value, 0)
#     driver.send(get_keyboard_driver(), interception_press)
#     interception_press.state = interception_key_state.INTERCEPTION_KEY_UP.value
#     driver.send(get_keyboard_driver(), interception_press)


# WINLEFT = 0x02

# press_interception_key(WINLEFT)


def PressKey(key):
    interception_press = key_stroke(key, interception_key_state.INTERCEPTION_KEY_DOWN.value, 0)
    driver.send(get_keyboard_driver(), interception_press)
    return interception_press


def ReleaseKey(interception_press):
    interception_press.state = interception_key_state.INTERCEPTION_KEY_UP.value
    driver.send(get_keyboard_driver(), interception_press)


def press_interception_key(key, modifier=False):

    m = modifier

    if m:
        rm = PressKey(m)
    r = PressKey(key)
    ReleaseKey(r)
    if m:
        ReleaseKey(rm)


X = 0x2D
ONE = 0x02
SHIFT = 0x2A

# time.sleep(3)
# press_interception_key(X)
# quit()
time.sleep(3)
for i in range(500):
    time.sleep(2)
    press_interception_key(X)
    # cKeyPress("x")
