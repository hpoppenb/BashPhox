void calculate_hessian_pdf_uncertainty(){

  const int method = 0; // 0: use difference to central value; 1: use difference of both variations

  vector<TString> vec_fileNames;
  const TString fileNameTemplateStart = "2019_01_20_dir_frag_NLO_8160GeV_50Mevts_CT14nlo_0_EPPS16nlo_CT14nlo_Pb208_";
  const TString fileNameTemplateEnd = "_iso2GeVinR04_scl_10_10_10.root";
  const TString fileNameCentralValue = "2018_12_12_dir_frag_NLO_8160GeV_500Mevts_CT14nlo_EPPS16nlo_CT14nlo_Pb208_iso2GeVinR04_scl_10_10_10.root";
  vec_fileNames.push_back(fileNameCentralValue.Data());
  const int firstErrorPDF = 1;
  const int lastErrorPDF = 40;
  for(int i = firstErrorPDF; i <= lastErrorPDF; i++){
    vec_fileNames.push_back(Form("%s%d%s", fileNameTemplateStart.Data(), i, fileNameTemplateEnd.Data()));
  }

  vector<TH1D*> vec_histos;

  for(int i = 0; i < vec_fileNames.size(); i++){
    TFile *file_in = new TFile(vec_fileNames.at(i));
    //file_in->ls();
    vec_histos.push_back((TH1D*)file_in->Get("hp20"));
    vec_histos.at(i)->SetDirectory(0); // decouple histo from file
    file_in->Close();
  }

  double sumError[1000] = {0.};
  double xSecDifference = 0.;

  TFile *file_out = new TFile(Form("pdfVar_%s%d_%d%s",fileNameTemplateStart.Data(), firstErrorPDF, lastErrorPDF, fileNameTemplateEnd.Data()),"RECREATE");
  file_out->cd();
  if(method == 0){ // following PDF4LHC recommendations for LHC Run II
    for(int i = 0; i < vec_fileNames.size(); i++){
      vec_histos.at(i)->Write();
      for(int iBin = 1; iBin < vec_histos.at(0)->GetNbinsX(); iBin++){
	xSecDifference = (vec_histos.at(i)->GetBinContent(iBin) - vec_histos.at(0)->GetBinContent(iBin)); 
	sumError[iBin-1] += xSecDifference*xSecDifference;
      }
    }
  }

  if(method == 1){ // following method of R. Stump, PHYSTAT2003....
    for(int i = 1; i < vec_fileNames.size(); i=i+2){
      vec_histos.at(i)->Write();
      for(int iBin = 1; iBin < vec_histos.at(0)->GetNbinsX(); iBin++){
	xSecDifference = (vec_histos.at(i)->GetBinContent(iBin) - vec_histos.at(i+1)->GetBinContent(iBin)); 
	sumError[iBin-1] += xSecDifference*xSecDifference;
      }
    }
  }

  TH1D *h_finalWithPdfError = (TH1D*)vec_histos.at(0)->Clone("h_centralValueWithPdfError");
  for(int iBin = 1; iBin < vec_histos.at(0)->GetNbinsX(); iBin++){
    if(method == 0)    sumError[iBin-1] = 0.5*TMath::Sqrt(sumError[iBin-1]);
    if(method == 1)    sumError[iBin-1] = 0.5*TMath::Sqrt(sumError[iBin-1]);
    h_finalWithPdfError->SetBinError(iBin, sumError[iBin-1]);
  }

  h_finalWithPdfError->Write();

}
