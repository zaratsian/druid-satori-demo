#!/bin/sh

#sudo yum install -y python-pip
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py

sudo pip install kafka pykafka satori-rtm-sdk backports.ssl PyOpenSSL 
