#!/usr/bin/bash
filename="./$1"
if [ -f "$filename" ]; then
    i=1
    while read -r url;do
        mkdir $i
        echo "${url} - SCANNING IS STARTED" | notify
        nuclei -u $url -t default-login/ -o $i/default-login.txt
        nuclei -u $url -t takeovers/ -o $i/takeovers.txt
        nuclei -u $url -t misconfiguration/ -o $i/misconfiguration.txt
        nuclei -u $url -t exposures/ -o $i/exposures.txt
        nuclei -u $url -t vulnerabilities/ -o $i/vulnerabilities.txt
        nuclei -u $url -t cves/ -o $i/cves.txt
        i=$((i+1))
        echo "${url} - SCANNING IS FINISHED" | notify
    done < "$filename"
else
    echo "File is not Exist ${filename}"
    exit 
fi
  