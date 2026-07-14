/*=========================================================================
* Project:			Medicare Coverage, Financial Hardship, and 
					Inequalities in Older Adult Wellbeing
* Author: 		    J. Auth
* Datasets: 	    NHATS R1-R14 Public Use Sample Person and Tracker Files
* Dependencies:     Institute for Research on Poverty
---------------------------------------------------------------------------
Creation Date:		12/01/2026
Modification Date:  06/07/2026
Do-file version:	2
Note:			    This do file has been changed since PPAR submission
					on 06/01/2026 the unedited version of the PPAR do file	
					can be found in GitHub. The data used to replicate the 
					prior tables can be found in Box as V8 (Version 8 of
					the used data files).
=========================================================================*/

/*=========================================================================
				0: Program set up
=========================================================================*/
version 19.5          // Set version for compatibility
clear all			  // Clear memory
drop _all		      // Clear macros
set more off		  // Disable partitioned output
capture log close     // Close any open log files

cd "~/Library/CloudStorage/Box-Box/Medigap_Food"

log using "PPAR Manuscript/NHATS_PPAR_rv", replace


/*==========================================================================
				1: Clean & Merge Data Files
==========================================================================*/

/*--------------------------------------------------------------------------
			  1.1: Merge Round 1-8 SP & Metro Files
--------------------------------------------------------------------------*/
cd "~/Library/CloudStorage/Box-Box/Medigap_Food/NHATS/Public Use Data"


*---------ROUND 1
use "raw/R1_STATA/NHATS_Round_1_SP_File.dta", clear
merge 1:1 spid using "raw/R1_STATA/NHATS_Round_1_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "merged_sp_met_rounds/NHATS_Round_1_SP_Met_File.dta", replace


*---------ROUND 2
use "raw/R2_STATA/NHATS_Round_2_SP_File_v2.dta", clear
merge 1:1 spid using "raw/R2_STATA/NHATS_Round_2_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "merged_sp_met_rounds/NHATS_Round_2_SP_Met_File.dta", replace


*---------ROUND 3
use "raw/R3_STATA/NHATS_Round_3_SP_File.dta", clear
merge 1:1 spid using "raw/R3_STATA/NHATS_Round_3_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "merged_sp_met_rounds/NHATS_Round_3_SP_Met_File.dta", replace


*---------ROUND 4
use "raw/R4_STATA/NHATS_Round_4_SP_File.dta", clear
merge 1:1 spid using "raw/R4_STATA/NHATS_Round_4_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "merged_sp_met_rounds/NHATS_Round_4_SP_Met_File.dta", replace


*---------ROUND 5
use "raw/R5_STATA/NHATS_Round_5_SP_File_V2.dta", clear
merge 1:1 spid using "raw/R5_STATA/NHATS_Round_5_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "merged_sp_met_rounds/NHATS_Round_5_SP_Met_File.dta", replace


*---------ROUND 6
use "raw/R6_STATA/NHATS_Round_6_SP_File_V2.dta", clear
merge 1:1 spid using "raw/R6_STATA/NHATS_Round_6_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "merged_sp_met_rounds/NHATS_Round_6_SP_Met_File.dta", replace


*---------ROUND 7
use "raw/R7_STATA/NHATS_Round_7_SP_File.dta", clear
merge 1:1 spid using "raw/R7_STATA/NHATS_Round_7_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "merged_sp_met_rounds/NHATS_Round_7_SP_Met_File.dta", replace


*---------ROUND 8
use "raw/R8_STATA/NHATS_Round_8_SP_File.dta", clear
merge 1:1 spid using "raw/R8_STATA/NHATS_Round_8_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "merged_sp_met_rounds/NHATS_Round_8_SP_Met_File.dta", replace


/*--------------------------------------------------------------------------
			  1.2: Clean Tracker Files
--------------------------------------------------------------------------*/

*---------ROUND 1
use "raw/R1_STATA/NHATS_Round_1_Tracker_File.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *status* *varunit* *varstrat*
save "clean_trackers/R1_tracker_clean.dta", replace


*---------ROUND 2
use "raw/R2_STATA/NHATS_Round_2_Tracker_File_v2.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *2status* *2varunit* *2varstrat*
save "clean_trackers/R2_tracker_clean.dta", replace


*---------ROUND 3
use "raw/R3_STATA/NHATS_Round_3_Tracker_File_V2.dta", clear
tab yearsample
sort spid
keep yearsample spid *3status* *3varunit* *3varstrat*
count
save "clean_trackers/R3_tracker_clean.dta", replace


*---------ROUND 4
use "raw/R4_STATA/NHATS_Round_4_Tracker_File_V2.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *4status* *4varunit* *4varstrat*
save "clean_trackers/R4_tracker_clean.dta", replace


*---------ROUND 5
use "raw/R5_STATA/NHATS_Round_5_Tracker_File_V3.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *5status* *5varunit* *5varstrat*
save "clean_trackers/R5_tracker_clean.dta", replace


*---------ROUND 6
use "raw/R6_STATA/NHATS_Round_6_Tracker_File_V3.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *6status* *6varunit* *6varstrat*
save "clean_trackers/R6_tracker_clean.dta", replace


*---------ROUND 7
use "raw/R7_STATA/NHATS_Round_7_Tracker_File_V2.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *7status* *7varunit* *7varstrat*
save "clean_trackers/R7_tracker_clean.dta", replace


*---------ROUND 8
use "raw/R8_STATA/NHATS_Round_8_Tracker_File_V2.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *8status* *8varunit* *8varstrat*
save "clean_trackers/R8_tracker_clean.dta", replace


*---------ROUND 9
use "raw/R9_STATA/NHATS_Round_9_Tracker_File.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *9status* *9varunit* *9varstrat*
save "clean_trackers/R9_tracker_clean.dta", replace


*---------ROUND 10
use "raw/R10_STATA/NHATS_Round_10_Tracker_File.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *10status* *10varunit* *10varstrat*
save "clean_trackers/R10_tracker_clean.dta", replace


*---------ROUND 11
use "raw/R11_STATA/NHATS_Round_11_Tracker_File.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *11status* *11varunit* *11varstrat*
save "clean_trackers/R11_tracker_clean.dta", replace


*---------ROUND 12
use "raw/R12_STATA/NHATS_Round_12_Tracker_File.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *12status* *12varunit* *12varstrat*
save "clean_trackers/R12_tracker_clean.dta", replace


*---------ROUND 13
use "raw/R13_STATA/NHATS_Round_13_Tracker_File_V2.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *13status* *13varunit* *13varstrat*
save "clean_trackers/R13_tracker_clean.dta", replace


*---------ROUND 14
use "raw/R14_STATA/NHATS_Round_14_Tracker_File.dta", clear
count
tab yearsample
sort spid
keep yearsample spid *14status* *14varunit* *14varstrat*
save "clean_trackers/R14_tracker_clean.dta", replace


/*--------------------------------------------------------------------------
			  1.3: Merge Clean Tracker Files & SP Files
--------------------------------------------------------------------------*/

*---------ROUND 1
use "clean_trackers/R1_tracker_clean.dta", clear
merge 1:1 spid using "merged_sp_met_rounds/NHATS_Round_1_SP_Met_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R1.dta", replace


*---------ROUND 2
use "clean_trackers/R2_tracker_clean.dta", clear
merge 1:1 spid using "merged_sp_met_rounds/NHATS_Round_2_SP_Met_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R2.dta", replace


*---------ROUND 3
use "clean_trackers/R3_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "merged_sp_met_rounds/NHATS_Round_3_SP_Met_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R3.dta", replace


*---------ROUND 4
use "clean_trackers/R4_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "merged_sp_met_rounds/NHATS_Round_4_SP_Met_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R4.dta", replace


*---------ROUND 5
use "clean_trackers/R5_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "merged_sp_met_rounds/NHATS_Round_5_SP_Met_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R5.dta", replace


*---------ROUND 6
use "clean_trackers/R6_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "merged_sp_met_rounds/NHATS_Round_6_SP_Met_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R6.dta", replace


*---------ROUND 7
use "clean_trackers/R7_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "merged_sp_met_rounds/NHATS_Round_7_SP_Met_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R7.dta", replace


*---------ROUND 8
use "clean_trackers/R8_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "merged_sp_met_rounds/NHATS_Round_8_SP_Met_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R8.dta", replace


*---------ROUND 9
use "clean_trackers/R9_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "raw/R9_STATA/NHATS_Round_9_SP_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R9.dta", replace


*---------ROUND 10
use "clean_trackers/R10_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "raw/R10_STATA/NHATS_Round_10_SP_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R10.dta", replace


*---------ROUND 11
use "clean_trackers/R11_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "raw/R11_STATA/NHATS_Round_11_SP_File_V2.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R11.dta", replace


*---------ROUND 12
use "clean_trackers/R12_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "raw/R12_STATA/NHATS_Round_12_SP_File_V2.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R12.dta", replace


*---------ROUND 13
use "clean_trackers/R13_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "raw/R13_STATA/NHATS_Round_13_SP_File_V2.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R13.dta", replace


