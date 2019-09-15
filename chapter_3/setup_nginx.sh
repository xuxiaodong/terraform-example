#!/bin/bash

sudo apt update
sudo apt install -y nginx
echo Created: ${time} | sudo tee /var/www/html/index.html
exit 0
