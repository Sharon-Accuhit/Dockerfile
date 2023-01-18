#!/bin/bash
#copy config to folder
cp config/* /tmp

mkdir -p /opt/www && echo '"Accuhit IT GO!"' > /opt/www/index.html
