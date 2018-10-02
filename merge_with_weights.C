// If you have to produce additional events:
// This is a simple macro to merge two jetphox root files
// with appropriate weighting per event
void merge_with_weights(TString fileName1 = "2018_09_28_dir_LO_5020GeV_100Mevts_pp_CT14nlo_incl_iso5020GeVinR04_scl_10_10_10.root",
			TString fileName2 = "2018_09_28_dir_LO_5020GeV_200Mevts_pp_CT14nlo_incl_iso5020GeVinR04_scl_10_10_10.root"){

  TFile *f1 = new TFile(fileName1);
  TFile *f2 = new TFile(fileName2);

  TObjArray* ar1 = fileName1.Tokenize("_");
  TObjArray* ar2 = fileName2.Tokenize("_");

  // Index of token containing number of events may vary
  TObjString* evtObjString1 = (TObjString*)ar1->At(6);
  TObjString* evtObjString2 = (TObjString*)ar2->At(6);

  TString evtString1 = evtObjString1->GetString();
  TString evtString2 = evtObjString2->GetString();

  evtString1 = evtString1.ReplaceAll("Mevts","");
  evtString2 = evtString2.ReplaceAll("Mevts","");

  evtString1 = evtString1.ReplaceAll("evts","");
  evtString2 = evtString2.ReplaceAll("evts","");

  printf("File %s contains %s events\n", fileName1.Data(), evtString1.Data());
  printf("File %s contains %s events\n", fileName2.Data(), evtString2.Data());

  double nEvents1 = evtString1.Atof();
  double nEvents2 = evtString2.Atof();

  // NB: Sumw2() is already called on jetphox histos
  TH1D *hp20_1 = (TH1D*)f1->Get("hp20");
  TH1D *hp21_1 = (TH1D*)f1->Get("hp21");
  TH1D *hp20_2 = (TH1D*)f2->Get("hp20");
  TH1D *hp21_2 = (TH1D*)f2->Get("hp21");

  TH1D *hp20_final = (TH1D*)hp20_1->Clone("hp20");
  TH1D *hp21_final = (TH1D*)hp21_1->Clone("hp21");

  hp20_final->Scale(nEvents1);
  hp20_final->Add(hp20_2, nEvents2);
  hp20_final->Scale(1./(nEvents1+nEvents2));

  hp21_final->Scale(nEvents1);
  hp21_final->Add(hp21_2, nEvents2);
  hp21_final->Scale(1./(nEvents1+nEvents2));

  TString fileNameOut = "merged.root";
  TFile *fileOut = new TFile("merged.root","RECREATE");
  hp20_final->Write();
  hp21_final->Write();
  fileOut->Close();


  return;
}
