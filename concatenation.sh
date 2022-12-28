#!/bin/bash
# concatenation.sh <string to be matched> <comma separated strings>
##example:
##concatenation.sh "abcdefghij" "ab,cd,ef"

str=$1
str_length=${#str}
words=$2
words=(${words//,/ })
word_length=${#words[0]} 
words_arr_length=${#words[@]} 

substr_size=$(($word_length * $words_arr_length))

if [[ "$str_length" -lt "$substr_size" ]]
then
   echo "string size is not large enough"
   exit 1
fi

bar=$(IFS=, ; echo "${words[*]}")
evalStr=''
for (( i=0 ; i < $words_arr_length ; i++ ))
   do
      evalStr=$evalStr{${bar[@]}}
   done

combination=$(eval echo ${evalStr[@]})

perm_array=()
echo "Please wait"
regex_exp='\b\w*(\w{'$word_length'})\w*\1'

for el in $combination
do
   (echo $el | grep -Eq  '\b\w*(\w{2})\w*\1') && discard=true || discard=false
   
   if [ "$discard" = false ]
      then
         perm_array+=($el)
      fi

   echo -ne "."
done

result=()
for (( s=0 ; s<$str_length ; s++ ))
do
   if [[ $(($str_length - $s)) -lt $substr_size ]]
   then
      break;
   fi
   
   substr=${str:$s:$substr_size}
   if [[ " ${perm_array[*]} " =~ " ${substr} " ]]; 
   then
      result+=($s)

   fi

done

echo -e "\n Result Indices:" ${result[@]}
