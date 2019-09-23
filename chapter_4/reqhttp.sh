#!/bin/bash

url="$1"

count=1
while true; do
    echo -n $count:
    curl "$url"
    sleep 30
    count=$((count + 1))
done
