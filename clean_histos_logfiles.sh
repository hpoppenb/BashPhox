#!/bin/bash

echo removing root files
rm */*/*.root &

echo removing .exe files
rm */working/*.exe &

echo removing directories working/result*
rm -rf */working/result*

echo removing directories *inclusive*
rm -rf */*inclusive*

echo removing directories *LO*
rm -rf */*LO*

echo removing log files
rm */working/log/*

exit $?
