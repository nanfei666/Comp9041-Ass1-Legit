#!/usr/bin/bash
perl legit.pl init
echo 1 > a
perl legit.pl commit -m message1
touch a
perl legit.pl add a
perl legit.pl commit -m message2
