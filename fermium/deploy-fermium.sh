#!/bin/bash

# Install Deps:
apt update
apt install python3.8-venv

# Install Python Environment:
mkdir -v /fermium
cd /fermium
python3 -m venv ./venv
. ./venv/bin/activate

# Grab Code:
curl https://raw.githubusercontent.com/krallice/config/master/fermium/main.py -o ./main.py

# Run:
export FLASK_APP="main"; flask run --host="0.0.0.0" --port="80"