*---------ROUND 14
use "clean_trackers/R14_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "raw/R14_STATA/NHATS_Round_14_SP_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "merged_rounds/R14.dta", replace


/*--------------------------------------------------------------------------
			  1.4: Check Merged Rounds
--------------------------------------------------------------------------*/
foreach r of numlist 1/14 {
    use "merged_rounds/R`r'.dta", clear
    duplicates report spid
    display "Round `r' has `=_N' observations"
}


foreach r of numlist 1/14 {
    use "merged_rounds/R`r'.dta", clear
    display "Round `r' file:"
    tab yearsample
}

clear all


/*--------------------------------------------------------------------------
			  1.5: Clean Merged Rounds
--------------------------------------------------------------------------*/

*---------ROUND 1
use "merged_rounds/R1.dta", clear
describe
count

gen year   = 2011
gen retire = lf1workfpay == 3

// generate variables missing in R1
gen spdied 	     = 0 if yearsample == 2011
gen resnew_flg   = 0 if yearsample == 2011
gen skipmeal     = 0 if yearsample == 2011
gen freqskipmeal = 0 if yearsample == 2011
gen nopayhous    = 0 if yearsample == 2011
gen nopayutil    = 0 if yearsample == 2011
gen nopaymed     = 0 if yearsample == 2011

// rename variables with general names (non-round specific)
rename *dgender*   gender
rename *racehisp*  race
rename *higstschl* entryed
rename r1status    spstatus
rename r1dresid    resid
rename *resptype*  resptype
rename *intvrage*  intvage
rename *martlstat* marstat
rename *hshldnum*  houshldsz
rename *lvngarrg*  lvngarrg
rename *placedesc* resdesc
rename *placekind* reskind
rename *retiresen* retirhous
rename *sec8pubsn* pubsnhous
rename *facdescr*  facdesc_fq
rename *osfacd*    osfacds_fq
rename *facarea*   facarea_fq
rename *osfaca*    osfacar_fq
rename *censdiv*   censdiv
rename *metnonmet* metro
rename *mgapmedsp* medigapcov
rename *covmedcad* partdcov
rename *otdrugcov* otdrugcov
rename *covtricar* tricarcov
rename *cmedicaid* medicaidcov
rename *totinc*    totalinc
rename *workfpay*  workpay
rename *wrkplstmn* worklsmo
rename *shopwout*  skipgroc
rename *howpaygr5* snpebt_flg
rename *progneed1* snpebt
rename *bankwout*  nopaybill
rename *varunit*   varunit
rename *varstrat*  varstrat
rename *anfinwgt0* anfinwgt0

// rename and label health condition variables
local lbl1  "Heart Attack"
local lbl2  "Heart Disease"
local lbl3  "Hypertension"
local lbl4  "Arthritis"
local lbl5  "Osteoporosis"
local lbl6  "Diabetes"
local lbl7  "Lung Disease"
local lbl8  "Stroke"
local lbl9  "Dementia or Alzheimers"
local lbl10 "Cancer"

forvalues i = 1/10 {
    rename hc1disescn`i' disescn`i'
    label var disescn`i' "Ever Had `lbl`i''"
}

// re-label variables cohesively (non-round specific)
label var year         "Survey Year"
label var retire       "Retired"
label var spdied       "Died Prior to Round"
label var resnew_flg   "New Address"
label var skipmeal     "Skipped Meals, No Money"
label var freqskipmeal "Skip Meals How Often"
label var nopayhous    "No Money for Housing"
label var nopayutil    "No Money for Utilities"
label var nopaymed     "Medical-Financial Hardship"
label var gender       "Gender of SP"
label var race         "Race/Ethnicity"
label var entryed      "Highest Level of Education at Entry"
label var spstatus     "Overall Case Status"
label var resptype     "Respondent is Sample Person"
label var intvage      "Categorical Age at Interview"
label var marstat      "Marital Status"
label var houshldsz    "Number of People Living in Household"
label var lvngarrg     "Living Arrangement"
label var resid        "Residential Care Status"
label var resdesc      "Residence Description"
label var reskind      "Type of Residence"
label var retirhous    "Retirement Community/Senior Housing"
label var pubsnhous    "Public Senior Housing (HME Section 8)"
label var facdesc_fq   "Living Facility Type"
label var osfacds_fq   "Specify Other Living Facility Type"
label var facarea_fq   "Living Facility Area"
label var osfacar_fq   "Specify Other Living Facility Area"
label var censdiv      "Census Division"
label var metro        "Metropolitan Residence Status"
label var medigapcov   "Medigap Supplement"
label var partdcov     "Part D Drug Coverage"
label var otdrugcov    "Other Drug Coverage"
label var tricarcov    "Tricare/VA Care"
label var medicaidcov  "Medicaid Coverage"
label var totalinc     "Total Income"
label var workpay      "Worked for Pay Recently"
label var worklsmo     "Worked for Pay in Last Month"
label var skipgroc     "Ever Go Without Groceries"
label var snpebt_flg   "Pay for Groceries Using Food Stamps"
label var snpebt       "Recieved Food Stamps"
label var nopaybill    "Ever Go Without Paying Bills"
label var varunit      "Variance Estimation Cluster"
label var varstrat     "Variance Estimation Stratum"
label var anfinwgt0    "Full Final Analytic Weight"

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global  B *hous* *cov* worklsmo skipgroc snpebt* nopay* metro disescn*
recode $B (2 .=0)

recode houshldsz  (0=.)
recode lvngarrg   (4=3) (3=4)
recode race       (4=3) (3=4) (5 6=5)
recode resid      (4=3) (2 3=2)
recode resdesc 	  (91=5) 
recode reskind    (3=2) (5=3) (91=6)
recode facdesc_fq (91=9)
recode facarea_fq (91=5)
recode workpay    (2 3 .=0) 

// label variable values
label val gender       gender
label val race         race
label val entryed      entryed
label val spstatus     spstatus
label val intvage      intvage
label val marstat      marstat
label val lvngarrg     lvngarrg
label val resid        resid
label val resdesc      resdesc
label val reskind      reskind
label val facdesc_fq   facdesc_fq
label val osfacds_fq   osfacds_fq
label val facarea_fq   facarea_fq
label val osfacar_fq   osfacar_fq
label val censdiv      censdiv
label val metro        metro
label val freqskipmeal freqskipmeal

label val spdied resptype resnew_flg retirhous pubsnhous disescn* ///
		  *cov* work* skipmeal skipgroc snp* nopay* binary

// define variable label values		  
label def binary ///
0 "0" ///
1 "1"

label def gender ///
1 "Male" ///
2 "Female"

label def race ///
1 "Non-Hispanic White" ///
2 "Non-Hispanic Black" ///
3 "Hispanic" ///
4 "Other Race" ///
5 "Mulitple or Unknown"

label def entryed ///
1  "No Schooling" ///
2  "Grade 1-8" ///
3  "Some High School" ///
4  "High School Diploma" ///
5  "Vocational, Tech, or Trade School" ///
6  "Some College, No Degree" ///
7  "Associate's Degree" ///
8  "Bachelor's Degree" ///
9  "Professional Degree"

label def spstatus ///
60 "Complete" ///
61 "Complete, Living Facility" ///
62 "Complete SP Deceased, Proxy Intv" ///
63 "Complete SP, FQ not complete" ///
64 "Complete FQ, SP not complete"

label def intvage ///
1 "65-69" ///
2 "70-74" ///
3 "75-79" ///		  
4 "80-84" ///		  
5 "85-89" ///		  
6 "90+"

label def marstat ///		
1 "Married" ///			
2 "Living with Partner" ///
3 "Separated" ///
4 "Divorced" ///
5 "Widowed" ///
6 "Never Married"

label def lvngarrg ///
1 "Alone" ///
2 "With Partner" ///
3 "With Others" ///
4 "With Partner and Others"

label def resid ///
1 "Community" ///
2 "Residential Care" ///
3 "Nursing Home"

label def resdesc ///
1 "Private Residence" ///
2 "Group Home" ///
3 "Assisted Living" ///
4 "Religious Group Quarters" ///
5 "Other"

label def reskind ///
1 "Private Residence" ///
2 "Assisted Living" ///
3 "Nursing Home" ///
4 "Other"

label def facdesc_fq ///
1 "Nursing Home" ///
2 "Assisted Living" ///
3 "Nursing Home and Assisted Living Facility" ///
4 "Continuing Care Community" ///
5 "Adult Family Care Home" ///
6 "Group Home" ///								  
7 "Board and Care Home" ///					  
8 "Retirement Community or Senior Housing" ///
9 "Other (Specify)"			

label def osfacds_fq ///
1 "Nursing Home" ///
2 "Assisted Living" ///
3 "Nursing Home and Assisted Living Facility" ///
4 "Continuing Care Community" ///
5 "Adult Family Care Home" ///
6 "Group Home" ///
7 "Board and Care Home" ///
8 "Retirement Community or Senior Housing" ///
9 "Independent Living" ///
10 "Assisted and Independent Retirement Housing" ///
11 "Housing (Apt, Condo, etc.)"

label def facarea_fq ///
1 "Independent Living" ///
2 "Assisted Living" ///
3 "Special or Memory Care" ///
4 "Nursing Home" ///
5 "Other (Specify)"

label def osfacar_fq ///
1 "Independent Living" ///
2 "Assisted Living" ///
3 "Special or Memory Care" ///
4 "Nursing Home"

label def censdiv ///
1 "New England" ///
2 "Mid Atlantic" ///
3 "Northeast Midwest" ///
4 "Northwest Midwest" ///
5 "South Atlantic" ///
6 "Southeast Central" ///
7 "Southwest Central" ///
8 "West Mountain" ///
9 "West Pacific"

label def metro ///
0 "Rural" ///
1 "Metropolitan"

label def freqskipmeal ///
0 "N/A" ///
1 "A Few Days" ///
2 "Several Days" ///
3 "More Than Half the Days" ///
4 "Nearly Every Day"

// keep only variables of interest
keep ///
gender race entryed ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
tot* work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R1_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 2
use "merged_rounds/R2.dta", clear
describe
count

gen year = 2012
gen retire = lf2workfpay == 3

// rename variables with general names (non-round specific)
rename fl2spdied    spdied
rename r2status     spstatus
rename fl2resnew    resnew_flg
rename r2dresid     resid
rename *resptype*   resptype
rename *intvrage*   intvage
rename *marstat*    marstat
rename *hshldnum*   houshldsz
rename *lvngarrg*   lvngarrg
rename *placedesc*  resdesc
rename *placekind*  reskind
rename *retiresen*  retirhous
rename *sec8pubsn*  pubsnhous
rename *facdescr*   facdesc_fq
rename *osfacd*     osfacds_fq
rename *facarea*    facarea_fq
rename *osfaca*     osfacar_fq
rename *censdiv*    censdiv
rename *metnonmet*  metro
rename *mgapmedsp*  medigapcov
rename *covmedcad*  partdcov
rename *otdrugcov*  otdrugcov
rename *covtricar*  tricarcov
rename *medicaid*   medicaidcov
rename *workfpay*   workpay
rename *wrkplstmn*  worklsmo
rename *mealskip1*  skipmeal
rename *mealskip2*  freqskipmeal
rename *shopwout*   skipgroc
rename *howpaygr5*  snpebt_flg
rename *progneed1*  snpebt
rename *bankwout*   nopaybill
rename *nopayhous*  nopayhous
rename *nopayutil*  nopayutil
rename *nopaymed*   nopaymed
rename *2varunit*   varunit
rename *2varstrat*  varstrat
rename *2anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc2disescn`i' disescn`i'
}

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global  B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R2_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 3
use "merged_rounds/R3.dta", clear
describe
count

