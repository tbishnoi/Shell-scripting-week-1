#!/bin/bash
#reverse_order.sh <string>
##example
###reverse_order.sh "This is an example"
#Reverse each letter in sentence 

if [ $# -eq 0 ] || [ -z ${*// } ]
then
   echo "error: Please provide input."
   exit 1
fi

rev_str=''

for input_str in $*
do
   size=${#input_str}
   for (( i=$size-1; i>=0; i-- ))
   do
      input_str=${input_str,,}
      rev_str="$rev_str${input_str:$i:1}"
   done
   rev_str="$rev_str"
done

echo "$rev_str" | sed 's/./\U&/'