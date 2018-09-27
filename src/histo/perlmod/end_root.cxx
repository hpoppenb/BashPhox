#include "TFile.h"
#include "TH1.h"
#include "TH2.h"
#include "TProfile.h"
#include "TNtuple.h"
#include "TRandom.h"
#include "Riostream.h"

extern TFile *hfile;
extern TH1D *hp20;
extern TH1D *hp21;

void EndH1(Int_t numb_event,Double_t first_int)
{
	const Int_t nb_histo_equi = 2;
	const Int_t nb_histo_nonequi = 0;
	Int_t i;
	Double_t bin_content,bin_error;
	Double_t bin_size[nb_histo_equi];
	Double_t norma[nb_histo_equi];
	Int_t bin[nb_histo_equi] = {1000,100};
	Double_t xmin[nb_histo_equi] = {0.,-5.};
	Double_t xmax[nb_histo_equi] = {100.,5.};
	for (i=0;i<nb_histo_equi;i++) {
	  bin_size[i] = (xmax[i]-xmin[i])/(Double_t)bin[i];
	  norma[i] = first_int/((Double_t)numb_event*bin_size[i]);
	}
	for(i=0;i<bin[0];i++) {
		bin_content = hp20->GetBinContent(i+1);
		bin_error = hp20->GetBinError(i+1);
		bin_content = bin_content*norma[0];
		bin_error = bin_error*norma[0];
		hp20->SetBinContent(i+1,bin_content);
		hp20->SetBinError(i+1,bin_error);
	}
	for(i=0;i<bin[1];i++) {
		bin_content = hp21->GetBinContent(i+1);
		bin_error = hp21->GetBinError(i+1);
		bin_content = bin_content*norma[1];
		bin_error = bin_error*norma[1];
		hp21->SetBinContent(i+1,bin_content);
		hp21->SetBinError(i+1,bin_error);
	}

	// Save all objects in this file
	hfile->Write();
	// Close the file. Note that this is automatically done when you leave
	// the application.
	hfile->Close();
}