g year = 2013
gen retire = lf3workfpay == 3

// rename variables with general names (non-round specific)
rename fl3spdied    spdied
rename r3status     spstatus
rename fl3resnew    resnew_flg
rename r3dresid     resid
rename *resptype*   resptype
rename *intvrage*   intvage
rename *marstat*    marstat
rename *hshldnum*   houshldsz
rename *lvngarrg*   lvngarrg
rename *placedesc*  resdesc
rename *placekind*  reskind
rename *retiresen*  retirhous
rename *sec8pubsn*  pubsnhous
rename *facdescr*   facdesc_fq
rename *osfacd*     osfacds_fq
rename *facarea*    facarea_fq
rename *osfaca*     osfacar_fq
rename *censdiv*    censdiv
rename *metnonmet*  metro
rename *mgapmedsp*  medigapcov
rename *covmedcad*  partdcov
rename *otdrugcov*  otdrugcov
rename *covtricar*  tricarcov
rename *medicaid*   medicaidcov
rename *totinc*     totalinc
rename *workfpay*   workpay
rename *wrkplstmn*  worklsmo
rename *mealskip1*  skipmeal
rename *mealskip2*  freqskipmeal
rename *shopwout*   skipgroc
rename *howpaygr5*  snpebt_flg
rename *progneed1*  snpebt
rename *bankwout*   nopaybill
rename *nopayhous*  nopayhous
rename *nopayutil*  nopayutil
rename *nopaymed*   nopaymed
rename *3varunit*   varunit
rename *3varstrat*  varstrat
rename *3anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc3disescn`i' disescn`i'
}

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
tot* work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R3_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 4
use "merged_rounds/R4.dta", clear
describe
count

g year = 2014
gen retire = lf4workfpay == 3

// rename variables with general names (non-round specific)
rename fl4spdied    spdied
rename r4status     spstatus
rename fl4resnew    resnew_flg
rename r4dresid     resid
rename *resptype*   resptype
rename *intvrage*   intvage
rename *marstat*    marstat
rename *hshldnum*   houshldsz
rename *lvngarrg*   lvngarrg
rename *placedesc*  resdesc
rename *placekind*  reskind
rename *retiresen*  retirhous
rename *sec8pubsn*  pubsnhous
rename *facdescr*   facdesc_fq
rename *osfacd*     osfacds_fq
rename *facarea*    facarea_fq
rename *osfaca*     osfacar_fq
rename *censdiv*    censdiv
rename *metnonmet*  metro
rename *mgapmedsp*  medigapcov
rename *covmedcad*  partdcov
rename *otdrugcov*  otdrugcov
rename *covtricar*  tricarcov
rename *medicaid*   medicaidcov
rename *workfpay*   workpay
rename *wrkplstmn*  worklsmo
rename *mealskip1*  skipmeal
rename *mealskip2*  freqskipmeal
rename *shopwout*   skipgroc
rename *howpaygr5*  snpebt_flg
rename *progneed1*  snpebt
rename *bankwout*   nopaybill
rename *nopayhous*  nopayhous
rename *nopayutil*  nopayutil
rename *nopaymed*   nopaymed
rename *4varunit*   varunit
rename *4varstrat*  varstrat
rename *4anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc4disescn`i' disescn`i'
}

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R4_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 5
use "merged_rounds/R5.dta", clear
describe
count

g year = 2015
gen retire = lf5workfpay == 3

// rename variables with general names (non-round specific)
rename r5dgender    gender
rename rl5dracehisp race
rename el5higstschl entryed
rename r5dcontnew   cohort
rename fl5spdied    spdied
rename r5status     spstatus
rename fl5resnew    resnew_flg
rename r5dresid     resid
rename *resptype*   resptype
rename *intvrage*   intvage
rename *marstat*    marstat
rename *hshldnum*   houshldsz
rename *lvngarrg*   lvngarrg
rename *placedesc*  resdesc
rename *placekind*  reskind
rename *retiresen*  retirhous
rename *sec8pubsn*  pubsnhous
rename *facdescr*   facdesc_fq
rename *osfacd*     osfacds_fq
rename *facarea*    facarea_fq
rename *osfaca*     osfacar_fq
rename *censdiv*    censdiv
rename *metnonmet*  metro
rename *mgapmedsp*  medigapcov
rename *covmedcad*  partdcov
rename *otdrugcov*  otdrugcov
rename *covtricar*  tricarcov
rename *medicaid*   medicaidcov
rename *totinc*     totalinc
rename *workfpay*   workpay
rename *wrkplstmn*  worklsmo
rename *mealskip1*  skipmeal
rename *mealskip2*  freqskipmeal
rename *shopwout*   skipgroc
rename *howpaygr5*  snpebt_flg
rename *progneed1*  snpebt
rename *bankwout*   nopaybill
rename *nopayhous*  nopayhous
rename *nopayutil*  nopayutil
rename *nopaymed*   nopaymed
rename *5varunit*   varunit
rename *5varstrat*  varstrat
rename *5anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc5disescn`i' disescn`i'
}

// label and define values of cohort variable
label var cohort "Cohort (Entry Round)"
label val cohort cohort
label def cohort ///
1 "R1" ///
2 "R5" ///
3 "R12" ///
4 "R13" ///

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode race         (4=3) (3=4) (5 6=5)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
gender race entryed cohort ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
tot* work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R5_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 6
use "merged_rounds/R6.dta", clear
describe
count

g year = 2016
gen retire = lf6workfpay == 3

// rename variables with general names (non-round specific)
rename fl6spdied    spdied
rename r6status     spstatus
rename fl6resnew    resnew_flg
rename r6dresid     resid
rename *resptype*   resptype
rename *intvrage*   intvage
rename *marstat*    marstat
rename *hshldnum*   houshldsz
rename *lvngarrg*   lvngarrg
rename *placedesc*  resdesc
rename *placekind*  reskind
rename *retiresen*  retirhous
rename *sec8pubsn*  pubsnhous
rename *facdescr*   facdesc_fq
rename *osfacd*     osfacds_fq
rename *facarea*    facarea_fq
rename *osfaca*     osfacar_fq
rename *censdiv*    censdiv
rename *metnonmet*  metro
rename *mgapmedsp*  medigapcov
rename *covmedcad*  partdcov
rename *otdrugcov*  otdrugcov
rename *covtricar*  tricarcov
rename *medicaid*   medicaidcov
rename *workfpay*   workpay
rename *wrkplstmn*  worklsmo
rename *mealskip1*  skipmeal
rename *mealskip2*  freqskipmeal
rename *shopwout*   skipgroc
rename *howpaygr5*  snpebt_flg
rename *progneed1*  snpebt
rename *bankwout*   nopaybill
rename *nopayhous*  nopayhous
rename *nopayutil*  nopayutil
rename *nopaymed*   nopaymed
rename *6varunit*   varunit
rename *6varstrat*  varstrat
rename *6anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc6disescn`i' disescn`i'
}

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R6_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 7
use "merged_rounds/R7.dta", clear
describe
count

