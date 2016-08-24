#!/bin/bash

killall spotify
killall blockify
spotify &
sleep 1
blockify &
