import time
from pprint import pprint
# import keyboard
# from PIL import Image, ImageGrab

import mss.tools
import mss

x = 1285
y = 865
margin = 1

# while not keyboard.is_pressed('ctrl'):  # press ctrl to stop.
#     start_time = time.time()
#     px = ImageGrab.grab().load()
#     color = px[x, y]  # pixel 1
#     print(color, px, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")  # how much  he takes to finish


with mss.mss() as sct:

    while True:
        # The screen part to capture
        start_time = time.time()
        monitor = {"top": y-margin, "left": x-margin, "width": margin*2, "height": margin*2}
        output = "sct-{top}x{left}_{width}x{height}.png".format(**monitor)

        # Grab the data
        sct_img = sct.grab(monitor)

        # Save to the picture file
        mss.tools.to_png(sct_img.rgb, sct_img.size, output=output)
        print(output, f"Finish in: {round(1000 * (time.time() - start_time))} ms ")
