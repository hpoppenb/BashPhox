#!/bin/bash

if [ "$1" == "-h" ]; then
    echo "Usage: `basename $0` [name] [typeHadronBeam1=aaazzz] [typeHadronBeam2=aaazzz] \
[lhapdfname] [jetphoxNPDFset] \
[IS scale] [renorm. scale] [FS scale] \
[process] [HigherOrderTRUEorFALSE] \
[cmsenergy in gev] [maxrap] [minrap] \
[Inclusive=0 or withJets=1] \
[iso cone radius] [iso energy] \
[number of events] [randomseed]"
    exit 0
fi

if [ "$#" -ne 18 ]; then
    echo "Illegal number of parameters"
    echo "Usage: `basename $0` [name] [typeHadronBeam1=aaazzz] [typeHadronBeam2=aaazzz] \
[lhapdfname] [jetphoxNPDFset] \
[IS scale] [renorm. scale] [FS scale] \
[process] [HigherOrderTRUEorFALSE] \
[cmsenergy in gev] [maxrap] [minrap] \
[Inclusive=0 or withJets=1] \
[iso cone radius] [iso energy] \
[number of events] [randomseed]"
    exit 0
fi    

#------------------------------------------------
# construct output file name
# a la "dir_NLO_13000GeV_300000evts_pPb_pdf1_pdf2_incl_iso2GeVinR03_scl05_20_10.root
NAME="${1}_"
if [ "${9}" == "dir" ]; then
    PROCESSSTRING="dir"
    NAME="${NAME}dir"
elif [ "${9}" == "onef" ]; then
    PROCESSSTRING="frag"
    NAME="${NAME}frag"
fi

if [ "${10}" == "TRUE" ]; then
    ORDERSTRING="NLO"
    NAME="${NAME}_NLO"
elif [ "${10}" == "FALSE" ]; then
    ORDERSTRING="LO"
    NAME="${NAME}_LO"    
fi

NAME="${NAME}_${11}GeV"
NAME="${NAME}_${17}evts"

#-----------------------------
if [ "${2}" == "0" ]; then
    if [ "${3}" == "0" ]; then
	NAME="${NAME}_pp"
    fi
fi
if [ "${2}" == "0" ]; then
    if [ "${3}" == "208082" ]; then
	NAME="${NAME}_pPb"    
    fi
fi
if [ "${2}" == "208082" ]; then
    if [ "${3}" == "0" ]; then
	NAME="${NAME}_Pbp"    
    fi
fi
if [ "${2}" == "208082" ]; then
    if [ "${3}" == "208082" ]; then
	NAME="${NAME}_PbPb"    
    fi
fi

#-----------------------------
NAME="${NAME}_${4}" # pdfname
if [ "${5}" -eq "6" ]; then
    NAME="${NAME}_EPS09"
fi

if [ "${14}" == "0" ]; then
    NAME="${NAME}_incl"
elif [ "${14}" == "1" ]; then
    NAME="${NAME}_gammajet"    
fi

#-----------------------------
NAME="${NAME}_iso${16}GeV"
if [ "${15}" == "0.4" ]; then
    NAME="${NAME}inR04"
elif [ "${15}" == "0.3" ]; then
    NAME="${NAME}inR03"    
elif [ "${15}" == "0.2" ]; then
    NAME="${NAME}inR02"    
fi

#-----------------------------
if [ "${6}" == "2.0" ]; then
    NAME="${NAME}_scl_20"
elif [ "${6}" == "1.0" ]; then
    NAME="${NAME}_scl_10"    
elif [ "${6}" == "0.5" ]; then
    NAME="${NAME}_scl_05"    
elif [ "${6}" == "5.0" ]; then
    NAME="${NAME}_scl_50"    
elif [ "${6}" == "9.0" ]; then
    NAME="${NAME}_scl_90"    
fi

if [ "${7}" == "2.0" ]; then
    NAME="${NAME}_20"
elif [ "${7}" == "1.0" ]; then
    NAME="${NAME}_10"    
elif [ "${7}" == "0.5" ]; then
    NAME="${NAME}_05"    
elif [ "${7}" == "5.0" ]; then
    NAME="${NAME}_50"    
elif [ "${7}" == "9.0" ]; then
    NAME="${NAME}_90"    
fi

if [ "${8}" == "2.0" ]; then
    NAME="${NAME}_20"
elif [ "${8}" == "1.0" ]; then
    NAME="${NAME}_10"    
elif [ "${8}" == "0.5" ]; then
    NAME="${NAME}_05"    
elif [ "${8}" == "5.0" ]; then
    NAME="${NAME}_50"    
elif [ "${8}" == "9.0" ]; then
    NAME="${NAME}_90"    
