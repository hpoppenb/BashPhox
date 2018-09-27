#!/bin/bash

if [ "$1" == "-h" ]; then
    echo "Usage: `basename $0` [name] [FS scale] \
[process] [HigherOrderTRUEorFALSE] [Inclusive=0 or withJets=1] \
[iso cone radius] [iso energy] \
[number of events] [randomseed] \
-- starts all six scale variations for (IS scale, ren. scale); no central value"
    exit 0
fi

if [ "$#" -ne 9 ]; then
    echo "Illegal number of parameters"
    echo "Usage: `basename $0` [name] [FS scale] \
[process] [HigherOrderTRUEorFALSE] [Inclusive=0 or withJets=1] \
[iso cone radius] [iso energy] \
[number of events] [randomseed]"
    exit 0

fi

NAME="${1}_05_05_2"
for index in {1..16}; do
    cd jp${index}/working/ \
	&& cp parameter.indat_template parameter.indat \
	&& sleep 1 \
	&& mkdir ../${NAME} \
	&& sed -i 's/NAMEINPUTPARAMETERFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEHISTODIR/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEEXECUTABLEFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/ISSCALE/'0.5'/g' parameter.indat \
	&& sed -i 's/RENORMSCALE/'0.5'/g' parameter.indat \
	&& sed -i 's/FSSCALE/'${2}'/g' parameter.indat \
	&& sed -i 's/PROCESSSWITCH/'${3}'/g' parameter.indat \
	&& sed -i 's/HIGHERORDERSWITCH/'${4}'/g' parameter.indat \
	&& sed -i 's/INCLUSIVEORWITHJETS/'${5}'/g' parameter.indat \
	&& sed -i 's/ISOCONERADIUS/'${6}'/g' parameter.indat \
	&& sed -i 's/ISOENERGY/'${7}'/g' parameter.indat \
	&& sed -i 's/NUMBEROFEVENTS/'${8}'/g' parameter.indat \
	&& sed -i 's/RANDOMSEED/'${9}'/g' parameter.indat \
	&& sleep 1 \
	&& perl start.pl \
	&& sleep 1 && sbatch submit_jetphox.sh run${NAME}.exe\