g year = 2017
gen retire = lf7workfpay == 3

// rename variables with general names (non-round specific)
rename fl7spdied    spdied
rename r7status     spstatus
rename fl7resnew    resnew_flg
rename r7dresid     resid
rename *resptype*   resptype
rename *intvrage*   intvage
rename *marstat*    marstat
rename *hshldnum*   houshldsz
rename *lvngarrg*   lvngarrg
rename *placedesc*  resdesc
rename *placekind*  reskind
rename *retiresen*  retirhous
rename *sec8pubsn*  pubsnhous
rename *facdescr*   facdesc_fq
rename *osfacd*     osfacds_fq
rename *facarea*    facarea_fq
rename *osfaca*     osfacar_fq
rename *censdiv*    censdiv
rename *metnonmet*  metro
rename *mgapmedsp*  medigapcov
rename *covmedcad*  partdcov
rename *otdrugcov*  otdrugcov
rename *covtricar*  tricarcov
rename *medicaid*   medicaidcov
rename *totinc*     totalinc
rename *workfpay*   workpay
rename *wrkplstmn*  worklsmo
rename *mealskip1*  skipmeal
rename *mealskip2*  freqskipmeal
rename *shopwout*   skipgroc
rename *howpaygr5*  snpebt_flg
rename *progneed1*  snpebt
rename *bankwout*   nopaybill
rename *nopayhous*  nopayhous
rename *nopayutil*  nopayutil
rename *nopaymed*   nopaymed
rename *7varunit*   varunit
rename *7varstrat*  varstrat
rename *7anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc7disescn`i' disescn`i'
}

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
tot* work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R7_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 8
use "merged_rounds/R8.dta", clear
describe
count

g year = 2018
gen retire = lf8workfpay == 3

// rename variables with general names (non-round specific)
rename fl8spdied    spdied
rename r8status     spstatus
rename fl8resnew    resnew_flg
rename r8dresid     resid
rename *resptype*   resptype
rename *intvrage*   intvage
rename *marstat*    marstat
rename *hshldnum*   houshldsz
rename *lvngarrg*   lvngarrg
rename *placedesc*  resdesc
rename *placekind*  reskind
rename *retiresen*  retirhous
rename *sec8pubsn*  pubsnhous
rename *facdescr*   facdesc_fq
rename *osfacd*     osfacds_fq
rename *facarea*    facarea_fq
rename *osfaca*     osfacar_fq
rename *censdiv*    censdiv
rename *metnonmet*  metro
rename *mgapmedsp*  medigapcov
rename *covmedcad*  partdcov
rename *otdrugcov*  otdrugcov
rename *covtricar*  tricarcov
rename *medicaid*   medicaidcov
rename *workfpay*   workpay
rename *wrkplstmn*  worklsmo
rename *mealskip1*  skipmeal
rename *mealskip2*  freqskipmeal
rename *shopwout*   skipgroc
rename *howpaygr5*  snpebt_flg
rename *progneed1*  snpebt
rename *bankwout*   nopaybill
rename *nopayhous*  nopayhous
rename *nopayutil*  nopayutil
rename *nopaymed*   nopaymed
rename *8varunit*   varunit
rename *8varstrat*  varstrat
rename *8anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc8disescn`i' disescn`i'
}

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R8_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 9
use "merged_rounds/R9.dta", clear
describe
count

g year = 2019
gen retire = lf9workfpay == 3

// rename variables with general names (non-round specific)
rename fl9spdied    spdied
rename r9status     spstatus
rename fl9resnew    resnew_flg
rename r9dresid     resid
rename *resptype*   resptype
rename *intvrage*   intvage
rename *marstat*    marstat
rename *hshldnum*   houshldsz
rename *lvngarrg*   lvngarrg
rename *placedesc*  resdesc
rename *placekind*  reskind
rename *retiresen*  retirhous
rename *sec8pubsn*  pubsnhous
rename *facdescr*   facdesc_fq
rename *osfacd*     osfacds_fq
rename *facarea*    facarea_fq
rename *osfaca*     osfacar_fq
rename *censdiv*    censdiv
rename *metnonmet*  metro
rename *mgapmedsp*  medigapcov
rename *covmedcad*  partdcov
rename *otdrugcov*  otdrugcov
rename *covtricar*  tricarcov
rename *medicaid*   medicaidcov
rename *totinc*     totalinc
rename *workfpay*   workpay
rename *wrkplstmn*  worklsmo
rename *mealskip1*  skipmeal
rename *mealskip2*  freqskipmeal
rename *shopwout*   skipgroc
rename *howpaygr5*  snpebt_flg
rename *progneed1*  snpebt
rename *bankwout*   nopaybill
rename *nopayhous*  nopayhous
rename *nopayutil*  nopayutil
rename *nopaymed*   nopaymed
rename *9varunit*   varunit
rename *9varstrat*  varstrat
rename *9anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc9disescn`i' disescn`i'
}

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
tot* work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R9_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 10
use "merged_rounds/R10.dta", clear
describe
count

g year = 2020
gen retire = lf10workfpay == 3

// rename variables with general names (non-round specific)
rename fl10spdied    spdied
rename r10status     spstatus
rename fl10resnew    resnew_flg
rename r10dresid     resid
rename *resptype*    resptype
rename *intvrage*    intvage
rename *marstat*     marstat
rename *hshldnum*    houshldsz
rename *lvngarrg*    lvngarrg
rename *placedesc*   resdesc
rename *placekind*   reskind
rename *retiresen*   retirhous
rename *sec8pubsn*   pubsnhous
rename *facdescr*    facdesc_fq
rename *osfacd*      osfacds_fq
rename *facarea*     facarea_fq
rename *osfaca*      osfacar_fq
rename *censdiv*     censdiv
rename *metnonmet*   metro
rename *mgapmedsp*   medigapcov
rename *covmedcad*   partdcov
rename *otdrugcov*   otdrugcov
rename *covtricar*   tricarcov
rename *medicaid*    medicaidcov
rename *workfpay*    workpay
rename *wrkplstmn*   worklsmo
rename *mealskip1*   skipmeal
rename *mealskip2*   freqskipmeal
rename *shopwout*    skipgroc
rename *howpaygr5*   snpebt_flg
rename *progneed1*   snpebt
rename *bankwout*    nopaybill
rename *nopayhous*   nopayhous
rename *nopayutil*   nopayutil
rename *nopaymed*    nopaymed
rename *10varunit*   varunit
rename *10varstrat*  varstrat
rename *10anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc10disescn`i' disescn`i'
}

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R10_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 11
use "merged_rounds/R11.dta", clear
describe
count

g year = 2021
gen retire = lf11workfpay == 3

// rename variables with general names (non-round specific)
rename fl11spdied    spdied
rename r11status     spstatus
rename fl11resnew    resnew_flg
rename r11dresid     resid
rename *resptype*    resptype
rename *intvrage*    intvage
rename *marstat*     marstat
rename *hshldnum*    houshldsz
rename *lvngarrg*    lvngarrg
rename *placedesc*   resdesc
rename *placekind*   reskind
rename *retiresen*   retirhous
rename *sec8pubsn*   pubsnhous
rename *facdescr*    facdesc_fq
rename *osfacd*      osfacds_fq
rename *facarea*     facarea_fq
rename *osfaca*      osfacar_fq
rename *censdiv*     censdiv
rename *metnonmet*   metro
rename *mgapmedsp*   medigapcov
rename *covmedcad*   partdcov
rename *otdrugcov*   otdrugcov
rename *covtricar*   tricarcov
rename *medicaid*    medicaidcov
rename *totinc*      totalinc
rename *workfpay*    workpay
rename *wrkplstmn*   worklsmo
rename *mealskip1*   skipmeal
rename *mealskip2*   freqskipmeal
rename *shopwout*    skipgroc
rename *howpaygr5*   snpebt_flg
rename *progneed1*   snpebt
rename *bankwout*    nopaybill
rename *nopayhous*   nopayhous
rename *nopayutil*   nopayutil
rename *nopaymed*    nopaymed
rename *11varunit*   varunit
rename *11varstrat*  varstrat
rename *11anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc11disescn`i' disescn`i'
}

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
tot* work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R11_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 12
use "merged_rounds/R12.dta", clear
describe
count

g year = 2022
gen retire = lf12workfpay == 3

