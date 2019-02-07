#Usage: run_jetphox.sh [name] [lhapdfname1] [lhapdfname2] [IS scale] [renorm. scale] [FS scale] [process] [HigherOrderTRUEorFALSE] [cmsenergy in gev] [maxrap] [minrap] [Inclusive=0 or withJets=1] [iso cone radius] [iso energy] [number of events] [randomseed]

DATE=`date +%Y_%m_%d`
RANDOMX=12345
NEVENTS=5000000

# isolated photons (2 gev in R=0.4)
# -10.0 < y < 10.0
# sqrt(s) = 5020 gev
# only direct photons at LO

# pp
sh run_jetphox.sh $DATE CT14nlo 0                 CT14nlo 0                 1.0 1.0 1.0 dir  FALSE 5020  10.0 -10.0  0.4 2  $NEVENTS $RANDOMX
sleep 20

# p-Pb
sh run_jetphox.sh $DATE CT14nlo 0                 EPPS16nlo_CT14nlo_Pb208 0 1.0 1.0 1.0 dir  FALSE 5020  10.0 -10.0  0.4 2  $NEVENTS $RANDOMX
sleep 20

# Pb-p
sh run_jetphox.sh $DATE EPPS16nlo_CT14nlo_Pb208 0 CT14nlo 0                 1.0 1.0 1.0 dir  FALSE 5020  10.0 -10.0  0.4 2  $NEVENTS $RANDOMX
sleep 20

# Pb-Pb
sh run_jetphox.sh $DATE EPPS16nlo_CT14nlo_Pb208 0 EPPS16nlo_CT14nlo_Pb208 0 1.0 1.0 1.0 dir  FALSE 5020  10.0 -10.0  0.4 2  $NEVENTS $RANDOMX
sleep 20


# the rapidity is of course defined for the CM system
# if you want to account for a boost along the z axis (as in real pPb collisions) shift the window accordingly
# (beam 1 comes from negative rapidity, goes to positive rapidity (small x of beam 2 gets probed at large y))
# e.g.:

# p-Pb: limited acceptance, no boost
sh run_jetphox.sh smallAcceptance_$DATE CT14nlo 0         EPPS16nlo_CT14nlo_Pb208 0 1.0 1.0 1.0 dir  FALSE 5020  0.9   -0.9   0.4 2  $NEVENTS $RANDOMX
sleep 20

# p-Pb: system is boosted w.r.t. lab frame with y_boost = 0.47, so subtract y_boost from CM-rapidity 
sh run_jetphox.sh smallAcceptance_boosted_$DATE CT14nlo 0 EPPS16nlo_CT14nlo_Pb208 0 1.0 1.0 1.0 dir  FALSE 5020  0.43  -1.37  0.4 2  $NEVENTS $RANDOMX
sleep 20