&& sleep 1 && cd ../ && cd ../ &
done
touch do_hadd_${NAME}.sh
if [ ${3} == "dir" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggd${NAME}.root
EOF
fi
if [ ${3} == "onef" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggo${NAME}.root
EOF
fi
sleep 40
##################################################
NAME="${1}_05_10_2"
for index in {1..16}; do
    cd jp${index}/working/ \
	&& cp parameter.indat_template parameter.indat \
	&& sleep 1 \
	&& mkdir ../${NAME} \
	&& sed -i 's/NAMEINPUTPARAMETERFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEHISTODIR/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEEXECUTABLEFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/ISSCALE/'0.5'/g' parameter.indat \
	&& sed -i 's/RENORMSCALE/'1.0'/g' parameter.indat \
	&& sed -i 's/FSSCALE/'${2}'/g' parameter.indat \
	&& sed -i 's/PROCESSSWITCH/'${3}'/g' parameter.indat \
	&& sed -i 's/HIGHERORDERSWITCH/'${4}'/g' parameter.indat \
	&& sed -i 's/INCLUSIVEORWITHJETS/'${5}'/g' parameter.indat \
	&& sed -i 's/ISOCONERADIUS/'${6}'/g' parameter.indat \
	&& sed -i 's/ISOENERGY/'${7}'/g' parameter.indat \
	&& sed -i 's/NUMBEROFEVENTS/'${8}'/g' parameter.indat \
	&& sed -i 's/RANDOMSEED/'${9}'/g' parameter.indat \
	&& sleep 1 \
	&& perl start.pl \
	&& sleep 1 && sbatch submit_jetphox.sh run${NAME}.exe\
&& sleep 1 && cd ../ && cd ../ &
done
touch do_hadd_${NAME}.sh
if [ ${3} == "dir" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggd${NAME}.root
EOF
fi
if [ ${3} == "onef" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggo${NAME}.root
EOF
fi
sleep 40
##################################################
NAME="${1}_10_05_2"
for index in {1..16}; do
    cd jp${index}/working/ \
	&& cp parameter.indat_template parameter.indat \
	&& sleep 1 \
	&& mkdir ../${NAME} \
	&& sed -i 's/NAMEINPUTPARAMETERFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEHISTODIR/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEEXECUTABLEFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/ISSCALE/'1.0'/g' parameter.indat \
	&& sed -i 's/RENORMSCALE/'0.5'/g' parameter.indat \
	&& sed -i 's/FSSCALE/'${2}'/g' parameter.indat \
	&& sed -i 's/PROCESSSWITCH/'${3}'/g' parameter.indat \
	&& sed -i 's/HIGHERORDERSWITCH/'${4}'/g' parameter.indat \
	&& sed -i 's/INCLUSIVEORWITHJETS/'${5}'/g' parameter.indat \
	&& sed -i 's/ISOCONERADIUS/'${6}'/g' parameter.indat \
	&& sed -i 's/ISOENERGY/'${7}'/g' parameter.indat \
	&& sed -i 's/NUMBEROFEVENTS/'${8}'/g' parameter.indat \
	&& sed -i 's/RANDOMSEED/'${9}'/g' parameter.indat \
	&& sleep 1 \
	&& perl start.pl \
	&& sleep 1 && sbatch submit_jetphox.sh run${NAME}.exe\
&& sleep 1 && cd ../ && cd ../ &
done
touch do_hadd_${NAME}.sh
if [ ${3} == "dir" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggd${NAME}.root
EOF
fi
if [ ${3} == "onef" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggo${NAME}.root
EOF
fi
sleep 40
##################################################
NAME="${1}_10_20_2"
for index in {1..16}; do
    cd jp${index}/working/ \
	&& cp parameter.indat_template parameter.indat \
	&& sleep 1 \
	&& mkdir ../${NAME} \
	&& sed -i 's/NAMEINPUTPARAMETERFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEHISTODIR/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEEXECUTABLEFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/ISSCALE/'1.0'/g' parameter.indat \
	&& sed -i 's/RENORMSCALE/'2.0'/g' parameter.indat \
	&& sed -i 's/FSSCALE/'${2}'/g' parameter.indat \
	&& sed -i 's/PROCESSSWITCH/'${3}'/g' parameter.indat \
	&& sed -i 's/HIGHERORDERSWITCH/'${4}'/g' parameter.indat \
	&& sed -i 's/INCLUSIVEORWITHJETS/'${5}'/g' parameter.indat \
	&& sed -i 's/ISOCONERADIUS/'${6}'/g' parameter.indat \
	&& sed -i 's/ISOENERGY/'${7}'/g' parameter.indat \
	&& sed -i 's/NUMBEROFEVENTS/'${8}'/g' parameter.indat \
	&& sed -i 's/RANDOMSEED/'${9}'/g' parameter.indat \
	&& sleep 1 \
	&& perl start.pl \
	&& sleep 1 && sbatch submit_jetphox.sh run${NAME}.exe\
&& sleep 1 && cd ../ && cd ../ &
done
touch do_hadd_${NAME}.sh
if [ ${3} == "dir" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggd${NAME}.root
EOF
fi
if [ ${3} == "onef" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggo${NAME}.root
EOF
fi
sleep 40
##################################################
NAME="${1}_20_10_2"
for index in {1..16}; do
    cd jp${index}/working/ \
	&& cp parameter.indat_template parameter.indat \
	&& sleep 1 \
	&& mkdir ../${NAME} \
	&& sed -i 's/NAMEINPUTPARAMETERFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEHISTODIR/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEEXECUTABLEFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/ISSCALE/'2.0'/g' parameter.indat \
	&& sed -i 's/RENORMSCALE/'1.0'/g' parameter.indat \
	&& sed -i 's/FSSCALE/'${2}'/g' parameter.indat \
	&& sed -i 's/PROCESSSWITCH/'${3}'/g' parameter.indat \
	&& sed -i 's/HIGHERORDERSWITCH/'${4}'/g' parameter.indat \
	&& sed -i 's/INCLUSIVEORWITHJETS/'${5}'/g' parameter.indat \
	&& sed -i 's/ISOCONERADIUS/'${6}'/g' parameter.indat \
	&& sed -i 's/ISOENERGY/'${7}'/g' parameter.indat \
	&& sed -i 's/NUMBEROFEVENTS/'${8}'/g' parameter.indat \
	&& sed -i 's/RANDOMSEED/'${9}'/g' parameter.indat \
	&& sleep 1 \
	&& perl start.pl \
	&& sleep 1 && sbatch submit_jetphox.sh run${NAME}.exe\
&& sleep 1 && cd ../ && cd ../ &
done
touch do_hadd_${NAME}.sh
if [ ${3} == "dir" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggd${NAME}.root
EOF
fi
if [ ${3} == "onef" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggo${NAME}.root
EOF
fi
sleep 40
##################################################
NAME="${1}_20_20_2"
for index in {1..16}; do
    cd jp${index}/working/ \
	&& cp parameter.indat_template parameter.indat \
	&& sleep 1 \
	&& mkdir ../${NAME} \
	&& sed -i 's/NAMEINPUTPARAMETERFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEHISTODIR/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEEXECUTABLEFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/ISSCALE/'2.0'/g' parameter.indat \
	&& sed -i 's/RENORMSCALE/'2.0'/g' parameter.indat \
	&& sed -i 's/FSSCALE/'${2}'/g' parameter.indat \
	&& sed -i 's/PROCESSSWITCH/'${3}'/g' parameter.indat \
	&& sed -i 's/HIGHERORDERSWITCH/'${4}'/g' parameter.indat \
	&& sed -i 's/INCLUSIVEORWITHJETS/'${5}'/g' parameter.indat \
	&& sed -i 's/ISOCONERADIUS/'${6}'/g' parameter.indat \
	&& sed -i 's/ISOENERGY/'${7}'/g' parameter.indat \
	&& sed -i 's/NUMBEROFEVENTS/'${8}'/g' parameter.indat \
	&& sed -i 's/RANDOMSEED/'${9}'/g' parameter.indat \
	&& sleep 1 \
	&& perl start.pl \
	&& sleep 1 && sbatch submit_jetphox.sh run${NAME}.exe\
&& sleep 1 && cd ../ && cd ../ &
done
touch do_hadd_${NAME}.sh
if [ ${3} == "dir" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggd${NAME}.root
EOF
fi
if [ ${3} == "onef" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd ${NAME}.root jp{1..16}/${NAME}/ggo${NAME}.root
EOF
fi
#######################################################################
#######################################################################

exit $?
