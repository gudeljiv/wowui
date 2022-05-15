import mss
import mss.tools
import time
from pynput import keyboard

# x = 1535
# y = 1150

x = 6
y = 6

aoe = False
debug = False
dprint = False


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
            if debug:
                start_time = time.time()
                # The screen part to capture
                monitor = {
                    "top": 0,
                    "left": 0,
                    "width": x*2,
                    "height": y*2
                }
                output = "{top}x{left}_{width}x{height}.png".format(**monitor)

                # Grab the data
                image = sct.grab(monitor)
                rgb = image.pixel(int(x/2), int(y/2))

                # Save to the picture file
                mss.tools.to_png(image.rgb, image.size, output=output)
                print(output, rgb, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
