import mss
from screeninfo import get_monitors


for m in get_monitors():
    if (m.is_primary):
        print(m.width, m.height)
        cx = m.width/2
        cy = m.height/2


with mss.mss() as sct:

    while True:
        pic = sct.grab({'mon': 1, 'top': cx, 'left': cy, 'width': 1, 'height': 1})
        g = pic.pixel(0, 0)
        print(cx, cy, g)
