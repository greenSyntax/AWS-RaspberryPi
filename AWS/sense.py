from sense_hat import SenseHat

sense = SenseHat()

# Display 
#sense.show_message("Green Syntaxx ")

# Humidity
humidity = sense.get_humidity()
print("Humidity is %s %%rH" %humidity)

# Temperature
temperature = sense.get_temperature()
print("Temperature is %s C" % temperature)


# Barometric Pressure
pressure = sense.get_pressure()
print("Barometric Pressure is %s Milibar" % pressure)


# Compass
north = sense.get_compass()
print("North %s" % north)

# Gyroscope
acce = sense.get_accelerometer()
print("P : {pitch} , R : {roll}, Y: {yaw}".format(**acce))


