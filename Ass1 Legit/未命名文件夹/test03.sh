#!/usr/bin/bash
perl legit.pl init
echo line 1 > c
echo line 1 > d
perl legit.pl commit -m "first commit"
perl legit.pl add a
perl legit.pl add c d
perl legit.pl commit -m "first commit"
