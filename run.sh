#Usage: go_jetphox_go.sh [name] [typeHadronBeam1=aaazzz] [typeHadronBeam2=aaazzz] [lhapdfname] [jetphoxNPDFset] [IS scale] [renorm. scale] [FS scale] [process] [HigherOrderTRUEorFALSE] [cmsenergy in gev] [maxrap] [minrap] [Inclusive=0 or withJets=1] [iso cone radius] [iso energy] [number of events] [randomseed]

#-------------------------------------------------------------------------
#sh go_jetphox_go.sh test 0 0 cteq66 0 1.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 208082 cteq66 6 1.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 208082 208082 cteq66 6 1.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60

#sh go_jetphox_go.sh test 0 208082 CT14nlo 6 1.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 EPPS16nlo_CT14nlo_Pb208 0 1.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60

#-------------------------------------------------------------------------
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 1.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 1.0 1.0 1.0 onef TRUE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 1.0 1.0 1.0 onef FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 1.0 1.0 1.0 dir TRUE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#-------------------------------------------------------------------------
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 2.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 2.0 1.0 1.0 onef TRUE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 2.0 1.0 1.0 onef FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 2.0 1.0 1.0 dir TRUE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#-------------------------------------------------------------------------
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 5.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 5.0 1.0 1.0 onef TRUE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 5.0 1.0 1.0 onef FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 5.0 1.0 1.0 dir TRUE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#-------------------------------------------------------------------------
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 9.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 9.0 1.0 1.0 onef TRUE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 9.0 1.0 1.0 onef FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 9.0 1.0 1.0 dir TRUE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#-------------------------------------------------------------------------

# frag: modified FSSCALE
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 1.0 1.0 2.0 onef FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 1.0 1.0 5.0 onef FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 1.0 1.0 9.0 onef FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60

# frag: modified FSSCALE + ISSCALE
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 2.0 1.0 2.0 onef FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 5.0 1.0 5.0 onef FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 9.0 1.0 9.0 onef FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60

# dir: modified ISSCALE
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 2.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 5.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60
#sh go_jetphox_go.sh test 0 0 CT14nlo 0 9.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 1000000 1234
#sleep 60

sh go_jetphox_go.sh test 0 0 CT14nlo 0 1.0 1.0 1.0 dir FALSE 5020 0.9 -0.9 0 0.4 2510 10000 1234


