#! /bin/bash
echo "WelCome In Tictactoa Simulator"

declare -a board
#constants
MAX_CELL_NUM=9
NULL="-"
playerSymbol=0
computerSymbol=0
counter=0



function resetBoard()
{
	for (( index=1; index<=9; index++ ))
	do
		board[$index]=$NULL
	done
}

function assignLetterXOrO()
{
	local assign=1
	random=$((RANDOM%2))
	if [ $assign -eq $random ]
        then
                playerSymbol=X
                computerSymbol=O
                echo "player:"
		echo  $playerSymbol 
                echo "computer:"
		echo  $computerSymbol
        else
                playerSymbol=O
                computerSymbol=X
                echo "player:" $playerSymbol
                echo "computer:" $computerSymbol
        fi
}

function tossToCheckWhoPlaySFirst()
{
        random=$((RANDOM%2+1))
        if [ $random -eq 1 ]
        then
		chanceOf="player"
        else
		chanceOf="computer"
        fi
}

function displayBoard()
{
        local index=1
        for (( j=0; j<3; j++ ))
        do
                echo "|---|---|---|"
                echo "| "${board[$index]}" | "${board[$index+1]}" | "${board[$index+2]}" |"
                index=$(($index+3))
        done
}

function checkForDiagonal()
{
	local symbolToCheck=$1

	for (( diag=1; diag<2; diag++ ))
	do
		if [[ ${board[$diag]} == ${board[$diag+4]} ]] && [[ ${board[$diag+4]} == ${board[$diag+8]} ]] && [[ ${board[$diag+8]} == $symbolToCheck ]]
		then
			displayBoard
			echo "Game Win"
			exit
		elif [[ ${board[$diag+2]} == ${board[$diag+4]} ]] && [[ ${board[$diag+4]} == ${board[$diag+6]} ]] && [[ ${board[$diag+6]} == $symbolToCheck ]]
		then
			displayBoard
			echo "Game Win"
			exit
		fi
	done
}

function checkForRow()
{
	local symbolToCheck=$1
	for (( row=1; row<=9; row=row+3 ))
	do
		if [[ ${board[$row]} == ${board[$row+1]} ]] && [[ ${board[$row+1]} == ${board[$row+2]} ]] && [[ ${board[$row+2]} == $symbolToCheck ]]	
		then
			displayBoard
			echo "Game Win"
			exit
		fi
	done

}

function checkForCol()
{
	local symbolToCheck=$1
	for (( col=1; col<=3; col++ ))
	do
		if [[ ${board[$col]} == ${board[$col+3]} ]] && [[ ${board[$col+3]} == ${board[$col+6]} ]] && [[ ${board[$col+6]} == $symbolToCheck ]]
		then
			displayBoard
			echo "Game win"
			exit
		fi

		col=$((col+1))
	done
}

function checkForTie()
{
	local chanceCount=$1
	if [ $ChanceCount -eq $MAX_CELL_NUM ]
	then
		echo "game is tie"
	fi
}

function checkForWin()
{
	local symbolToCheck=$1
	local chanceCount=$2
	checkForRow $symbolToCheck
	checkForCol $symbolToCheck
	checkForDiagonal $symbolToCheck
	checkForTie $chanceCount
}

function checkForCompMove()
{
	local compCounter=1
	while [ $compCounter -le $MAX_CELL_NUM ]
	do
		if [ ${board[$compCounter]} == $NULL ]
		then
			board[$compCounter]=$computerSymbol
			checkForWin $computerSymbol $count
			board[$compCounter]=$NULL
		fi
		((compCounter++))
	done


}

function startPlaying()
{
	local count=0
	local i=1
	local min=0
	while [[ $i -ge $min && $i -le $MAX_CELL_NUM ]]
	do
		if [ $chanceOf == "player" ]
		then
			displayBoard
			echo "Players turn"
			echo "Select cell to insert your symbol"
			read cellNum
				if [ ${board[$cellNum]} == $NULL ]
				then
					board[$cellNum]=$playerSymbol
					checkForWin $playerSymbol $count
					chanceOf="computer"
				else
					echo "check for empty cell"
				fi
		else
			displayBoard
			echo "computers turn"
			checkForCompMove
			echo "Select cell for computer to insert symbol"
			read  cellNumComp
				if [ ${board[$cellNumComp]} == $NULL ]
				then
					board[$cellNumComp]=$computerSymbol
					chanceOf="player"
				else
					echo "select empty cell"
				fi
		fi
			((count++))
	done
}


function main()
{
	resetBoard
	assignLetterXOrO
	tossToCheckWhoPlaySFirst
	startPlaying
}

main
