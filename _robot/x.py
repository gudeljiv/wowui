from libs.ctypes_custom import KeyPress as cKeyPress
import time
import random

# def PressKey(key):
#     interception_press = key_stroke(key, interception_key_state.INTERCEPTION_KEY_DOWN.value, 0)
#     driver.send(get_keyboard_driver(), interception_press)
#     return interception_press


# def ReleaseKey(interception_press):
#     interception_press.state = interception_key_state.INTERCEPTION_KEY_UP.value
#     driver.send(get_keyboard_driver(), interception_press)


# def press_interception_key(key, modifier=False):
#     m = modifier

#     if m:
#         rm = PressKey(m)
#     r = PressKey(key)
#     ReleaseKey(r)
#     if m:
#         ReleaseKey(rm)


X = 0x2D
ONE = 0x02
SHIFT = 0x2A

# time.sleep(3)
# press_interception_key(X)
# quit()
time.sleep(1)
for i in range(1000):
    time.sleep(random.uniform(0.2, 0.99))
    # print("press X")
    # press_interception_key(X)
    cKeyPress("x")
