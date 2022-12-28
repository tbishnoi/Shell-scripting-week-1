#!/bin/bash
#run without arg

today_str="today"
tomorrow_str="tomorrow"
declare -a today_array=()
tomorrow_array=()
shopt -s nocasematch

echo $teststr
print_spaces(){
    # echo "subt-- "$1
    if [[ "$2" == true ]]
        then
            next_line="\n"
        else
            next_line=""
    fi

    for (( i=0; i<=$1;i++ ))
    do  
        echo -ne " "
    
        if [[ $i == $1 ]]
            then
                echo -ne "|"$next_line
        fi
done

}

print_dash(){
    for (( k=0; k<$1; k++ ))
    do
        echo -ne "-"
    done

    echo ""

}


##read data from agenda.txt file
while IFS= read -r line; do
    case "$line" in
    today) push_to_tomorrow=false
        push_to_today=true
        continue;;
    tomorrow)
        push_to_today=false
        push_to_tomorrow=true
        continue;;
    esac

     if [[ $line == [[:digit:]]* ]]
    then
        push_to_today=false
        push_to_tomorrow=false
    fi

    if [[ "$push_to_today" == true ]]
        then
            line_trimmed=$(echo $line | sed -e 's/^[[:space:]]*//')
            today_array+=("$line_trimmed")
    fi

    if [[ "$push_to_tomorrow" == true ]]
        then
            line_trimmed=$(echo $line | sed -e 's/^[[:space:]]*//')
            tomorrow_array+=("$line_trimmed")
    fi  
done < Agenda.txt


#calculating longest string in each array for tabular output
today_str_length=0
for item in "${today_array[@]}"
do
    if [[ today_str_length -lt ${#item} ]]
    then
        today_str_length=${#item}
    fi 
done

tomorrow_str_length=0

for item in "${tomorrow_array[@]}"
do
    if [[ tomorrow_str_length -lt ${#item} ]]
    then
        tomorrow_str_length=${#item}
    fi
done


today_arr_length=${#today_array[@]}
tomorrow_arr_length=${#tomorrow_array[@]}

highest_arr_length=$today_arr_length

if [[ $highest_arr_length -lt $tomorrow_arr_length ]]
then
    highest_arr_length=$tomorrow_arr_length
fi


##printing data in table format

print_dash $((today_str_length+tomorrow_str_length+7))

echo -ne "| Today"
print_spaces $((today_str_length-5)) false

echo -ne " Tomorrow"
print_spaces $((tomorrow_str_length-8)) true

print_dash $((today_str_length+tomorrow_str_length+7))

for (( j=0; j<highest_arr_length; j++ ))
    do 
        echo -ne "| "${today_array[j]}
        item_length=${#today_array[j]}
        print_spaces $((today_str_length-item_length)) false

        echo -ne " "${tomorrow_array[j]}
        item_length=${#tomorrow_array[j]}
        print_spaces $((tomorrow_str_length-item_length)) true
    done


print_dash $((today_str_length+tomorrow_str_length+7))