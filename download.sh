#!/bin/bash
mkdir -p public
while read -r line; do
  if [ $(curl https://cdpn.io/_/fullpage/$line -w "%{http_code}" -o /dev/null -s) -eq 200 ]; then
    curl https://cdpn.io/_/fullpage/$line -o public/$line.html -H "Referer: https://codepen.io/" -s
    echo "$line download successful"
  else
    echo "$line download failed"
  fi
done < "list.txt"
cd pulbic
prettier --write --print-width 1000 *.html
