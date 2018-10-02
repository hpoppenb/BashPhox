#!/bin/bash

if [ "$1" == "-h" ]; then
    echo "Usage: `basename $0` [prefix] [typeHadronBeam1=aaazzz] [typeHadronBeam2=aaazzz] \
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
    echo "Usage: `basename $0` [prefix] [typeHadronBeam1=aaazzz] [typeHadronBeam2=aaazzz] \
[lhapdfname] [jetphoxNPDFset] \
[IS scale] [renorm. scale] [FS scale] \
[process] [HigherOrderTRUEorFALSE] \
[cmsenergy in gev] [maxrap] [minrap] \
[Inclusive=0 or withJets=1] \
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

if [ "${HIGHERORDERSWITCH}" == "TRUE" ]; then
    ORDERSTRING="NLO"
    NAME="${NAME}_NLO"
elif [ "${HIGHERORDERSWITCH}" == "FALSE" ]; then
    ORDERSTRING="LO"
    NAME="${NAME}_LO"    
fi

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

if [ "${INCLUSIVEORWITHJETS}" == "0" ]; then
    NAME="${NAME}_incl"
elif [ "${INCLUSIVEORWITHJETS}" == "1" ]; then
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

echo ""
echo "Following name is used for directory and root file:"
echo ${NAME}
echo "----------------------------------------------------"

#------------------------------------------------
# run for each pt bin
for index in $(eval echo {1..$(eval echo $MAXBIN)}); do
    cd jp${index}/working/ \
	&& cp param_histo.indat_template param_histo.indat;
    sleep 0.2; # give the system some breaks to start all this stuff in parallel -- reduces crashes somehow
    sed -i 's/MAXRAP/'${MAXRAP}'/g' param_histo.indat \
	&& sed -i 's/MINRAP/'${MINRAP}'/g' param_histo.indat \
	&& sed -i 's/PROCESSSTRING/'${PROCESSSTRING}'/g' param_histo.indat \
	&& sed -i 's/ORDERSTRING/'${ORDERSTRING}'/g' param_histo.indat \
	&& cp parameter.indat_template parameter.indat;
    sleep 0.2;
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
	&& sed -i 's/INCLUSIVEORWITHJETS/'${INCLUSIVEORWITHJETS}'/g' parameter.indat \
	&& sed -i 's/ISOCONERADIUS/'${ISOCONERADIUS}'/g' parameter.indat \
	&& sed -i 's/ISOENERGY/'${ISOENERGY}'/g' parameter.indat \
	&& sed -i 's/NUMBEROFEVENTS/'${NUMBEROFEVENTS}'/g' parameter.indat \
	&& sed -i 's/RANDOMSEED/'${RANDOMSEED}'/g' parameter.indat \
	&& perl start.pl \
	&& sbatch submit_jetphox.sh run${NAME}.exe &
    cd ../..
    sleep 1
done

#------------------------------------------------
# create script for merging histograms
touch do_hadd_${NAME}.sh

if [ ${PROCESSSWITCH} == "dir" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd -k ${NAME}.root jp{1..${MAXBIN}}/${NAME}/ggd${NAME}.root
EOF
fi

if [ ${PROCESSSWITCH} == "onef" ]
then
    cat <<EOF >do_hadd_${NAME}.sh
hadd -k ${NAME}.root jp{1..${MAXBIN}}/${NAME}/ggo${NAME}.root
EOF
fi

exit $?
