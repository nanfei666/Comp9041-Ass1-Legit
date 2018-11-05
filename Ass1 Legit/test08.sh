#!/usr/bin/bash
perl legit.pl init
touch a b c d e f g h
perl legit.pl add a b c d e f
echo hello >a
echo hello >b
echo hello >c
perl legit.pl commit -m 'first commit'
perl legit.pl rm e
perl legit.pl rm a
perl legit.pl status