// rename variables with general names (non-round specific)
rename r12dgender gender
rename *racehisp* race
rename *higstschl* entryed
rename fl12spdied    spdied
rename r12status     spstatus
rename fl12resnew    resnew_flg
rename r12dresid     resid
rename *resptype*    resptype
rename *intvrage*    intvage
rename *marstat*     marstat
rename *hshldnum*    houshldsz
rename *lvngarrg*    lvngarrg
rename *placedesc*   resdesc
rename *placekind*   reskind
rename *retiresen*   retirhous
rename *sec8pubsn*   pubsnhous
rename *facdescr*    facdesc_fq
rename *osfacd*      osfacds_fq
rename *facarea*     facarea_fq
rename *osfaca*      osfacar_fq
rename *censdiv*     censdiv
rename *metnonmet*   metro
rename *mgapmedsp*   medigapcov
rename *covmedcad*   partdcov
rename *otdrugcov*   otdrugcov
rename *covtricar*   tricarcov
rename *medicaid*    medicaidcov
rename *totinc*      totalinc
rename *workfpay*    workpay
rename *wrkplstmn*   worklsmo
rename *mealskip1*   skipmeal
rename *mealskip2*   freqskipmeal
rename *shopwout*    skipgroc
rename *howpaygr5*   snpebt_flg
rename *progneed1*   snpebt
rename *bankwout*    nopaybill
rename *nopayhous*   nopayhous
rename *nopayutil*   nopayutil
rename *nopaymed*    nopaymed
rename *12varunit*   varunit
rename *12varstrat*  varstrat
rename *12anfinwgt0* anfinwgt0

forvalues i = 1/10 {
    rename hc12disescn`i' disescn`i'
}

// label and define new cohort indicator variable
label var r12dcontnew "Suvery Entry Round"
label val r12dcontnew r12new
label def r12new ///
1 "R1/R5" ///
2 "R12"

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode race         (4=3) (3=4) (5 6=5)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
gender race entryed r12dcontnew ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
tot* work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R12_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 13
use "merged_rounds/R13.dta", clear
describe
count

g year = 2023
gen retire = lf13workfpay == 3

// rename variables with general names (non-round specific)
rename r13dgender      gender
rename *racehisp*      race
rename *higstschl*     entryed
rename fl13spdied      spdied
rename r13status       spstatus
rename fl13resnew      resnew_flg
rename r13dresid       resid
rename *resptype*      resptype
rename *intvrage*      intvage
rename *marstat*       marstat
rename *hshldnum*      houshldsz
rename *lvngarrg*      lvngarrg
rename *placedesc*     resdesc
rename *placekind*     reskind
rename *retiresen*     retirhous
rename *sec8pubsn*     pubsnhous
rename *facdescr*      facdesc_fq
rename *osfacd*        osfacds_fq
rename *facarea*       facarea_fq
rename *osfaca*        osfacar_fq
rename *censdiv*       censdiv
rename r13dmetnonmet   metro
rename *mgapmedsp*     medigapcov
rename *covmedcad*     partdcov
rename *otdrugcov*     otdrugcov
rename *covtricar*     tricarcov
rename *medicaid*      medicaidcov
rename *totinc*        totalinc
rename *workfpay*      workpay
rename *wrkplstmn*     worklsmo
rename *mealskip1*     skipmeal
rename *mealskip2*     freqskipmeal
rename *shopwout*      skipgroc
rename *howpaygr5*     snpebt_flg
rename *progneed1*     snpebt
rename *bankwout*      nopaybill
rename *nopayhous*     nopayhous
rename *nopayutil*     nopayutil
rename *nopaymed*      nopaymed
rename *13varunit*     varunit
rename *13varstrat*    varstrat
rename *13anfinwgt0*   anfinwgt0

forvalues i = 1/10 {
    rename hc13disescn`i' disescn`i'
}

// label and define new cohort indicator variable
label var r13dcontnew "Suvery Entry Round"
label val r13dcontnew r13new
label def r13new ///
1 "R1/R5/R12" ///
2 "R13"

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode race         (4=3) (3=4) (5 6=5)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
gender race entryed r13dcontnew ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
tot* work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R13_clean.dta", replace

/*--------------------------------------------------------------------------*/

*---------ROUND 14
use "merged_rounds/R14.dta", clear
describe
count

g year = 2024
gen retire = lf14workfpay == 3

// rename variables with general names (non-round specific)
rename fl14spdied      spdied
rename r14status       spstatus
rename fl14resnew      resnew_flg
rename r14dresid       resid
rename *resptype*      resptype
rename *intvrage*      intvage
rename *marstat*       marstat
rename *hshldnum*      houshldsz
rename *lvngarrg*      lvngarrg
rename *placedesc*     resdesc
rename *placekind*     reskind
rename *retiresen*     retirhous
rename *sec8pubsn*     pubsnhous
rename *facdescr*      facdesc_fq
rename *osfacd*        osfacds_fq
rename *facarea*       facarea_fq
rename *osfaca*        osfacar_fq
rename *censdiv*       censdiv
rename r14dmetnonmet   metro
rename *mgapmedsp*     medigapcov
rename *covmedcad*     partdcov
rename *otdrugcov*     otdrugcov
rename *covtricar*     tricarcov
rename *medicaid*      medicaidcov
rename *totinc*        totalinc
rename *workfpay*      workpay
rename *wrkplstmn*     worklsmo
rename *mealskip1*     skipmeal
rename *mealskip2*     freqskipmeal
rename *shopwout*      skipgroc
rename *howpaygr5*     snpebt_flg
rename *progneed1*     snpebt
rename *bankwout*      nopaybill
rename *nopayhous*     nopayhous
rename *nopayutil*     nopayutil
rename *nopaymed*      nopaymed
rename *14varunit*     varunit
rename *14varstrat*    varstrat
rename *14anfinwgt0*   anfinwgt0

forvalues i = 1/10 {
    rename hc14disescn`i' disescn`i'
}

// keep only living respondents
recode spdied (-1=0)
keep if spdied == 0

