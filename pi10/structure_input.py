#!/usr/bin/env python3

import time
import sys

import util
import pi_gpio as GPIO

if len(sys.argv) != 2:
    print("""Usage:
    structure_input.py <config_file>
""")
    sys.exit(1)

config = util.DreamlandConfig(sys.argv[1])
pub = util.PubClient(config.master(), config.topic())

input_info = list(config.input().items())[0]
name = input_info[0]
button = GPIO.GPIO_button(input_info[1])

def pressed():
    print("pressed")
    pub.send(name, GPIO.HIGH)
    
def released():
    print("released")
    pub.send(name, GPIO.LOW)

if config.config.get('reversed', False) is True:
    pressed, released = released, pressed

callback_map = {1: pressed, 0: released}
lastvalue = 1

while True:
    value = button.value()
    if value != lastvalue:
        callback_map[value]()
        lastvalue = value
    time.sleep(.2)

    #button.wait(GPIO.BUTTON_PRESSED, released)
    #button.wait(GPIO.BUTTON_RELEASED, pressed)
