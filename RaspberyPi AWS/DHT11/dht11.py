import RPi.GPIO as GPIO
import Adafruit_DHT

GPIO.setmode(GPIO.BCM)

# DHT Sensor Type
pin=17

# Humidity Calculation
while True:
	humidity, temperature = Adafruit_DHT.read_retry(11,pin)
	print(" Temperature = ".temperature)
