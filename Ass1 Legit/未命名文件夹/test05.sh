#!/usr/bin/bash
perl legit.pl init
echo line 1 > a
echo hello world >b
perl legit.pl add a b
perl legit.pl commit -m 'first commit'
perl legit.pl add a
perl legit.pl commit -m 'second commit'
perl legit.pl show 0:a
perl legit.pl show 10:a
