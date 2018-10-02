This repo includes Jetphox 1.3.1.4 and shell scripts to run it more comfortably.

--------------------------------------------------
### Motivation
The problem with the original Jetphox code is that usage can get cumbersome:
 - You have to edit a config file, then compile it, then run it.
 - It does not allow you to directly simulate in photon pt bins in order to get homogenous statistics over an entire photon pt spectrum.
 - Bookkeeping quickly becomes a mess.
 
--------------------------------------------------
### Features
 - The usual jetphox directory is reworked and only contains the necessary code for a specific run in a pt bin, the jetphox code basis (pdf,fragmentation functions, bases...) you find now in the root directory of this repo. The Makefile in the jetphox working dir (jp*/working) has been modified accordingly.
 - Instead of only one jetphox directory you should create yourself several directories by copying the default directory "jp1", one for each photon pt bin. The binning is defined in...
 - ...run_jetphox.sh . This script also allows to define all the input configuration like cms energy, pdf, npdf usage etc. So, you can call run_jetphox with an additional script like this:
```sh
#Usage: run_jetphox.sh [name] [typeHadronBeam1=aaazzz] [typeHadronBeam2=aaazzz] [lhapdfname] [jetphoxNPDFset] [IS scale] [renorm. scale] [FS scale] [process] [HigherOrderTRUEorFALSE] [cmsenergy in gev] [maxrap] [minrap] [Inclusive=0 or withJets=1] [iso cone radius] [iso energy] [number of events] [randomseed]

DATE=`date +%Y_%m_%d`
RANDOMX=10003
NEVENTS=2000000

### 13000 GeV DIRECT ###
bash run_jetphox.sh $DATE 0 0 CT14nlo 0 1.0 1.0 1.0 dir  TRUE 13000 0.9 -0.9 0 0.4 2.0 $NEVENTS $RANDOMX

### 13000 GeV FRAG ###
bash run_jetphox.sh $DATE 0 0 CT14nlo 0 1.0 1.0 1.0 onef TRUE 13000 0.9 -0.9 0 0.4 2.0 $NEVENTS $RANDOMX
```

--------------------------------------------------
*Automation*: The script writes the config file in the working directory in each pt bin, then compiles and runs the program.

*Bookkeeping*: The root file and the directory containing it are named in a verbose way, so you can see from the name what has been run. It additionally produces a merge script to merge the histos of all pt bins in the end.

After you have merged everything correctly, you can tidy up the directories with "sh clean_histos_logfiles.sh"


--------------------------------------------------
### Additional notes
 - In the current version, the script starts a SLURM script in the respective working directory. If you do not use SLURM, you have to replace this script according to your respective job scheduler.
 - You have to specify your ROOT path in each jp*/working/Makefile
 - You have to specify your LHAPDF path in each jp*/working/parameter.indat_template
 - There is an example script generating isolated photon spectra at 13 TeV in four pt bins.
 - The program was tested with LHAPDF 6.1.6., Jetphox 1.3.1.4, ROOT6, Scientific Linux 7, GCC 4.8.5

--------------------------------------------------


Just to be sure: Jetphox is not my creation, so please cite the authors, e.g. Phys.Rev. D73 (2006) 094007.

--------------------------------------------------


Cheers,

Hendrik Poppenborg, 2018-10-02
