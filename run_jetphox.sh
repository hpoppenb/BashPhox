#!/bin/bash

if [ "$1" == "-h" ]; then
    echo "Usage: `basename $0` [prefix] [typeHadronBeam1=aaazzz] [typeHadronBeam2=aaazzz] \
[lhapdfname] [jetphoxNPDFset] \
[IS scale] [renorm. scale] [FS scale] \
[process] [HigherOrderTRUEorFALSE] \
[cmsenergy in gev] [maxrap] [minrap] \
[Inclusive=0 or withJet=1] \
[iso cone radius] [iso energy] \
[number of events] [randomseed]"
    exit 0
fi

if [ "$#" -ne 18 ]; then
    echo "Illegal number of parameters"
    echo "Usage: `basename $0` [prefix] [typeHadronBeam1=aaazzz] [typeHadronBeam2=aaazzz] \
[lhapdfname] [jetphoxNPDFset] \
[IS scale] [renorm. scale] [FS scale] \
[process] [HigherOrderTRUEorFALSE] \
[cmsenergy in gev] [maxrap] [minrap] \
[Inclusive=0 or withJet=1] \
[iso cone radius] [iso energy] \
[number of events] [randomseed]"
    exit 0
fi    

PREFIX=${1}
TYPEHADRONBEAM1=${2}
TYPEHADRONBEAM2=${3}
LHAPDFNAME=${4}
NPDFSET=${5}
ISSCALE=${6}
RENORMSCALE=${7}
FSSCALE=${8}
PROCESSSWITCH=${9}
HIGHERORDERSWITCH=${10}
CMSENERGY=${11}
MAXRAP=${12}
MINRAP=${13}
INCLUSIVEORWITHJETS=${14}
ISOCONERADIUS=${15}
ISOENERGY=${16}
NUMBEROFEVENTS=${17}
RANDOMSEED=${18}
#------------------------------------------------
#------------------------------------------------
# construct output file name
# a la "dir_NLO_13000GeV_300000evts_pPb_pdf1_pdf2_incl_iso2GeVinR03_scl05_20_10.root
NAME="${PREFIX}_"
if [ "${PROCESSSWITCH}" == "dir" ]; then
    PROCESSSTRING="dir"
    NAME="${NAME}dir"
elif [ "${PROCESSSWITCH}" == "onef" ]; then
    PROCESSSTRING="frag"
    NAME="${NAME}frag"
fi
#-----------------------------
if [ "${HIGHERORDERSWITCH}" == "TRUE" ]; then
    ORDERSTRING="NLO"
    NAME="${NAME}_NLO"
elif [ "${HIGHERORDERSWITCH}" == "FALSE" ]; then
    ORDERSTRING="LO"
    NAME="${NAME}_LO"    
fi
#-----------------------------
NAME="${NAME}_${CMSENERGY}GeV"
if [ "${NUMBEROFEVENTS}" -ge "1000000" ]; then
    EVTSSTRING=$( expr $( expr ${NUMBEROFEVENTS} - $( expr ${NUMBEROFEVENTS} % 1000000) ) / 1000000 )
    EVTSSTRING="${EVTSSTRING}M"
    NAME="${NAME}_${EVTSSTRING}evts"
fi
#-----------------------------
if [ "${TYPEHADRONBEAM1}" == "0" ]; then
    if [ "${TYPEHADRONBEAM2}" == "0" ]; then
	NAME="${NAME}_pp"
    fi
fi
if [ "${TYPEHADRONBEAM1}" == "0" ]; then
    if [ "${TYPEHADRONBEAM2}" == "208082" ]; then
	NAME="${NAME}_pPb"    
    fi
fi
if [ "${TYPEHADRONBEAM1}" == "208082" ]; then
    if [ "${TYPEHADRONBEAM2}" == "0" ]; then
	NAME="${NAME}_Pbp"    
    fi
fi
if [ "${TYPEHADRONBEAM1}" == "208082" ]; then
    if [ "${TYPEHADRONBEAM2}" == "208082" ]; then
	NAME="${NAME}_PbPb"    
    fi
fi
#-----------------------------
NAME="${NAME}_${LHAPDFNAME}" # pdfname
if [ "${NPDFSET}" -eq "6" ]; then
    NAME="${NAME}_EPS09"
fi

if [ "${INCLUSIVEORWITHJET}" == "0" ]; then
    NAME="${NAME}_incl"
elif [ "${INCLUSIVEORWITHJET}" == "1" ]; then
    NAME="${NAME}_gammajet"    
fi
#-----------------------------
NAME="${NAME}_iso${ISOENERGY}GeV"
if [ "${ISOCONERADIUS}" == "0.4" ]; then
    NAME="${NAME}inR04"
elif [ "${ISOCONERADIUS}" == "0.3" ]; then
    NAME="${NAME}inR03"    
elif [ "${ISOCONERADIUS}" == "0.2" ]; then
    NAME="${NAME}inR02"    
fi
#-----------------------------
# factorization scale
if [ "${ISSCALE}" == "2.0" ]; then
    NAME="${NAME}_scl_20"
elif [ "${ISSCALE}" == "1.0" ]; then
    NAME="${NAME}_scl_10"    
elif [ "${ISSCALE}" == "0.5" ]; then
    NAME="${NAME}_scl_05"    
elif [ "${ISSCALE}" == "5.0" ]; then
    NAME="${NAME}_scl_50"    
elif [ "${ISSCALE}" == "9.0" ]; then
    NAME="${NAME}_scl_90"    
