#include "TFile.h"
#include "TH1.h"
#include "TH2.h"
#include "TProfile.h"
#include "TNtuple.h"
#include "TRandom.h"

TFile *hfile;
TH1D *hp20;
TH1D *hp21;

void InitH1(char* path_rootfile)
{
	// Create a new ROOT binary machine independent file.
	// Note that this file may contain any kind of ROOT objects, histograms,
	// pictures, graphics objects, detector geometries, tracks, events, etc..
	// This file is now becoming the current directory.

	// hfile = new TFile("../test_dir_LO_5020GeV_10000evts_pp_CT14nlo_incl_iso2510GeVinR04_scl_10_10_10/ggdtest_dir_LO_5020GeV_10000evts_pp_CT14nlo_incl_iso2510GeVinR04_scl_10_10_10.root","RECREATE","");
	hfile = new TFile(path_rootfile,"RECREATE","");

  // Create some histograms 
	hp20   = new TH1D("hp20","d#sigma^{#gamma}_{dir,LO}/dp_{T}^{#gamma}(-0.9<y<0.9)",1000,0.,100.);
	hp21   = new TH1D("hp21","d#sigma^{#gamma}_{dir,LO}/dy^{#gamma}",100,-5.,5.);
  
}
