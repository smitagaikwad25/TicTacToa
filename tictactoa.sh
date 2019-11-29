#!/bin/bash
echo "welCome In Tictactoa Simulator"

function resetBord()
{
        j=0
        for(( i=1; i<=9; i++ ))
        do
                bord[$i]=$j
        done

}

