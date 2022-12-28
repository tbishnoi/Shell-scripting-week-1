#!/bin/bash
#run without arg
## example
###encryption.sh

algo=false
text=false
length=false

text_str=$1;

if [[ $1 == --* ]]
   then  
      echo "Please enter text that needs to be encrypted."
      exit 1
fi

while (( $# >= 1 )); do 
    case $1 in
    --algo) algo=true;;
    --text) text=true;;
    --length) length=true;;
    esac;
    shift
done

algo_num=$((1 + $RANDOM % 5))

case "${algo_num}" in
   1) echo -ne "Encrypted password: " 
      echo -ne $text_str | sha1sum | awk '{print $1}'
      algo_name="SHA1";;
   2) echo -ne "Encrypted password: "
      echo -ne $text_str | sha256sum| awk '{print $1}'
      algo_name="SHA256";;
   3) echo "Encrypted password: "
      echo -ne $text_str | sha512sum | awk '{print $1}'
      algo_name="SHA512";;
   4) echo -ne "Encrypted password: "
      echo -ne $text_str | md5sum | awk '{print $1}'
      algo_name="MD5";;
   5) echo -ne "Encrypted password: "
      echo -ne $text_str | sha1sum | awk '{print $1}'
      algo_name="SHA1";;
   *) break;
   esac;

if [[ $algo = true ]]
   then
      echo "Algo Name: $algo_name"
fi

if [[ $text = true ]]
   then
      echo "Text passed: $text_str"
fi

if [[ $length = true ]]
   then
      echo "length true"

      echo "Length of Password: ${#text_str}"
fi