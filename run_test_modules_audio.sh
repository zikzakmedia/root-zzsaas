#!/bin/bash

export PYTHONPATH=trytond:proteus
#play="paplay"
#great=~/runtests/cheer.wav
#shit=~/runtests/boo.wav

# Requires speech-dispatcher
# apt-get install speech-dispatcher
play="spd-say"
great="Great!"
shit="Oh! Shit"
alias great="$play $great"
alias shit="$play $shit"

for dir in modules/*
do
    dir=${dir%*/}

    if [ ! -d "$dir" ]; then
      continue
    fi

    echo ${dir##*/}
    ./trytond/trytond/tests/run-tests.py -v -f -m ${dir##*/} $* && $play "$great" || $play "$shit"
done
