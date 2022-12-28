#!/usr/bin/bash
#run without args
##example:
## letter_frequencies.sh
sed -e  "s/[^A-Za-z']/ /g" Letters.txt | tr 'A-Z' 'a-z' | tr ' ' '\n' | grep -v '^$'| sort | uniq -c | sort -rn