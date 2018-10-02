#Usage: run_jetphox.sh [name] [typeHadronBeam1=aaazzz] [typeHadronBeam2=aaazzz] [lhapdfname] [jetphoxNPDFset] [IS scale] [renorm. scale] [FS scale] [process] [HigherOrderTRUEorFALSE] [cmsenergy in gev] [maxrap] [minrap] [Inclusive=0 or withJets=1] [iso cone radius] [iso energy] [number of events] [randomseed]

DATE=`date +%Y_%m_%d`
RANDOMX=10003
NEVENTS=20000000

#------------------------
# isolated photons
#------------------------
# 13000 GeV FRAG LO + NLO ###
sh run_jetphox.sh $DATE 0 0 CT10nlo 0 1.0 1.0 1.0 onef TRUE 13000 0.9 -0.9 0 0.4 2 $NEVENTS $RANDOMX
sleep 10

# 13000 GeV DIRECT LO + NLO ###
sh run_jetphox.sh $DATE 0 0 CT10nlo 0 1.0 1.0 1.0 dir  TRUE 13000 0.9 -0.9 0 0.4 2 $NEVENTS $RANDOMX
sleep 10

# 13000 GeV FRAG LO only ###
sh run_jetphox.sh $DATE 0 0 CT10nlo 0 1.0 1.0 1.0 onef FALSE 13000 0.9 -0.9 0 0.4 2 $NEVENTS $RANDOMX
sleep 10

# 13000 GeV DIRECT LO only ###
sh run_jetphox.sh $DATE 0 0 CT10nlo 0 1.0 1.0 1.0 dir  FALSE 13000 0.9 -0.9 0 0.4 2 $NEVENTS $RANDOMX
