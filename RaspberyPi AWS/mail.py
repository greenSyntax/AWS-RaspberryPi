# Mail Demo

import smtplib

server = smtplib.SMTP('smtp.gmail.com', 587)
server.starttls()

server.login("ab.abhishek.ravi@gmail.com", "xhanuman")

# Mail Body
message  = "Hi This is my RaspberryPi Text"

server.sendmail("ab.abhishek.ravi@gmail.com","ab.abhishek.ravi@gmail.com", message)

server.quit()

