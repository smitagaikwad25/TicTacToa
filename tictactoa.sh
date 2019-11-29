#!/bin/bash
echo "WelCome In Tictactoa Simulator"

declare -a bord
#constants


        for (( i=1; i<=9; i++ ))
        do
                bord[$i]=$i 
        done

function displayBord()
{
	local i=1
	for (( j=0; j<3; j++ ))
	do
		echo "|---|---|---|"
		echo "| "${bord[$i]}" | "${bord[$i+1]}" | "${bord[$i+2]}" |"
		i=$(($i+3))
	done
}

function assignLetterXOrO()
{
	assign=1
	random=$((RANDOM%2))
	if [ $assign -eq $random ]
        then
                player=X
                computer=O
                echo "player:" $player 
                echo "computer:" $computer
        else
                player=O
                computer=X
                echo "player:" $player 
                echo "computer:" $computer
        fi
}

function tossToCheckWhoPlaySFirst()
{
        random=$((RANDOM%2+1))
        if [ $random -eq 1 ]
        then
                echo "player's turn now"
        else
                echo "computer's turn now"
        fi
}

assignLetterXOrO
tossToCheckWhoPlaySFirst
displayBord
