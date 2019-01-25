void calculate_hessian_pdf_uncertainty(){

  const int method = 1; // 0: use difference to central value; 1: use difference of both variations; 2: use max. deviation of each parameter

  vector<TString> vec_fileNames;
  const TString fileNameTemplateStart = "2019_01_25_dir_frag_NLO_8160GeV_450Mevts_CT14nlo_0_EPPS16nlo_CT14nlo_Pb208_";
  const TString fileNameTemplateEnd = "_iso2GeVinR04_scl_10_10_10.root";
  const TString fileNameCentralValue = "2019_01_25_dir_frag_NLO_8160GeV_450Mevts_CT14nlo_0_EPPS16nlo_CT14nlo_Pb208_0_iso2GeVinR04_scl_10_10_10.root";
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

  TFile *file_out = 0x0;
  if (method == 0) file_out = new TFile(Form("pdfVar_methodPDF4LHC_%s%d_%d%s",fileNameTemplateStart.Data(), firstErrorPDF, lastErrorPDF, fileNameTemplateEnd.Data()),"RECREATE");
  if (method == 1) file_out = new TFile(Form("pdfVar_CTEQMasterFormula_%s%d_%d%s",fileNameTemplateStart.Data(), firstErrorPDF, lastErrorPDF, fileNameTemplateEnd.Data()),"RECREATE");
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

  if(method == 1){ // CTEQ master formula
    vec_histos.at(0)->Write();
    for(int i = 1; i < vec_fileNames.size(); i=i+2){
      vec_histos.at(i)->Write();
      vec_histos.at(i+1)->Write();
      for(int iBin = 1; iBin < vec_histos.at(0)->GetNbinsX(); iBin++){
	xSecDifference = (vec_histos.at(i)->GetBinContent(iBin) - vec_histos.at(i+1)->GetBinContent(iBin)); 
	sumError[iBin-1] += xSecDifference*xSecDifference;
      }
    }
  }

  /*
  double xSecDiff1, xSecDiff2;
  if(method == 2){ // following arxiv: 0605240 
  vec_histos.at(0)->Write();
    for(int i = 1; i < vec_fileNames.size(); i=i+2){
      vec_histos.at(i)->Write();
      vec_histos.at(i+1)->Write();
      for(int iBin = 1; iBin < vec_histos.at(0)->GetNbinsX(); iBin++){
	xSecDiff1 = (vec_histos.at(i)  ->GetBinContent(iBin) - vec_histos.at(0)->GetBinContent(iBin)); 
	xSecDiff2 = (vec_histos.at(i+1)->GetBinContent(iBin) - vec_histos.at(0)->GetBinContent(iBin)); 
	sumError[iBin-1] += (xSecDiff1 > xSecDiff2) ? xSecDiff1*xSecDiff1 : xSecDiff2*xSecDiff2;
      }
    }
  }
  */

  TH1D *h_finalWithPdfError = (TH1D*)vec_histos.at(0)->Clone("h_centralValueWithPdfError");
  for(int iBin = 1; iBin < vec_histos.at(0)->GetNbinsX(); iBin++){
    if(method == 0)    sumError[iBin-1] = (1./TMath::Sqrt(2))*TMath::Sqrt(sumError[iBin-1]); // factor because both directions have
    if(method == 1)    sumError[iBin-1] = 0.5*TMath::Sqrt(sumError[iBin-1]);
    h_finalWithPdfError->SetBinError(iBin, sumError[iBin-1]);
  }

  h_finalWithPdfError->Write();

}
