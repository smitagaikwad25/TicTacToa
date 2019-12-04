#! /bin/bash
echo "WelCome In Tictactoa Simulator"

declare -a board
#constants
MAX_CELL_NUM=9

#variables
NULL="-"
playerSymbol=0
computerSymbol=0
counter=0
flag=false




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
	local Count=$1
	if [ $Count -eq $MAX_CELL_NUM ]
	then
		echo "game is tie"
		exit
	fi
}

function checkForWin()
{
	local symbolToCheck=$1
	local Count=$2
	checkForRow $symbolToCheck
	checkForCol $symbolToCheck
	checkForDiagonal $symbolToCheck
	checkForTie $Count
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

function blockByRow()
{
	for (( rowCount=1; rowCount<=9; rowCount=rowCount+3 ))
	do
		if [[ ${board[$rowCount]} == ${board[$rowCount+1]} ]] && [[ ${board[$rowCount+1]} == $playerSymbol ]]
		then
			board[$rowCount+2]=$computerSymbol
			flag=true
		elif [[ ${board[$rowCount+1]} == ${board[$rowCount+2]} ]] && [[ ${board[$rowCount+2]} == $playerSymbol ]]
		then
			board[$rowCount]=$computerSymbol
			flag=ture
		elif [[ ${board[$rowCount+2]} == ${board[$rowCount]} ]] && [[ ${board[$rowCount]} == $playerSymbol ]]
		then
			board[$rowCount+1]=$computerSymbol
			flag=ture
		fi
	done
}

function blockByCol()
{
	for (( colCount=1; colCount<=3; colCount++ ))
	do
		if [[ ${board[$colCount]} == ${board[$colCount+3]} ]] && [[ ${board[$colCount+3]} == $playerSymbol ]]
		then
			board[$colCount+6]=$computerSymbol
			flag=true
		elif [[ ${board[$colCount+3]} == ${board[$colCount+6]} ]] && [[  ${board[$colCount+6]} == $playerSymbol ]]
		then
			board[$colCount]=$computerSymbol
			flag=true
		elif [[ ${board[$colCount+6]} == ${board[$colCount]} ]] && [[  ${board[$colCount]} == $playerSymbol ]]
		then
			board[$colCount+3]=$computerSymbol
			flag=true

		fi
	done
}

function blockByDiagonal()
{
	for (( diaCount=1; diaCount<2; diaCount++))
	do
		if [[ ${board[$diaCount]} == ${board[$diaCount+4]} ]] && [[ ${board[$diaCount+4]} == $playerSymbol ]]
		then
			board[$diaCount+8]=$computerSymbol
			flag=true
		elif [[ ${board[$diaCount+4]} == ${board[$diaCount+8]} ]] && [[ ${board[$diaCount+8]} == $playerSymbol ]]
		then
			board[$diaCount]=$computerSymbol
			flag=true
		elif [[ ${board[$diaCount+8]} == ${board[$diaCount]} ]] && [[ ${board[$diaCount]} == $playerSymbol ]]
		then
			board[$diaCount]=$computerSymbol
			flag=true
		elif [[ ${board[$diaCount+2]} == ${board[$diaCount+4]} ]] && [[ ${board[$diaCount+4]} == $playerSymbol ]]
		then
			board[$diaCount+6]=$computerSymbol
			flag=true
		elif [[ ${board[$diaCount+4]} == ${board[$diaCount+6]} ]] && [[ ${board[$diaCount+6]} == $playerSymbol ]]
		then
			board[$diaCount+2]=$computerSymbol
		elif [[ ${board[$diaCount+6]} == ${board[$diaCount+2]} ]] && [[ ${board[$diaCount+2]} == $playerSymbol ]]
		then
			board[$diaCount+4]=$computerSymbol
			flag=true
		fi

	done

}


function playToBlockOppent()
{
	blockByRow
	blockByCol
	blockByDiagonal

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
			flag=false
			displayBoard
			echo "computers turn"
			checkForCompMove
			playToBlockOppent
			if [ $flag == false ]
			then
				echo "Select cell for computer to insert symbol"
				read cellNumComp
					if [ ${board[$cellNumComp]} == $NULL ]
					then
						board[$cellNumComp]=$computerSymbol
					else
						echo "select empty cell"
					fi
			fi
			chanceOf="player"

		fi
			((count++))
			echo $count

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
