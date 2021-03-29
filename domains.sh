#!/bin/bash

if [ $# -gt 2]; then
    echo "Usage: ./script.sh <domain>"
    echo "Example: ./script.sh yahoo.com"
    exit 1

if [ ! -d  "thirdlevels" ]; then
    mkdir thirdlevels
fi

if [ ! -d  "scans" ]; then
    mkdir scans
fi

if [ ! -d  "eyewitness" ]; then
    mkdir eyewitness 
fi

pwd2=$(~/tools/Sublist3r)

echo "Gathering subdomains with Sublist3r..."
cd ~/tools/Sublist3r
python3 sublist3r.py -d $1 -o final.txt

echo $1 >> final.txt

echo "Gathering third-level domains..."
cat final.txt | grep -Po (\w+\.\w+\.w+)$ | sort -u >> third-level.txt

echo "Gathering full third-level domains with Sublist3r..." 
for domain in $(cat third-level.txt); do python3 sublist3r.py -d $domain -o thirdlevels/$domain.txt; cat thirdlevels/$domain.txt | sort -u >> final.txt;done

if [ $# -eq 2]; then
    echo "Probing for alive third-levels..."
    cat final.txt | sort -u | grep -v $2 | httprobe | sed 's/https\?:\/\///' | tr -d ":443" | td -d ":80" > probed.txt
else
    echo "Probing for alive third-levels..."
    cat final.txt | sort -u | httprobe | sed 's/https\?:\/\///' | tr -d ":443" | td -d ":80" > probed.txt

echo "Scanning for open ports..."
nmap -iL probed.txt -T5 -oA scans/scanned.txt

echo "Running Eyewitness..."
cd ~/tools/EyeWitness/Python
python3 EyeWitness.py -f $pwd2/probed.txt -d $1 --all-protocols