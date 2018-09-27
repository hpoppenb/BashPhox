#!/bin/bash

##export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/gluster2/h_popp01/software/lhapdf6/lib

#SBATCH -J jetphox
#SBATCH -p long
#SBATCH -D ./
##SBATCH --exclude=node[33]
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2000
#SBATCH -o log/%j.eo.log
#SBATCH -e log/%j.eo.log

time ./$1

exit $?
