import RPi.GPIO as GPIO

# Declartions
LED = 7

#Intialize
GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)
GPIO.setup(LED,GPIO.OUT)

GPIO.output(LED,True)
print("LED ON")
