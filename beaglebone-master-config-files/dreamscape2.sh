#!/bin/bash

export XAUTHORITY=/var/run/lightdm/root/\:0 
export DISPLAY=:0.0

exec /home/debian/processing-2.2.1/processing-java --sketch=/home/debian/dreamscape2/Dreamscape-II/DreamscapeII/roles/lamppost/files/dreamscape --output=/tmp/processing-tmp --force --run
