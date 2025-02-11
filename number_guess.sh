#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

MENU() {
    if [[ $1 ]]; then
        echo -e "$1\n"
    fi
    echo "Enter your username:"
    read USERNAME
}

GUESS() {
    if [[ $1 ]]; then
        echo -e "$1"
    else
        echo -e "Guess the secret number between 1 and 1000:"
    fi
    read NUMBER
}

MENU