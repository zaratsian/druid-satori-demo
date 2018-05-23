#!/bin/sh
# source 00setup.sh 


#########################################################################
# ENV Vars
#########################################################################
export DRUID_USERNAME=druid
export DRUID_PASSWORD=horton.Mysql123
export DRUID_BROKER=dzaratsian5.field.hortonworks.com:8082
export KAFAK_BROKER=dzaratsian1.field.hortonworks.com:6667
export HIVE_LLAP_HOST=dzaratsian0.field.hortonworks.com:10500


#########################################################################
# Python Dependencies
#########################################################################
#sudo yum install -y python-pip
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py

sudo pip install kafka pykafka satori-rtm-sdk backports.ssl PyOpenSSL 
