#!/bin/bash
perl legit.pl init
echo 1 > a
echo 2 > b
perl legit.pl add a
perl legit.pl add b
if test -e ".legit"; then
  cd ".legit"
  if test -e ".index"; then
    cd ".index"
    if test -e "a" && test -e "b"; then
      echo "passed"
    fi
  fi
fi
