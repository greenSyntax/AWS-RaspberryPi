import time
from sense_hat import SenseHat

count = 0

while count != 100:
	sense = SenseHat()
	sense.show_message("IRONMAN", text_colour=[255, 0, 0])
	count += 1

