#!/usr/bin/env python

from mecode import G

g = G()

for i in range(1,100):
    g.move(0, 100)  # move 10mm in x and 10mm in y
    g.move(100, 0)  # move 10mm in x and 10mm in y
    g.move(0, -100)  # move 10mm in x and 10mm in y
    g.move(-100, 0)  # move 10mm in x and 10mm in y



#g.arc(x=10, y=5, radius=20, direction='CCW')  # counterclockwise arc with a radius of 5
#g.meander(5, 10, spacing=1)  # trace a rectangle meander with 1mm spacing between passes


#g.abs_move(x=1, y=1)  # move the tool head to position (1, 1)
#g.home()  # move the tool head to the origin (0, 0)
