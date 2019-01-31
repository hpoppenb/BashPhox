#!/bin/bash

DIRNAME=2019_01_dir_frag_NLO_5020GeV_EPPS16_iso2GeVinR04_pdfVar/added_dir_and_frag/
MACROPATH=/gluster2/h_popp01/BashPhox_pPb_8160GeV/calculate_hessian_pdf_uncertainty.C

FILENAMEPREFIX=2019_01_27_dir_frag_NLO_5020GeV_450Mevts_CT14nlo_0_EPPS16nlo_CT14nlo_Pb208_
FILENAMESUFFIX=_iso2GeVinR04_scl_10_10_10.root
FILENAMECENTRAL=2019_01_27_dir_frag_NLO_5020GeV_450Mevts_CT14nlo_0_EPPS16nlo_CT14nlo_Pb208_0_iso2GeVinR04_scl_10_10_10.root
FIRSTERRORPDFNUMBER=1
LASTERRORPDFNUMBER=40
METHOD=1 # default method
REBINFACTOR=1 # use different value than 1 to check if stat. uncertainty has influence

EXECSTRING="root -l -q '$MACROPATH(\"$FILENAMEPREFIX\", \"$FILENAMESUFFIX\", \"$FILENAMECENTRAL\", $FIRSTERRORPDFNUMBER, $LASTERRORPDFNUMBER, $METHOD, $REBINFACTOR)'"

echo "cd $DIRNAME"
cd $DIRNAME

echo $EXECSTRING
eval $EXECSTRING

echo "cd -"
cd -


##### DIR ONLY #######################

DIRNAME=2019_01_dir_frag_NLO_5020GeV_EPPS16_iso2GeVinR04_pdfVar/
MACROPATH=/gluster2/h_popp01/BashPhox_pPb_8160GeV/calculate_hessian_pdf_uncertainty.C

FILENAMEPREFIX=2019_01_27_dir_NLO_5020GeV_400Mevts_CT14nlo_0_EPPS16nlo_CT14nlo_Pb208_
FILENAMESUFFIX=_iso2GeVinR04_scl_10_10_10.root
FILENAMECENTRAL=2019_01_27_dir_NLO_5020GeV_400Mevts_CT14nlo_0_EPPS16nlo_CT14nlo_Pb208_0_iso2GeVinR04_scl_10_10_10.root
FIRSTERRORPDFNUMBER=1
LASTERRORPDFNUMBER=40
METHOD=1 # default method
REBINFACTOR=1 # use different value than 1 to check if stat. uncertainty has influence

EXECSTRING="root -l -q '$MACROPATH(\"$FILENAMEPREFIX\", \"$FILENAMESUFFIX\", \"$FILENAMECENTRAL\", $FIRSTERRORPDFNUMBER, $LASTERRORPDFNUMBER, $METHOD, $REBINFACTOR)'"

echo "cd $DIRNAME"
cd $DIRNAME

echo $EXECSTRING
eval $EXECSTRING

echo "cd -"
cd -


#### FRAG ONLY #######################

DIRNAME=2019_01_dir_frag_NLO_5020GeV_EPPS16_iso2GeVinR04_pdfVar/
MACROPATH=/gluster2/h_popp01/BashPhox_pPb_8160GeV/calculate_hessian_pdf_uncertainty.C

FILENAMEPREFIX=2019_01_27_frag_NLO_5020GeV_50Mevts_CT14nlo_0_EPPS16nlo_CT14nlo_Pb208_
FILENAMESUFFIX=_iso2GeVinR04_scl_10_10_10.root
FILENAMECENTRAL=2019_01_27_frag_NLO_5020GeV_50Mevts_CT14nlo_0_EPPS16nlo_CT14nlo_Pb208_0_iso2GeVinR04_scl_10_10_10.root
FIRSTERRORPDFNUMBER=1
LASTERRORPDFNUMBER=40
METHOD=1 # default method
REBINFACTOR=1 # use different value than 1 to check if stat. uncertainty has influence

EXECSTRING="root -l -q '$MACROPATH(\"$FILENAMEPREFIX\", \"$FILENAMESUFFIX\", \"$FILENAMECENTRAL\", $FIRSTERRORPDFNUMBER, $LASTERRORPDFNUMBER, $METHOD, $REBINFACTOR)'"

echo "cd $DIRNAME"
cd $DIRNAME

echo $EXECSTRING
eval $EXECSTRING

echo "cd -"
cd -
