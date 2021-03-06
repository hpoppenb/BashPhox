This repo includes Jetphox 1.3.1.4 and shell scripts to run it more comfortably. Also some small code modification now allows to generate pA collisions with any two LHAPDF (thanks to Ilkka Helenius helping here).

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
 #Usage: run_jetphox.sh [name] [lhapdfname1] [lhapdfname2] [IS scale] [renorm. scale] [FS scale] [process] [HigherOrderTRUEorFALSE] [cmsenergy in gev] [maxrap] [minrap] [Inclusive=0 or withJets=1] [iso cone radius] [iso energy] [number of events] [randomseed]
 
 DATE=`date +%Y_%m_%d`
 RANDOMX=12345
 NEVENTS=5000000
 
 # isolated photons (2 gev in R=0.4)
 # -10.0 < y < 10.0
 # sqrt(s) = 5020 gev
 # only direct photons at LO

 # p-Pb
 sh run_jetphox.sh $DATE CT14nlo EPPS16nlo_CT14nlo_Pb208 1.0 1.0 1.0 dir FALSE 5020 10.0 -10.0 0.4 2 $NEVENTS $RANDOMX
```

--------------------------------------------------
*Automation*: The script writes the config file in the working directory in each pt bin, then compiles and runs the program.

*Bookkeeping*: The root file and the directory containing it are named in a verbose way, so you can see from the name what has been run. It additionally produces a merge script to merge the histos of all pt bins in the end.

After you have merged everything correctly, you can tidy up the directories with "sh clean_histos_logfiles.sh"


--------------------------------------------------
### Additional notes
 - In the current version, the script starts a SLURM script in the respective working directory. If you do not use SLURM, you have to replace this script according to your respective job scheduler.
 - You have to specify your ROOT path in each jp*/working/Makefile.
 - You have to specify your LHAPDF path in each jp*/working/parameter.indat_template.
 - There is an example script.
 - The program was tested with LHAPDF 6.1.6., Jetphox 1.3.1.4, ROOT6, Scientific Linux 7, GCC 4.8.5.
 - If compilation fails, do "make clean" in the working directory, try again and pray for the mercy of the Fortran god.

--------------------------------------------------


Just to be sure: Jetphox is not my creation, so please cite the authors, e.g. Phys.Rev. D73 (2006) 094007.

--------------------------------------------------


Cheers,

Hendrik Poppenborg, 2018-10-02
