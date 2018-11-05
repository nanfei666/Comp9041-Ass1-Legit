#!/usr/bin/bash
perl legit.pl init
echo line 1 > a
echo line 1 > b
perl legit.pl add a f
perl legit.pl commit -m "first commit"
echo line 2 >> a
perl legit.pl commit -m "second commit"