// recode necessary variables
foreach var of varlist _all {
    capture recode `var' (min/-1 = .)
}

global B *hous* *cov* worklsmo skipgroc skipmeal snpebt* nopay* metro disescn* resnew_flg
recode $B (2 .=0)

recode houshldsz    (0=.)
recode lvngarrg     (4=3) (3=4)
recode resid 	    (2 3 7=2) (4 5 8=3)
recode resdesc 	    (91=5) 
recode reskind      (3=2) (5=3) (91=6)
recode facdesc_fq   (91=9)
recode facarea_fq   (91=5)
recode workpay      (2 3 .=0) 
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)

// keep only variables of interest
keep ///
sp* year* intv* mar* lvn* res* *hous* *_fq* cen* met* dis* *cov* ///
tot* work* reti* *skip* snp* nopay* var* anfinwgt0
sort spid
describe
count
save "clean_rounds/R14_clean.dta", replace


/*============================================================================
				3: Append Rounds 1-14
============================================================================*/
use "clean_rounds/R1_clean.dta", clear
gen round = 1
label var round "Survey Round"

append using "clean_rounds/R2_clean.dta"
replace round = 2 if round == .

append using "clean_rounds/R3_clean.dta"
replace round = 3 if round == .

append using "clean_rounds/R4_clean.dta"
replace round = 4 if round == .

append using "clean_rounds/R5_clean.dta"
replace round = 5 if round == .

append using "clean_rounds/R6_clean.dta"
replace round = 6 if round == .

append using "clean_rounds/R7_clean.dta"
replace round = 7 if round == .

append using "clean_rounds/R8_clean.dta"
replace round = 8 if round == .

append using "clean_rounds/R9_clean.dta"
replace round = 9 if round == .

append using "clean_rounds/R10_clean.dta"
replace round = 10 if round == .

append using "clean_rounds/R11_clean.dta"
replace round = 11 if round == .

append using "clean_rounds/R12_clean.dta"
replace round = 12 if round == .
replace cohort = 3 if r12dcontnew == 2

append using "clean_rounds/R13_clean.dta"
replace round = 13 if round == .
replace cohort = 4 if r13dcontnew == 2

append using "clean_rounds/R14_clean.dta"
replace round = 14 if round == .

count
tab round
tab cohort

sort spid round
xtset spid round
xtdes
xtsum spid

duplicates report spid round
duplicates tag spid round, gen(dup_flag)
tab dup_flag

save "combined_R1-R14_rv.dta", replace


/*============================================================================
				4: Prep Appended Data for Analysis
============================================================================*/

/*----------------------------------------------------------------------------
		      4.1: All Variables
----------------------------------------------------------------------------*/

* COHORT *
tab cohort
global C i.cohort

/*--------------------------------------------------------------------------*/

* SURVEY YEAR *
tab year, gen(y)
label var y1 "2011"
label var y2 "2012"
label var y3 "2013"
label var y4 "2014"
label var y5 "2015"
label var y6 "2016"
label var y7 "2017"
label var y8 "2018"
label var y9 "2019"
label var y10 "2020"
label var y11 "2021"
label var y12 "2022"
label var y13 "2023"
label var y14 "2024"
tab1 y*
tab year

global Y  y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14
global YX y1 y2 y3 y4 y5 y6 y7 y8 y9     y11 y12 y13 y14

/*--------------------------------------------------------------------------*/

* DECEASED CASES *
tab round spdied, m

/*--------------------------------------------------------------------------*/

* CASE STATUS *
tab spstatus, m

g complete = inlist(spstatus,60,63)
label var complete "Survey Completed"
tab round complete

bysort spid: egen ever_complete = max(complete)
label var ever_complete "Ever Completed a Survey Round"

bysort spid: egen always_incomplete = min(complete)
label var always_incomplete "Completed Survey Every Round"

tab ever_complete always_incomplete
drop if ever_complete == 0

bysort round: tab complete ever_complete, m

/*--------------------------------------------------------------------------*/

* RESPONDENT TYPE *
tab resptype, m

g proxy_flg = resptype == 2
label var proxy_flg "Proxy Respondent Flag"
tab round proxy_flg

/*--------------------------------------------------------------------------*/

* GENDER *
tab round gender, m

bysort spid (round): replace gender = gender[_n-1] if gender == .
tab round gender, m

g female = gender == 2
label var female "Female"

/*--------------------------------------------------------------------------*/

* RACE/ETHNICITY *
tab round race, m

bysort spid (round): replace race = race[_n-1] if race == .
tab round race, m

g white    = race == 1
g black    = race == 2
g hispanic = race == 3
g otherrc  = inlist(race,4,5)

label var white    "Non-Hispanic White"
label var black    "Non-Hispanic Black"
label var hispanic "Hispanic"
label var otherrc  "Other Race(s)"

global R  white black hispanic otherrc multirc
global RX white black hispanic otherrc

/*--------------------------------------------------------------------------*/

* EDUCATION *
tab round entryed, m

bysort spid (round): replace entryed = entryed[_n-1] if entryed == .
recode entryed (.=10)
tab round entryed, m

recode entryed (1/3=1) (4/6=2) (7/8=3) (9=4) (10=5), gen(educ)
label var educ "Educational Attainment Recode"
label val educ educ
label def educ ///
1 "Some High School or Lower" ///
2 "High School Diploma" ///
3 "College Degree" ///
4 "Professional Degree" ///
5 "N/A"
tab educ, m

g hsdrop  = educ == 1
g hsgrad  = educ == 2
g coldeg  = educ == 3
g profdeg = educ == 4

label var hsdrop  "High School or Lower"
label var hsgrad  "High School Graduate"
label var coldeg  "College Graduate"
label var profdeg "Professional Degree"

global E  hsdrop hsgrad coldeg profdeg
global EX hsdrop hsgrad coldeg

/*--------------------------------------------------------------------------*/

* AGE *
tab intvage, m

g under70 = intvage == 1
g under75 = intvage == 2
g under80 = intvage == 3
g under85 = intvage == 4
g under90 = intvage == 5
g over90  = intvage == 6

label var under70 "Age 65-69"
label var under75 "Age 70-74"
label var under80 "Age 75-79"
label var under85 "Age 80-84"
label var under90 "Age 85-89"
label var over90  "Age 90+"

global IA  under70 under75 under80 under85 under90 over90
global IAX under70 under75 under80 under85 under90

/*--------------------------------------------------------------------------*/

* MARITAL STATUS *
tab marstat, m

recode marstat (.=7)
tab marstat, m

g married = marstat == 1
label var married "Married"

/*--------------------------------------------------------------------------*/

* LIVING ARRANGEMENT *
tab lvngarrg, m

recode lvngarrg (.=5)
tab lvngarrg, m

g lvalone = lvngarrg == 1
label var lvalone "Lives Alone"

/*--------------------------------------------------------------------------*/

* CENSUS  DIVISION *
tab round censdiv, m

g neweng   = censdiv == 1
g mid_atl  = censdiv == 2
g s_atl    = censdiv == 3
g ne_mdwst = censdiv == 4
g nw_mdwst = censdiv == 5
g se_cntrl = censdiv == 6
g sw_cntrl = censdiv == 7
g wstmtn   = censdiv == 8
g pacific  = censdiv == 9

label var neweng   "New England"
label var mid_atl  "Mid Atlantic"
label var s_atl    "South Atlantic"
label var ne_mdwst "Northeast Midwest"
label var nw_mdwst "Northwest Midwest"
label var se_cntrl "Southeast Central"
label var sw_cntrl "Southwest Central"
label var wstmtn   "West Mountain"
label var pacific  "West Pacific"

global D   neweng mid_atl s_atl ne_mdwst nw_mdwst se_cntrl sw_cntrl wstmtn pacific
global DX  neweng mid_atl s_atl ne_mdwst nw_mdwst		   sw_cntrl wstmtn pacific

/*--------------------------------------------------------------------------*/

* METROPOLITAN RESIDENCE STATUS *
tab round metro, m

/*--------------------------------------------------------------------------*/

* RESIDENCE TYPE *
tab resid, m

tab round resdesc, m
tab round reskind, m
tab round retirhous, m
tab round pubsnhous, m
tab round facdesc_fq, m
tab round osfacds_fq, m
tab round facarea_fq, m
tab round osfacar_fq, m


// living facilities/institutions
g rescrhm_fq = (inlist(facdesc_fq,5,6,7) | inlist(osfacds_fq,5,6,7))
g rescarehm  =  resid == 2 & (resdesc == 2 | rescrhm_fq)
label var rescarehm "Residential Care Home"

g nursehm_sp =  inlist(reskind,3,4)
g nursehm_fq = (inlist(facdesc_fq,1,3) | inlist(osfacds_fq,1,3) | ///
			    inlist(facarea_fq,3,4) | inlist(osfacar_fq,3,4))
g nursinghm  =  resid == 3 & (nursehm_sp | nursehm_fq)
label var nursinghm "Nursing or Special Care Home"

g asstlvng_sp = (resdesc == 3 | reskind == 2)
g asstlvng_fq = (facdesc_fq == 2 | osfacds_fq == 2 | ///
				 facarea_fq == 2 | osfacar_fq == 2)
g asstlvng    = (asstlvng_sp | asstlvng_fq)
label var asstlvng "Assisted Living"

g religsqrtrs = resdesc == 4
label var religsqrtrs "Religious Group Quarters"


// community/independent living
g privres_sp = (resdesc == 1 | reskind == 1)
g privres_fq = (facarea_fq == 1 | osfacar_fq == 1 | ///
				inlist(osfacds_fq,9,11))
g privres    =  resid == 1 & (privres_sp | privres_fq)
label var privres "Private Residence"

g senhous_fq = (facdesc_fq == 8 | osfacds_fq == 8)
g seniorhous =  resid == 1 & (retirhous == 1 | senhous_fq == 1)
label var seniorhous "Retirement Community"

g indpdntlv = (resid == 1 | privres == 1 | pubsnhous == 1 | seniorhous == 1)
label var indpdntlv "Independent Living"
tab indpdntlv, m
tab round indpdntlv

/*--------------------------------------------------------------------------*/

* HEALTH CONDITIONS *
foreach var of varlist disescn1-disescn10 {
    tab `var'
}

local hlthcond " disescn1 disescn2 disescn3 disescn4 disescn5 disescn6 disescn7 disescn8 disescn9 disescn10 "

// generate health condition variable
gen hlthcondev = (disescn1 == 1 | disescn2 == 1 | disescn3 == 1 | ///
                  disescn4 == 1 | disescn5 == 1 | disescn6 == 1 | ///
                  disescn7 == 1 | disescn8 == 1 | disescn9 == 1 | ///
                  disescn10 == 1)
label var hlthcondev "Have Health Condition(s)"
tab hlthcondev 

// count health conditions
gen numhlthcond = (disescn1 + disescn2 + disescn3 + disescn4 + disescn5 + ///
                   disescn6 + disescn7 + disescn8 + disescn9 + disescn10)
label var numhlthcond "Number of Health Conditions Across Sample"
sum numhlthcond
tab numhlthcond

egen meanhlthcondev = mean(hlthcondev)
tab meanhlthcondev

// check total and average nums of health conditions
local total_count = 0
local num_vars = 10
foreach var of varlist disescn1-disescn10 {
    count if `var' == 1
    local total_count = `total_count' + r(N)
    display "`var': `r(N)' observations have this condition"
}

local avghlthcond = `total_count' / `num_vars'
display "Total conditions across sample: `total_count'"
display "Average observations per condition: `avghlthcond'"

/*--------------------------------------------------------------------------*/

* RETIREMENT/EMPLOYMENT STATUS *
tab round retire, m
tab round workpay, m
tab round worklsmo, m

g work4pay = (workpay == 1 | worklsmo == 1)
label var work4pay "Worked Recently"
tab work4pay, m

/*--------------------------------------------------------------------------*/

* INCOME *
tab round if totalinc != .
tab totalinc

/*--------------------------------------------------------------------------*/

* FPL & POVERTY TO INCOME RATIO (PIR) *
*// note: calcualted using annual HHS Poverty Guidelines

g fpl_threshold = .

