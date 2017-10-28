import  RPi.GPIO as GPIO
import time

#Intialization
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

#Intialize Push Button
GPIO.setup(18, GPIO.IN,pull_up_down=GPIO.PUD_UP)

#Intialize LED
GPIO.setup(17, GPIO.OUT)

# When Button is PRESSED
def buttonPressed():
	GPIO.output(17,GPIO.HIGH)
        return

# When Button is RELEASED
def buttonReleased():
	GPIO.output(17, GPIO.LOW)
	return

while True:
    #User Input
    inputValue = GPIO.input(18)    

    if (inputValue == False):
        buttonPressed()
    else:
        buttonReleased()
    time.sleep(0.5)



