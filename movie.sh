#!/usr/bin/bash
# movie.sh <movie name>
##example
## ./movie.sh "top gun maverick"


str=$1
str="${str// /+}"
cmd=$(curl -s -H "A: B" "https://omdbapi.com/?apikey=c88724e0&t=$str")  

error=$(echo "$cmd" | grep -o '"Error":"[^"]*' | grep -o '[^"]*$')

if [[ $error ]]
    then
        echo "Error - "$error
        exit 1;
fi

echo -ne "Title: "
echo -ne $cmd | grep -o '"Title":"[^"]*' | grep -o '[^"]*$'

echo -ne "Year: "
echo -ne $cmd | grep -o '"Year":"[^"]*' | grep -o '[^"]*$'

echo -ne "Synopsis: "
echo -ne $cmd | grep -o '"Plot":"[^"]*' | grep -o '[^"]*$'

