#!/bin/bash
pkill -f "qs -c overview"
sleep 0.3
setsid -f qs -c overview