*----------2011:
replace fpl_threshold = 10890 if year == 2011 & houshldsz == 1
replace fpl_threshold = 14710 if year == 2011 & houshldsz == 2
replace fpl_threshold = 18530 if year == 2011 & houshldsz == 3
replace fpl_threshold = 22350 if year == 2011 & houshldsz == 4
replace fpl_threshold = 26170 if year == 2011 & houshldsz == 5
replace fpl_threshold = 29990 if year == 2011 & houshldsz == 6
replace fpl_threshold = 33810 if year == 2011 & houshldsz == 7
replace fpl_threshold = 37630 if year == 2011 & houshldsz == 8
* for households over 8, add 3820 for each additional person
replace fpl_threshold = 41450 if year == 2011 & houshldsz == 9
replace fpl_threshold = 45270 if year == 2011 & houshldsz == 10
replace fpl_threshold = 49090 if year == 2011 & houshldsz == 11
replace fpl_threshold = 52910 if year == 2011 & houshldsz == 12
replace fpl_threshold = 56730 if year == 2011 & houshldsz == 13
replace fpl_threshold = 60550 if year == 2011 & houshldsz == 14

*----------2013:
replace fpl_threshold = 11490 if year == 2013 & houshldsz == 1
replace fpl_threshold = 15510 if year == 2013 & houshldsz == 2
replace fpl_threshold = 19530 if year == 2013 & houshldsz == 3
replace fpl_threshold = 23550 if year == 2013 & houshldsz == 4
replace fpl_threshold = 27570 if year == 2013 & houshldsz == 5
replace fpl_threshold = 31590 if year == 2013 & houshldsz == 6
replace fpl_threshold = 35610 if year == 2013 & houshldsz == 7
replace fpl_threshold = 39630 if year == 2013 & houshldsz == 8
* for households over 8, add 4020 for each additional person
replace fpl_threshold = 43650 if year == 2013 & houshldsz == 9
replace fpl_threshold = 47670 if year == 2013 & houshldsz == 10
replace fpl_threshold = 51690 if year == 2013 & houshldsz == 11
replace fpl_threshold = 55710 if year == 2013 & houshldsz == 12
replace fpl_threshold = 59730 if year == 2013 & houshldsz == 13
replace fpl_threshold = 63750 if year == 2013 & houshldsz == 14

*----------2015:
replace fpl_threshold = 11770 if year == 2015 & houshldsz == 1
replace fpl_threshold = 15930 if year == 2015 & houshldsz == 2
replace fpl_threshold = 20090 if year == 2015 & houshldsz == 3
replace fpl_threshold = 24250 if year == 2015 & houshldsz == 4
replace fpl_threshold = 28410 if year == 2015 & houshldsz == 5
replace fpl_threshold = 32570 if year == 2015 & houshldsz == 6
replace fpl_threshold = 36730 if year == 2015 & houshldsz == 7
replace fpl_threshold = 40890 if year == 2015 & houshldsz == 8
* for households over 8, add 4160 for each additional person
replace fpl_threshold = 45050 if year == 2015 & houshldsz == 9
replace fpl_threshold = 49210 if year == 2015 & houshldsz == 10
replace fpl_threshold = 53370 if year == 2015 & houshldsz == 11
replace fpl_threshold = 57530 if year == 2015 & houshldsz == 12
replace fpl_threshold = 61690 if year == 2015 & houshldsz == 13
replace fpl_threshold = 65850 if year == 2015 & houshldsz == 14

*----------2017:
replace fpl_threshold = 12060 if year == 2017 & houshldsz == 1
replace fpl_threshold = 16240 if year == 2017 & houshldsz == 2
replace fpl_threshold = 20420 if year == 2017 & houshldsz == 3
replace fpl_threshold = 24600 if year == 2017 & houshldsz == 4
replace fpl_threshold = 28780 if year == 2017 & houshldsz == 5
replace fpl_threshold = 32960 if year == 2017 & houshldsz == 6
replace fpl_threshold = 37140 if year == 2017 & houshldsz == 7
replace fpl_threshold = 41320 if year == 2017 & houshldsz == 8
* for households over 8, add 4180 for each additional person
replace fpl_threshold = 45500 if year == 2017 & houshldsz == 9
replace fpl_threshold = 49680 if year == 2017 & houshldsz == 10
replace fpl_threshold = 53860 if year == 2017 & houshldsz == 11
replace fpl_threshold = 58040 if year == 2017 & houshldsz == 12
replace fpl_threshold = 62220 if year == 2017 & houshldsz == 13
replace fpl_threshold = 66400 if year == 2017 & houshldsz == 14

*-------------2019:
replace fpl_threshold = 12490 if year == 2019 & houshldsz == 1
replace fpl_threshold = 16910 if year == 2019 & houshldsz == 2
replace fpl_threshold = 21330 if year == 2019 & houshldsz == 3
replace fpl_threshold = 25750 if year == 2019 & houshldsz == 4
replace fpl_threshold = 30170 if year == 2019 & houshldsz == 5
replace fpl_threshold = 34590 if year == 2019 & houshldsz == 6
replace fpl_threshold = 39010 if year == 2019 & houshldsz == 7
replace fpl_threshold = 43430 if year == 2019 & houshldsz == 8
* for households over 8, add 4420 for each additional person
replace fpl_threshold = 47850 if year == 2019 & houshldsz == 9
replace fpl_threshold = 52270 if year == 2019 & houshldsz == 10
replace fpl_threshold = 56690 if year == 2019 & houshldsz == 11
replace fpl_threshold = 61110 if year == 2019 & houshldsz == 12
replace fpl_threshold = 65530 if year == 2019 & houshldsz == 13
replace fpl_threshold = 69950 if year == 2019 & houshldsz == 14

*----------2021:
replace fpl_threshold = 12880 if year == 2021 & houshldsz == 1
replace fpl_threshold = 17420 if year == 2021 & houshldsz == 2
replace fpl_threshold = 21960 if year == 2021 & houshldsz == 3
replace fpl_threshold = 26500 if year == 2021 & houshldsz == 4
replace fpl_threshold = 31040 if year == 2021 & houshldsz == 5
replace fpl_threshold = 35580 if year == 2021 & houshldsz == 6
replace fpl_threshold = 40120 if year == 2021 & houshldsz == 7
replace fpl_threshold = 44660 if year == 2021 & houshldsz == 8
* for households over 8, add 4540 for each additional person
replace fpl_threshold = 49200 if year == 2021 & houshldsz == 9
replace fpl_threshold = 53740 if year == 2021 & houshldsz == 10
replace fpl_threshold = 58280 if year == 2021 & houshldsz == 11
replace fpl_threshold = 62820 if year == 2021 & houshldsz == 12
replace fpl_threshold = 67360 if year == 2021 & houshldsz == 13
replace fpl_threshold = 71900 if year == 2021 & houshldsz == 14

*----------2022:
replace fpl_threshold = 13590 if year == 2022 & houshldsz == 1
replace fpl_threshold = 18310 if year == 2022 & houshldsz == 2
replace fpl_threshold = 23030 if year == 2022 & houshldsz == 3
replace fpl_threshold = 27750 if year == 2022 & houshldsz == 4
replace fpl_threshold = 32470 if year == 2022 & houshldsz == 5
replace fpl_threshold = 37190 if year == 2022 & houshldsz == 6
replace fpl_threshold = 41910 if year == 2022 & houshldsz == 7
replace fpl_threshold = 46630 if year == 2022 & houshldsz == 8
* for households over 8, add 4720 for each additional person
replace fpl_threshold = 51350 if year == 2022 & houshldsz == 9
replace fpl_threshold = 56070 if year == 2022 & houshldsz == 10
replace fpl_threshold = 60790 if year == 2022 & houshldsz == 11
replace fpl_threshold = 65510 if year == 2022 & houshldsz == 12
replace fpl_threshold = 70230 if year == 2022 & houshldsz == 13
replace fpl_threshold = 74950 if year == 2022 & houshldsz == 14

*----------2023:
replace fpl_threshold = 14580 if year == 2023 & houshldsz == 1
replace fpl_threshold = 19720 if year == 2023 & houshldsz == 2
replace fpl_threshold = 24860 if year == 2023 & houshldsz == 3
replace fpl_threshold = 30000 if year == 2023 & houshldsz == 4
replace fpl_threshold = 35140 if year == 2023 & houshldsz == 5
replace fpl_threshold = 40280 if year == 2023 & houshldsz == 6
replace fpl_threshold = 45420 if year == 2023 & houshldsz == 7
replace fpl_threshold = 50560 if year == 2023 & houshldsz == 8
* for households over 8, add 5140 for each additional person
replace fpl_threshold = 55700 if year == 2023 & houshldsz == 9
replace fpl_threshold = 60840 if year == 2023 & houshldsz == 10
replace fpl_threshold = 65980 if year == 2023 & houshldsz == 11
replace fpl_threshold = 71120 if year == 2023 & houshldsz == 12
replace fpl_threshold = 76260 if year == 2023 & houshldsz == 13
replace fpl_threshold = 81400 if year == 2023 & houshldsz == 14

