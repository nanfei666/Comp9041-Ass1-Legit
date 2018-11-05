#!/usr/bin/bash
perl legit.pl init
echo line 1 > a
echo hello world > b
perl legit.pl commit -a -m 'first commit'
perl legit.pl add a
perl legit.pl commit -a -m 'first commit'
perl legit.pl add b
perl legit.pl commit -a -m 'second commit'
perl legit.pl log
