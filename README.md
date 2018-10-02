This repo should help people to generate Jetphox more comfortably.
--------------------------------------------------

The original problem with Jetphox is that

1) You have to specify everything in a config file, then compile it, then run it.

2) It does not allow you to directly simulate in photon pt bins in order to get homogenous statistics over an entire photon pt spectrum.

3) Bookkeeping quickly becomes a mess.


--------------------------------------------------
So at the center of the project, you find the following:

1) The usual jetphox directory is reworked and only contains the necessary code for a specific run in a pt bin, the jetphox code basis (pdf,fragmentation functions, bases...) you find now in the root directory of this repo. The Makefile in the jetphox working dir (jp*/working) has been modified accordingly.

2) Instead of only one jetphox directory you should create yourself several directories by copying the default directory "jp1", one for each photon pt bin. The binning is defined in...

3) ...run_jetphox.sh . This script also allows to define all the input configuration like cms energy, pdf, npdf usage etc. So, you can call run_jetphox with an additional script like this:


--------------------------------------------------
#Usage: run_jetphox.sh [name] [typeHadronBeam1=aaazzz] [typeHadronBeam2=aaazzz] [lhapdfname] [jetphoxNPDFset] [IS scale] [renorm. scale] [FS scale] [process] [HigherOrderTRUEorFALSE] [cmsenergy in gev] [maxrap] [minrap] [Inclusive=0 or withJets=1] [iso cone radius] [iso energy] [number of events] [randomseed]

DATE=`date +%Y_%m_%d`
RANDOMX=10003
NEVENTS=2000000

### 13000 GeV DIRECT ###
sh go_jetphox_go.sh $DATE 0 0 CT14nlo 0 1.0 1.0 1.0 dir  TRUE 13000 0.9 -0.9 0 0.4 2.0 $NEVENTS $RANDOMX

### 13000 GeV FRAG ###
sh go_jetphox_go.sh $DATE 0 0 CT14nlo 0 1.0 1.0 1.0 onef TRUE 13000 0.9 -0.9 0 0.4 2.0 $NEVENTS $RANDOMX
--------------------------------------------------


--------------------------------------------------
The script will write the config file in the working directory in each pt bin and compiles it.

The root files and the directory containing them are named in a verbose way, so you can see from the name what has been run.

It additionally produces a merge script to merge all pt bins in the end.

After you have merged everything correctly, you can tidy up the directories with "sh clean_histos_logfiles.sh"

Note 1: In the current version, the script starts a SLURM script in the respective working directory. If you do not use SLURM, you have to replace this script according to your respective job scheduler.

Note 2: You have to specify your LHAPDF paths in the Makefile in jp*/working/Makefile
--------------------------------------------------


Just to be clear: Jetphox is not my creation, so cite the authors if used in a publication, e.g. Phys.Rev. D73 (2006) 094007.
--------------------------------------------------



Kind regards,

Hendrik Poppenborg, 2018-10-02