fi
#------------------------------------------------
# pt binning for studying lowest pt (possible in combination with large scales)
#PTBINS[0]=0.1
#PTBINS[1]=0.2
#PTBINS[2]=0.3
#PTBINS[3]=0.5
#PTBINS[4]=1.
#PTBINS[5]=2.
#PTBINS[6]=3.5
#PTBINS[7]=5.5
#PTBINS[8]=8.0
#PTBINS[9]=11.0
#PTBINS[10]=14.5
#PTBINS[11]=18.5
#PTBINS[12]=23.0
#PTBINS[13]=28.0
#PTBINS[14]=33.0
#PTBINS[15]=38.0
#PTBINS[16]=43.0
#PTBINS[17]=48.0
#PTBINS[18]=53.0
#PTBINS[19]=58.0
#PTBINS[20]=63.0
#PTBINS[21]=69.0
#PTBINS[22]=75.0
#PTBINS[23]=81.0
#PTBINS[24]=87.0
#PTBINS[25]=93.0
#PTBINS[26]=102.0

#------------------------------------------------
# default pt binning
MAXBIN=23
PTBINS[0]=0.5
PTBINS[1]=1.
PTBINS[2]=2.
PTBINS[3]=3.5
PTBINS[4]=5.5
PTBINS[5]=8.0
PTBINS[6]=11.0
PTBINS[7]=14.5
PTBINS[8]=18.5
PTBINS[9]=23.0
PTBINS[10]=28.0
PTBINS[11]=33.0
PTBINS[12]=38.0
PTBINS[13]=43.0
PTBINS[14]=48.0
PTBINS[15]=53.0
PTBINS[16]=58.0
PTBINS[17]=63.0
PTBINS[18]=69.0
PTBINS[19]=75.0
PTBINS[20]=81.0
PTBINS[21]=87.0
PTBINS[22]=93.0
PTBINS[MAXBIN]=102.0

echo ${NAME}

#------------------------------------------------
# run for each pt bin
for index in $(eval echo {1..$(eval echo $MAXBIN)}); do
    cd jp${index}/working/ \
	&& cp param_histo.indat_template param_histo.indat;
    sleep 0.2; # give the system some breaks to start all this stuff in parallel -- reduces crashes somehow
    sed -i 's/MAXRAP/'${12}'/g' param_histo.indat \
	&& sed -i 's/MINRAP/'${13}'/g' param_histo.indat \
	&& sed -i 's/PROCESSSTRING/'${PROCESSSTRING}'/g' param_histo.indat \
	&& sed -i 's/ORDERSTRING/'${ORDERSTRING}'/g' param_histo.indat \
	&& cp parameter.indat_template parameter.indat;
    sleep 0.2;
    rm -rf ../${NAME} \
	&& mkdir ../${NAME} \
	&& sed -i 's/NAMEINPUTPARAMETERFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEHISTODIR/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEEXECUTABLEFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/TYPEHADRONBEAM1/'${2}'/g' parameter.indat \
	&& sed -i 's/TYPEHADRONBEAM2/'${3}'/g' parameter.indat \
	&& sed -i 's/LHAPDFNAME/'${4}'/g' parameter.indat \
	&& sed -i 's/NPDFSET/'${5}'/g' parameter.indat \
	&& sed -i 's/ISSCALE/'${6}'/g' parameter.indat \
	&& sed -i 's/RENORMSCALE/'${7}'/g' parameter.indat \
	&& sed -i 's/FSSCALE/'${8}'/g' parameter.indat \
	&& sed -i 's/PROCESSSWITCH/'${9}'/g' parameter.indat \
	&& sed -i 's/HIGHERORDERSWITCH/'${10}'/g' parameter.indat \
	&& sed -i 's/CMSENERGY/'${11}'/g' parameter.indat \
	&& sed -i 's/MAXRAP/'${12}'/g' parameter.indat \
	&& sed -i 's/MINRAP/'${13}'/g' parameter.indat \
	&& sed -i 's/PTMAXGEN/'${PTBINS[${index}]}'/g' parameter.indat \
	&& sed -i 's/PTMINGEN/'${PTBINS[$(($index-1))]}'/g' parameter.indat \
	&& sed -i 's/INCLUSIVEORWITHJETS/'${14}'/g' parameter.indat \
	&& sed -i 's/ISOCONERADIUS/'${15}'/g' parameter.indat \
	&& sed -i 's/ISOENERGY/'${16}'/g' parameter.indat \
	&& sed -i 's/NUMBEROFEVENTS/'${17}'/g' parameter.indat \
	&& sed -i 's/RANDOMSEED/'${18}'/g' parameter.indat \
	&& perl start.pl \
	&& sbatch submit_jetphox.sh run${NAME}.exe &
    cd ../..
    sleep 1
done

#------------------------------------------------
# create script for merging histograms
touch do_hadd_${NAME}.sh

if [ ${9} == "dir" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd -k ${NAME}.root jp{1..${MAXBIN}}/${NAME}/ggd${NAME}.root
EOF
fi

if [ ${9} == "onef" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd -k ${NAME}.root jp{1..${MAXBIN}}/${NAME}/ggo${NAME}.root
EOF
fi

exit $?
