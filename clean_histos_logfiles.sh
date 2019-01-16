#!/bin/bash

echo 'removing root files'
rm jp*/*/*.root &

echo 'removing .exe files'
rm jp*/working/*.exe &

echo 'removing directories working/result*'
rm -rf jp*/working/result*/ &

echo 'removing directories *evts* (the single root files directories)'
rm -rf jp*/*evts*/ &

echo 'removing log files'
rm jp*/working/log/* &

echo 'removing *~'
rm *~

exit $?
