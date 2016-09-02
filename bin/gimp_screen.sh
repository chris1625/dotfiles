#!/bin/bash

# Get latest screenshot from directory
IMAGE=`ls -Art /home/chris/Pictures/screenshots/ | tail -n 1`

gimp /home/chris/Pictures/screenshots/$IMAGE
