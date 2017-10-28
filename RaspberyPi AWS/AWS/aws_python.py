from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
from sense_hat import SenseHat
import time
import threading
import json


#Sense HAT
sense = SenseHat()

def decodeJSON(jsonData):
        decode = json.loads(jsonData)
        state = decode["state"]["ledstate"]
        #print "LED STATE is %s" % state
        return state

def turnOnLights():
        sense.clear(255, 255, 255)
        sense.low_light = True

def turnOffLights():
        sense.clear(0, 0, 0)
        sense.low_light = False

def getHumidity():
        humidity = sense.get_humidity()
        return humidity

def getTemperature():
        temp = sense.get_temperature()
        return temp

def getPressure():
        pressure = sense.get_pressure()
        return pressure

# Payload Data
def getPayloadData():
        payloadData = "{\"temperature\": %s, \"humidity\": %s, \"pressure\": %s}" % (getTemperature() ,  getHumidity() , getPressure()) 
        return payloadData
        
 
# Setup Priyanshu AWS Keywords

thingName = "resppi"
endPointName = "a302e8vhjk9sn8.iot.us-west-2.amazonaws.com"
portNumber = 8883
#topicName = "envdetail/pione"

deltaTopicName = "$aws/things/resppi/shadow/update/delta" 

connectionTimeOut = 60 
restartConnectionTimeout = 10
privateKeyPath = "certsPriyanshu/private.key"
certificateAuthorityPath = "certsPriyanshu/CA-root.pem"
certficatePath = "certsPriyanshu/certificate.crt"
triggerConstant = 2
ledFlag = False

# Credentials for Abhishek's AWS Account
'''
thingName = "RaspberryPi"
endPointName = "adh1h85khiovw.iot.us-west-2.amazonaws.com"
portNumber = 8883
topicName = "aws_iot"
connectionTimeOut = 60 
restartConnectionTimeout = 10
privateKeyPath = "certs/private.key"
certificateAuthorityPath = "certs/CA-root.pem"
certficatePath = "certs/certificate.crt"
triggerConstant = 2
'''
# Handler Methods

def customCallback(client, userdata, message):
        print("Received a new message: ")
        print(message.payload)
        print("from topic: ")
        print(message.topic)
        state = decodeJSON(message.payload)
        print "-----------"
        if state == "on":
                print "LED is ON"
                ledFlag = True
                turnOnLights()
                publishShadowState(ledFlag)
        else:
                print "LED is OFF"
                ledFlag = False
                turnOffLights()
                publishShadowState(ledFlag)
        
                

# Create MQTT Client Object
myMQTTClient = AWSIoTMQTTClient(thingName)

#Set Endpoints
myMQTTClient.configureEndpoint(endPointName, portNumber)

# Initialize With Certificates
myMQTTClient.configureCredentials(certificateAuthorityPath, privateKeyPath, certficatePath)

myMQTTClient.configureOfflinePublishQueueing(-1)
myMQTTClient.configureDrainingFrequency(2)
myMQTTClient.configureConnectDisconnectTimeout(restartConnectionTimeout)
myMQTTClient.configureMQTTOperationTimeout(connectionTimeOut) 
myMQTTClient.configureAutoReconnectBackoffTime(1, 32, 20)

# Connect to AWS
myMQTTClient.connect()

print "> Connected to ' %s '" % thingName 


# Publish to Topic
def publishSensorData():
        topicForSesnor = "envdetail/pione"
        myMQTTClient.publish(topicForSesnor, getPayloadData(), 0)
        print "> Payload Published to ' %s '" %topicForSesnor
        print "> Payload : %s" % getPayloadData()
	#sense.show_message("IRONMAN", text_colour=[255,0,0])
	print "-------"



# Publish to Shadow Topic

def publishShadowState(ledFlag):
        if ledFlag == True:
                jsonForShadowPublish = "{\"state\": {\"reported\": {\"ledstate\": \"on\"}}}"
                
        else:
                jsonForShadowPublish = "{\"state\": {\"reported\": {\"ledstate\": \"off\"}}}"
        
        publishpTopicName = "$aws/things/resppi/shadow/update"
        
        myMQTTClient.publish(publishpTopicName, jsonForShadowPublish, 0)
        print "> Payload Published to ' %s '" % publishpTopicName
        print "> Payload : %s" % jsonForShadowPublish
        #sense.show_message("JARVIS", text_colour=[0,255,0])
        print "------"


# Update AWS
def updateAWS():
        threading.Timer(60.0, updateAWS).start()
        publishSensorData()
        #publishShadowState()
        print "************"

# Run Scheduler
updateAWS()


# Subscribe to Topic
print " Listening to %s" % deltaTopicName
while True:
        myMQTTClient.subscribe(deltaTopicName, 0, customCallback)
        time.sleep(2)

print "--------------## EOE ##-----------------"
# Disconnect
#myMQTTClient.disconnect()