fi
#-----------------------------
# renormalization scale
if [ "${RENORMSCALE}" == "2.0" ]; then
    NAME="${NAME}_20"
elif [ "${RENORMSCALE}" == "1.0" ]; then
    NAME="${NAME}_10"    
elif [ "${RENORMSCALE}" == "0.5" ]; then
    NAME="${NAME}_05"    
elif [ "${RENORMSCALE}" == "5.0" ]; then
    NAME="${NAME}_50"    
elif [ "${RENORMSCALE}" == "9.0" ]; then
    NAME="${NAME}_90"    
fi
#-----------------------------
# fragmentation scale
if [ "${FSSCALE}" == "2.0" ]; then
    NAME="${NAME}_20"
elif [ "${FSSCALE}" == "1.0" ]; then
    NAME="${NAME}_10"    
elif [ "${FSSCALE}" == "0.5" ]; then
    NAME="${NAME}_05"    
elif [ "${FSSCALE}" == "5.0" ]; then
    NAME="${NAME}_50"    
elif [ "${FSSCALE}" == "9.0" ]; then
    NAME="${NAME}_90"    
fi
#------------------------------------------------
#------------------------------------------------
# example pt binning
MAXBIN=4
PTBINS[0]=10.
PTBINS[1]=20.
PTBINS[2]=35.
PTBINS[3]=55.
PTBINS[$MAXBIN]=100.
#------------------------------------------------
#------------------------------------------------
echo ""
echo "Following name is used for directory and root file:"
echo ${NAME}
echo "----------------------------------------------------"
#------------------------------------------------
#------------------------------------------------
# modify config file, compile, and run with job scheduler for each pt bin
for index in $(eval echo {1..$(eval echo $MAXBIN)}); do
    cd jp${index}/working/ \
	&& cp param_histo.indat_template param_histo.indat;
    sed -i 's/MAXRAP/'${MAXRAP}'/g' param_histo.indat \
	&& sed -i 's/MINRAP/'${MINRAP}'/g' param_histo.indat \
	&& sed -i 's/PROCESSSTRING/'${PROCESSSTRING}'/g' param_histo.indat \
	&& sed -i 's/ORDERSTRING/'${ORDERSTRING}'/g' param_histo.indat \
	&& cp parameter.indat_template parameter.indat;
    rm -rf ../${NAME} \
	&& mkdir ../${NAME} \
	&& sed -i 's/NAMEINPUTPARAMETERFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEHISTODIR/'${NAME}'/g' parameter.indat \
	&& sed -i 's/NAMEEXECUTABLEFILE/'${NAME}'/g' parameter.indat \
	&& sed -i 's/TYPEHADRONBEAM1/'${TYPEHADRONBEAM1}'/g' parameter.indat \
	&& sed -i 's/TYPEHADRONBEAM2/'${TYPEHADRONBEAM2}'/g' parameter.indat \
	&& sed -i 's/LHAPDFNAME/'${LHAPDFNAME}'/g' parameter.indat \
	&& sed -i 's/NPDFSET/'${NPDFSET}'/g' parameter.indat \
	&& sed -i 's/ISSCALE/'${ISSCALE}'/g' parameter.indat \
	&& sed -i 's/RENORMSCALE/'${RENORMSCALE}'/g' parameter.indat \
	&& sed -i 's/FSSCALE/'${FSSCALE}'/g' parameter.indat \
	&& sed -i 's/PROCESSSWITCH/'${PROCESSSWITCH}'/g' parameter.indat \
	&& sed -i 's/HIGHERORDERSWITCH/'${HIGHERORDERSWITCH}'/g' parameter.indat \
	&& sed -i 's/CMSENERGY/'${CMSENERGY}'/g' parameter.indat \
	&& sed -i 's/MAXRAP/'${MAXRAP}'/g' parameter.indat \
	&& sed -i 's/MINRAP/'${MINRAP}'/g' parameter.indat \
	&& sed -i 's/PTMAXGEN/'${PTBINS[${index}]}'/g' parameter.indat \
	&& sed -i 's/PTMINGEN/'${PTBINS[$(($index-1))]}'/g' parameter.indat \
	&& sed -i 's/INCLUSIVEORWITHJET/'${INCLUSIVEORWITHJET}'/g' parameter.indat \
	&& sed -i 's/ISOCONERADIUS/'${ISOCONERADIUS}'/g' parameter.indat \
	&& sed -i 's/ISOENERGY/'${ISOENERGY}'/g' parameter.indat \
	&& sed -i 's/NUMBEROFEVENTS/'${NUMBEROFEVENTS}'/g' parameter.indat \
	&& sed -i 's/RANDOMSEED/'${RANDOMSEED}'/g' parameter.indat;
    perl start.pl \
	&& sbatch submitJobSLURM.sh run${NAME}.exe &
    cd ../..
done
#------------------------------------------------
#------------------------------------------------
# create script for merging histograms
touch merge_${NAME}.sh

if [ ${PROCESSSWITCH} == "dir" ]
then
    cat <<EOF >merge_${NAME}.sh
hadd -k ${NAME}.root jp{1..${MAXBIN}}/${NAME}/ggd${NAME}.root
EOF
fi

if [ ${PROCESSSWITCH} == "onef" ]
then
    cat <<EOF >merge_${NAME}.sh
hadd -k ${NAME}.root jp{1..${MAXBIN}}/${NAME}/ggo${NAME}.root
EOF
fi

exit $?
