#!/bin/bash

#SBATCH -J jetphox
#SBATCH -p long
#SBATCH -D ./
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2000
#SBATCH -o log/%j.eo.log
#SBATCH -e log/%j.eo.log

time ./$1

exit $?