*----------2024:
replace fpl_threshold = 15060 if year == 2024 & houshldsz == 1
replace fpl_threshold = 20440 if year == 2024 & houshldsz == 2
replace fpl_threshold = 25820 if year == 2024 & houshldsz == 3
replace fpl_threshold = 31200 if year == 2024 & houshldsz == 4
replace fpl_threshold = 36580 if year == 2024 & houshldsz == 5
replace fpl_threshold = 41960 if year == 2024 & houshldsz == 6
replace fpl_threshold = 47340 if year == 2024 & houshldsz == 7
replace fpl_threshold = 52720 if year == 2024 & houshldsz == 8
* for households over 8, add 5380 for each additional person
replace fpl_threshold = 58100 if year == 2024 & houshldsz == 9
replace fpl_threshold = 63480 if year == 2024 & houshldsz == 10
replace fpl_threshold = 68860 if year == 2024 & houshldsz == 11
replace fpl_threshold = 74240 if year == 2024 & houshldsz == 12
replace fpl_threshold = 79620 if year == 2024 & houshldsz == 13
replace fpl_threshold = 85000 if year == 2024 & houshldsz == 14

// generate FPL ratio and percentage variables
g fpl_ratio   = (totalinc / fpl_threshold)
g fpl_percent = (totalinc / fpl_threshold) * 100

label var fpl_ratio   "Ratio of Federal Poverty Line"
label var fpl_percent "Percentage of Federal Poverty Line"

/*--------------------------------------------------------------------------*/

* LOG INCOME *
recode totalinc (min/0=.), gen(income)
replace income=income/1000
label var income "Income (000)"
gen lninc=log(income)
la var lninc "Log Income"

/*--------------------------------------------------------------------------*/

* FOOD ASSISTANCE *
tab round snpebt, m
tab round snpebt_flg, m

g foodstamps = (snpebt == 1 | snpebt_flg == 1)
label var foodstamps "Food Stamp Recipient"
tab foodstamps, m


/*----------------------------------------------------------------------------
		      4.2: Outcome Variables
----------------------------------------------------------------------------*/
* FOOD HARDSHIP *
tab round skipgroc, m
tab round skipmeal, m
tab round skipmeal, m
tab round freqskipmeal, m

g hi_freqskipmeal = inlist(freqskipmeal,2,3,4)
label var hi_freqskipmeal "Frequently Skips Meals"

g fhscore = skipgroc+skipmeal+hi_freqskipmeal
label var fhscore "Total Food Hardships"
tab fhscore

g foodhardshp = fhscore >= 1
label var foodhardshp "Severe Food Hardship"
tab foodhardshp

/*--------------------------------------------------------------------------*/

* FINANCIAL HARDSHIPS *
tab round nopaybill, m
tab round nopayhous, m
tab round nopayutil, m

g numfhardshp = nopaybill+nopayhous+nopayutil
label var numfhardshp "Total Financial Hardships"
tab numfhardshp

g finhardshp = numfhardshp >= 1
label var finhardshp "Financial Hardship"
tab finhardshp

/*--------------------------------------------------------------------------*/

* MEDICAL HARDSHIPS *
tab nopaymed, m


/*----------------------------------------------------------------------------
		      4.3: Treatment Variables
----------------------------------------------------------------------------*/

* MEDICARE COVERAGE *
tab round partdcov, m
tab round otdrugcov, m
tab round tricarcov, m
tab round medigapcov, m

g othinscov = medigapcov == 0
label var othinscov "Non-Medigap Supplement"

global MC medigapcov othinscov


g mcpts = .
replace mcpts = 1 if medigapcov == 1
replace mcpts = 2 if partdcov == 1
replace mcpts = 3 if otdrugcov == 1
replace mcpts = 4 if othinscov == 1
replace mcpts = 5 if tricarcov == 1
label var mcpts "Categorical Health Care Coverage Type"
label val mcpts mcpts
label define mcpts ///
1 "Medigap" ///
2 "Medicare Part D" ///
3 "Other Drug Coverage" ///
4 "Other, Non-Medigap" ///
5 "TRICARE"
tab mcpts, m

tab round medicaidcov, m
drop if medicaidcov == 1

/*--------------------------------------------------------------------------*/

save "clean_R1-R14_rv.dta", replace

/*--------------------------------------------------------------------------*/


/*============================================================================
				5: Data Analysis
============================================================================*/
keep if complete == 1

macro list
global X $IA married lvalone metro work4pay lninc hlthcondev
global Z married lninc hlthcondev


/*--------------------------------------------------------------------------
			  5.1: Table 3
--------------------------------------------------------------------------*/
est clear

// cols 1,2,3 - All Respondents
eststo est1: xtreg foodhardshp medigapcov $YX $Z if indpdntlv == 1 , fe
estadd ysumm
eststo est2: xtreg finhardshp medigapcov $YX $Z if indpdntlv == 1 , fe
estadd ysumm
eststo est3: xtreg nopaymed medigapcov $YX $Z if indpdntlv == 1 , fe
estadd ysumm
estimates store all

// cols 4,5,6 - Conditional on Female Respondents
eststo est4: xtreg foodhardshp medigapcov $YX $Z if indpdntlv == 1 & female == 1 , fe
estadd ysumm
eststo est5: xtreg finhardshp medigapcov $YX $Z if indpdntlv == 1 & female == 1 , fe
estadd ysumm
eststo est6: xtreg nopaymed medigapcov $YX $Z if indpdntlv == 1 & female == 1 , fe
estadd ysumm
estimates store female

// cols 7,8,9 - Conditional on Non-White Respondents
eststo est7: xtreg foodhardshp medigapcov $YX $Z if indpdntlv == 1 & white == 0 , fe
estadd ysumm
eststo est8: xtreg finhardshp medigapcov $YX $Z if indpdntlv == 1 & white == 0 , fe
estadd ysumm
eststo est9: xtreg nopaymed medigapcov $YX $Z if indpdntlv == 1 & white == 0 , fe
estadd ysumm
estimates store nonwhite

// cols 10,11,12 - Conditional on Rural Respondents
eststo est10: xtreg foodhardshp medigapcov $YX $Z if indpdntlv == 1 & metro == 0 , fe
estadd ysumm
eststo est11: xtreg finhardshp medigapcov $YX $Z if indpdntlv == 1 & metro == 0 , fe
estadd ysumm
eststo est12: xtreg nopaymed medigapcov $YX $Z if indpdntlv == 1 & metro == 0 , fe
estadd ysumm
estimates store rural

esttab est1 est2 est3 est4 est5 est6 est7 est8 est9 est10 est11 est12 ///
using table3_nhats_rv.rtf, b(3) se(3) replace star(* 0.10 ** 0.05 *** 0.01) ///
label ar2 compress nogaps indicate("Year FE = y*") ///
mtitles("Food Hardship" "Financial Hardship" "Medical Hardship") ///
mgroups("All" "Female Only" "Non-White Only" "Rural Only", ///
pattern(1 0 0 1 0 0 1 0 0 1 0 0)) ///
stats(N ymean ysd r2, labels("Observations" "Y Mean" "Y Std" "R-squared")) ///
addnote("NHATS 2011-2024.")
 

/*--------------------------------------------------------------------------
			  5.2: Figure 3
--------------------------------------------------------------------------*/
coefplot est1 est2 est3, bylabel(All) ///
	|| est4 est5 est6, bylabel(Woman) ///
	|| est7 est8 est9, bylabel(Non-White) ///
	|| est10 est11 est12, bylabel(Rural) ///
	|| , plotlabels ("Food Hardship" "Financial Hardship" "Medical Hardship") ///
    xline(0) ///
	keep(*medigapcov*) ///
	coeflabels(,labsize(vsmall))
graph export "fig3.png", as(png) name("Graph") replace


/*============================================================================
				6: Supplementary Data
============================================================================*/
est clear

// Medicare Coverage by Year
foreach num of numlist 2011/2024 {
    estpost tabstat $MC if year == `num' , statistics(mean) columns(statistics)
    eststo est`num'
}

esttab * using nhats_mccov_rv.rtf, cells(mean(fmt(%9.3fc) ///
label(mean)) ) compress unstack /// 
mtitles("2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" "2020" "2021" "2022" "2023" "2024") ///
label replace nogaps title("Table 1: Medicare Coverage by Year") ///
addnote("NHATS 2011-2024.")

/*--------------------------------------------------------------------------*/

est clear

// Demographic Summary Statistics (mean) by Medicare Coverage, 2011 Cohort
foreach var of varlist $MC {
    estpost tabstat $IA $RX $E female married lvalone metro work4pay lninc foodstamps if `var' == 1 & cohort == 1, 	  statistics(mean) columns(statistics)
    eststo est_`var'
}

esttab * using nhats_demsumstats_rv.rtf, cells(mean(fmt(%9.3fc) ///
label(mean))) compress unstack ///
mtitles("Medigap" "Other Coverage") ///
label replace nogaps title("Table 2: Demographic Summary Statistics by Medicare Coverage, 2011 Cohort") ///
addnote("NHATS 2011.")

est clear

/*--------------------------------------------------------------------------*/

cap log close
clear all
