#!/bin/bash
#copy config to folder
cp config/* /tmp

mkdir -p /opt/www && echo '"Accuhit IT!!!"' > /opt/www/index.html
