#!/usr/bin/bash
perl legit.pl init
touch a b c d e f g h
perl legit.pl add a b c d e f
perl legit.pl commit -m 'first commit'
echo hello >a
echo hello >b
echo hello >c
perl legit.pl commit -a -m 'second commit'
rm d
perl legit.pl rm d
perl legit.pl status
