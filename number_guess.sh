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

while [[ -z $USERNAME ]]; do
    MENU "The username filed is required."
done

# --- Find user by name ----
USER=$($PSQL "SELECT username,games_played,best_game FROM users WHERE username='$USERNAME'")
if [[ -z $USER ]]; then
    INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
    echo "Welcome, $USERNAME! It looks like this is your first time here."
else
    IFS='|' read -r -a USER_ARRAY <<<"$USER"
    for ((i = 0; i <= ${#USER_ARRAY[@]} - 1; i++)); do
        USER_ARRAY[$i]=$(echo ${USER_ARRAY[$i]} | sed -e 's/^+ | +$//')
    done
    echo "Welcome back, ${USER_ARRAY[0]}! You have played ${USER_ARRAY[1]} games, and your best game took ${USER_ARRAY[2]} guesses."
fi
