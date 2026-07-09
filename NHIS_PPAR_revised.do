/*=========================================================================
* Project:			Medicare Coverage, Financial Hardship, and 
					Inequalities in Older Adult Wellbeing
* Author: 		    J. Auth
* Datasets: 	    NHIS 2019-2024 Sample Adult Data Files
* Dependencies:     Institute for Research on Poverty
---------------------------------------------------------------------------
Creation Date:		2/20/2025
Modification Date:  06/08/2026
Do-file version:	3
Note:			    This do file has been changed since PPAR submission
					on 6/1/2026 the unedited version of the PPAR do file	
					can be found in GitHub. The data used in this version
					has not changed since PPAR submission on 06/01/2026. 
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

log using "PPAR Manuscript/NHIS_PPAR_rv", replace


/*==========================================================================
				1: Append 2019-2024 Data Files
==========================================================================*/
cd "~/Library/CloudStorage/Box-Box/Medigap_Food/NHIS/Data"

use "raw/samadult19.dta"
append using "raw/samadult20.dta"
append using "raw/samadult21.dta"
append using "raw/samadult22.dta"
append using "raw/samadult23.dta", force
append using "raw/samadult24.dta", force

count


/*============================================================================
				2: Prep Appended Data for Analysis
============================================================================*/

// restrict sample to adults aged 65+
rename agep_a age
keep if age >= 65

// drop refused and incomplete observations
drop if inlist(age,97,98,99)

count
save "nhis2019-24.dta", replace


/*----------------------------------------------------------------------------
		      2.1: All Variables
----------------------------------------------------------------------------*/

* SURVEY YEAR *
rename srvy_yr year
tab  year, gen(y)
tab1 y*

global T  y1 y2 y3 y4 y5 y6
global TX y1    y3 y4 y5 y6

/*--------------------------------------------------------------------------*/

* SEX *
tab sex_a, m

gen female = sex_a == 2
label var female "Female"

/*--------------------------------------------------------------------------*/

* RACE/ETHNICITY *
tab year hisp_a, m
tab year raceallp_a, m

// generate recoded race dummies
gen hispanic = (hisp_a == 1)
gen white    = (raceallp_a == 1 & hisp_a == 2)
gen black    = (raceallp_a == 2 & hisp_a == 2)
gen asian    = (raceallp_a == 3 & hisp_a == 2)
gen other_r  = (raceallp_a >= 6 & hisp_a == 2)

label var hispanic "Hispanic"
label var white    "Non-Hispanic White"
label var black    "Non-Hispanic Black"
label var asian	   "Non-Hispanic Asian"
label var other_r  "Other Race(s)"

global R  white black asian hispanic other_r
global RX white black asian hispanic

/*--------------------------------------------------------------------------*/

* EDUCATION *
tab year educp_a, m
tab year educ_a, m

// recode categorical education level var for the full sample
gen educ = .
replace educ = educp_a if year>2020
replace educ = educ_a  if year<2021
recode  educ (0/2=1) (3/5=3) (6/8=4) (9/11=5) (97/max=99)

label var educ "Education Level Recode"
label val educ educ
label def educ ///
	1  "High School or Lower" ///
	2  "High School Graduate/GED" ///
	3  "College Graduate" ///
	4  "Professional Degree" ///
	99 "N/A"
tab year educ, m

// generate categorical education level dummies
gen hsdrop  = educ == 1
gen hsgrad  = educ == 3
gen colgrad = educ == 4
gen advndgr = educ == 5

label var hsdrop  "High School or Lower"
label var hsgrad  "High School Graduate"
label var colgrad "College Graduate"
label var advndgr "Professional Degree"

global E  hsdrop hsgrad colgrad advndgr
global EX hsdrop hsgrad colgrad

/*--------------------------------------------------------------------------*/

* AGE *
tab age, m
label val age age
label def age 85 "85+"

// five year categorical age recode
gen under70   = (70 > age)
gen age70to74 = (70 <= age & age < 75)
gen age75to79 = (75 <= age & age < 80)
gen age80to84 = (80 <= age & age <= 84)
gen over85    = (85 <= age)

label var under70   "Under Age 70"
label var age70to74 "Age 70-74"
label var age75to79 "Age 75-79"
label var age80to84 "Age 80-84"
label var over85    "Age 85+"

global A  under70 age70to74 age75to79 age80to84 over85
global AX under70 age70to74 age75to79 age80to84

/*--------------------------------------------------------------------------*/

* MARITAL STATUS *
tab year marstat_a, m

// generate married dummy
gen married = (marstat_a <= 3)
label var married "Married"
tab year married

/*--------------------------------------------------------------------------*/

* LIVING ARRANGEMENT *
tab year pcntadlt_a, m
tab year pcntkids_a, m
recode pcntadlt_a (1=1) (2=2) (3=3)
recode pcntkids_a (1=1) (2=2) (3=3)

// household size recode
gen    famsize = numadult+numkid
recode famsize (1=1) (2=2) (3/max=3)

label var famsize "Household Size"
label val famsize famsize
label def famsize 1 "1" 2 "2" 3 "3+"
tab famsize, m

// generate lives alone dummy
gen live_alone = famsize == 1
label var live_alone "Lives Alone"
tab year live_alone

/*--------------------------------------------------------------------------*/

* CENSUS REGION *
tab region, m

gen northeast = region == 1
gen midwest   = region == 2
gen south 	  = region == 3
gen west 	  = region == 4

label var northeast "Northeast"
label var midwest 	"Midwest"
label var south 	"South"
label var west 		"West"

global M  northeast midwest south west
global MX northeast midwest       west

/*--------------------------------------------------------------------------*/

* METROPOLITAN RESIDENCE STATUS *
tab year urbrrl, m
tab year urbrrl23, m

// recode urban rural county classification var for the full sample
gen urclass = .
replace urclass = urbrrl   if year<2024
replace urclass = urbrrl23 if year>2023

label var urclass "Urban Rural County Classification"
label val urclass urclass
label def urclass ///
	1 "Large Central Metro" ///
	2 "Large Fringe Metro" ///
	3 "Medium and Small Metro" ///
	4 "Nonmetropolitan"
tab year urclass, m

// generate metro dummy
g metro = (urclass <= 3)
label var metro "Metropolitan Residence Status"
label val metro metro
label def metro 0 "Rural" 1 "Metropolitan"

/*--------------------------------------------------------------------------*/

* HEALTH CONDITIONS *

// health condition recodes
gen hypev	 = hypev_a == 1
gen chdev	 = chdev_a == 1
gen angev	 = angev_a == 1
gen miev	 = miev_a == 1 
gen strev	 = strev_a == 1
gen dibev	 = dibev_a == 1
gen asthma	 = astill_a == 1
gen canev 	 = canev_a == 1
gen arthev 	 = arthev_a == 1
gen copdev	 = copdev_a == 1
gen hepev 	 = hepev_a == 1
gen crohnsev = crohnsev_a == 1
gen ulccolev = ulccolev_a == 1
gen wkimmun  = (medrxtrt_a == 1 & hlthcond_a == 1)

label var hypev    "Hypertension"
label var chdev    "Coronary Heart Disease"
label var angev    "Angina"
label var miev 	   "Heart Attack"
label var strev    "Stroke"
label var dibev    "Diabetes"
label var asthma   "Asthma"
label var canev    "Cancer"
label var arthev   "Arthritis"
label var copdev   "COPD"
label var hepev	   "Hepatitis"
label var crohnsev "Crohns Disease"
label var ulccolev "Ulcerative Colitis"
label var wkimmun  "Weakened Immune System"

local hlthcond ///
	"hypev chdev angev miev strev canev asthma dibev arthev copdev hepev crohnsev ulccolev wkimmun"

// comprehensive health condition vars
gen numhlthcond = ///
	(hypev+chdev+angev+miev+strev+canev+asthma+dibev+arthev+copdev+wkimmun+hepev+crohnsev+ulccolev)
label var numhlthcond "Number of Health Conditions"
sum numhlthcond

gen hlthprobev = numhlthcond >= 1
label var hlthprobev "Health Condition(s)"
tab hlthprobev

egen meanhlthprobev = mean(hlthprobev)

// count health conditions within sample
local total_count = 0
local num_vars = 0

foreach var of local hlthcond {
	count if `var' == 1
	local count_`var' = r(N)
	local total_count = `total_count' + r(N)
	local num_vars = `num_vars' + 1
	display "`var': `r(N)' SA's have this conditions"
}

local avghlthcond = `total_count' / `num_vars'
display "Total conditions across sample: `total_count'"
display "Number of condition types: `num_vars'"
display "Average people per condition: `avghlthcond'"

gen totalhcond = 0
foreach var of local hlthcond {
	replace totalhcond = totalhcond + `var'
}
sum totalhcond

/*--------------------------------------------------------------------------*/

* EMPLOYMENT STATUS *
tab year empwrklswk_a, m
tab year empwrklsw1_a, m

// recode employment var for the full sample
gen emp = . 
replace emp = empwrklswk_a if year<2020
replace emp = empwrklsw1_a if year>2021

// generate working dummy
label var emp "Worked Recently"
recode emp (2=0) (1=1) (9=.)
tab emp, m

/*--------------------------------------------------------------------------*/

* INCOME *
tab ratcat_a, m

// recode ratcat_a as poverty to income ratio (pir)
gen pir = .
replace pir = 1 if ratcat_a <= 3
replace pir = 2 if inlist(ratcat_a,4,5,6,7)
replace pir = 3 if inlist(ratcat_a,8,9,10,11)
replace pir = 4 if ratcat_a >= 12

label var pir "Categorical Income-to-Poverty Ratio Recode"
label values pir pir
label define pir ///
	1 "0.00 - 0.99" ///
	2 "1.00 - 1.99" ///
	3 "2.00 - 3.99" ///
	4 "4.00 or greater"
tab pir

// generate low income dummy
gen low_inc = inlist(pir,1,2)
label var low_inc "Below 200% FPL"
tab low_inc

// generate log (ln) income dummy
gen loginc=ln(1+faminctc_a )
label var loginc "Log Income"

/*--------------------------------------------------------------------------*/

* FOOD ASSISTANCE *
tab year fsnap12m_a, m
tab year fsnap30d_a, m

// generate snap/ebt dummy
gen snap = (fsnap12m_a == 1 | fsnap30d_a == 1)
label var snap "Food Stamp Recipient"
tab snap

/*--------------------------------------------------------------------------*/

* HOUSING/RENTAL ASSISTANCE *
tab year hougvasst_a, m

// generate rent subsidy dummy
gen lowrent = hougvasst_a == 1
label var lowrent "Rent Subsidy Recipient"
tab lowrent


/*----------------------------------------------------------------------------
		      2.2: Outcome Variables
----------------------------------------------------------------------------*/

* FOOD SECURITY *
rename fdscat3_a fdscat3
rename fdscat4_a fdscat4

tab year fdscat3
tab year fdscat4

// recode food security score items
gen runout   = (fdsrunout_a <= 2)
gen notlast  = (fdslast_a <= 2)
gen balmeal  = (fdsbalance_a <= 2)
gen skip     = (fdsskip_a == 1)
gen skipdays = (fdsskipdys_a >= 3 & fdsskipdys_a < 31)
gen eatless  = (fdsless_a == 1)
gen hungry   = (fdshungry_a == 1) 
gen losewt   = (fdsweight_a == 1) 
gen wholeday = (fdsnoteat_a == 1)
gen whldays  = (fdsnedays_a >= 3 & fdsnedays_a < 31)

label var runout   "Worried food would run out"
label var notlast  "Food bought would not last"
label var balmeal  "Could not afford to eat balanced meals"
label var skip     "Cut size or skipped meals"
label var skipdays "Cut/skipped one meal 3+ days"
label var eatless  "Ate less than should have"
label var hungry   "Hungry but did not eat"
label var losewt   "Lost weight"
label var wholeday "Not eat for whole day"
label var whldays  "Not eat for day 3+ days"

local fsout ///
	" runout notlast balmeal skip skipdays eatless hungry losewt wholeday whldays "

// generate food security score vars
gen fsscore = ///
	(runout+notlast+balmeal+skip+skipdays+eatless+hungry+losewt+wholeday+whldays)
label var fsscore "Food Security Raw Score"
sum `fsout' fsscore

gen hifs   = (fsscore == 0)
gen margfs = (fsscore == 1 | fsscore == 2)
gen lowfs  = (fsscore >= 3 & fsscore <= 5)
gen vlowfs = (fsscore >= 6 & fsscore <= 10)

label var hifs   "High Food Security"
label var margfs "Marginal Food Security"
label var lowfs  "Low Food Security"
label var vlowfs "Very Low Food Security"

// generate food insecurity dummy
gen foodinsecure = 1 if (fsscore >= 3 & fsscore <= 10)
replace foodinsecure = 0 if missing(foodinsecure)
label var foodinsecure "Food Insecure"
tab foodinsecure, m

/*--------------------------------------------------------------------------*/

* MEDICAL HARDSHIPS *

// recode medical hardship items
gen probbill = (paybll12m_a == 1 | paynobllnw_a == 1)
gen probcare = (meddl12m_a == 1)
gen probtkrx = (rxsk12m == 1 | rxls12m == 1)
gen probflrx = (rxdl12m == 1)
gen unmetcr  = (medng12m_a == 1)
gen unmetrx  = (rxdg12m == 1)
gen unmetmnd = (unmet_cr == 1 | unmet_rx == 1)

label var probbill "Difficulty Paying Medical Bills"
label var probcare "Delayed Medical Care Due to Cost"
label var probtkrx "Skipped/Reduced Prescription Medication Doses Due to Cost"
label var probflrx "Delayed Re-filling Prescription Medication Due to Cost"
label var unmetcr  "Did Not Get Medical Care Due to Cost"
label var unmetrx  "Did Not Get Prescription Medication Due to Cost"
label var unmetmnd "Cost-Related Unmet Medical Needs"

// count medical hardships within sample
gen numprobmed = (probbill+probcare+probtkrx+probflrx+unmetcr+unmetrx)
label var numprobmed "Total Medical Hardships"

// generate baseline medical hardship dummy
gen medhardshp = numprobmed >= 3
label var medhardshp "Experienced 3+ Medical Hardships"
tab medhardshp


/*----------------------------------------------------------------------------
		      2.3: Treatment Variables
----------------------------------------------------------------------------*/

* MEDICARE COVERAGE *
tab cover65_a, m

// drop uninsured respondents
tab notcov_a
tab cover65_a if notcov_a == 1, m

drop if notcov_a == 1

// drop medicaid beneficiaries
gen dual_elig = (medicaid_a == 1 | hikind04_a == 1 | mcaidprb_a == 1)
tab dual_elig, m

drop if dual_elig == 1

// generate comprehensive Medicare coverage dummies
gen mc_adv   = (cover65_a~=1 | cover65_a~=5) & ///
			   (mcadvr_a == 1 | mchmo_a == 1 | mcchoice_a == 1 | cover65_a == 3)
			   
gen medigap  = mc_adv == 0 & (hikind03_a == 1 | cover65_a == 1)

gen mcpt_ab  = mcpartd_a == 2 & medigap == 0 & mc_adv == 0 & ///
			   (mcpart_a == 1 | mcpart_a == 2 | mcpart_a == 3 | cover65_a == 4)
			   
gen mcpt_abd = mcpartd_a == 1 & medigap == 0 & mc_adv == 0 & ///
			   (mcpart_a == 1 | mcpart_a == 2 | mcpart_a == 3 | cover65_a == 4) 

label var mc_adv   "Medicare Advantage"
label var medigap  "Medigap Supplement"
label var mcpt_ab  "Traditional Medicare Alone"
label var mcpt_abd "Part D Drug Coverage"

global MC  mc_adv medigap mcpt_ab mcpt_abd
global MCX mc_adv medigap         mcpt_abd


// define mutually exclusive Medicare parts
tab   cover65_a mc_adv , m
tab   cover65_a medigap, m 
tab   cover65_a mcpt_ab, m 
tab   cover65_a mcpt_abd, m

tab   mc_adv  mcpt_ab, m
tab   mc_adv  mcpt_abd, m
tab   mc_adv  medigap, m

tab   mcpt_ab  mcpt_abd, m
tab   mcpt_ab  medigap, m

tab   medigap  mcpt_abd, m

g medicarepts = .
replace medicarepts = 3 if mc_adv == 1
replace medicarepts = 4 if medigap == 1 & mc_adv == 0
replace medicarepts = 2 if mcpt_abd == 1 & medigap == 0 & mc_adv == 0
replace medicarepts = 1 if mcpt_ab == 1 & mcpt_abd == 0 & medigap == 0 & mc_adv == 0
label var medicarepts "Mutually Exclusive Medicare Coverage Recode"
label val medicarepts medicarepts
label def medicarepts ///
	1 "Traditional Alone" ///
	2 "Traditional + Drug Coverage" ///
	3 "Medicare Advantage" ///
	4 "Medigap Supplement"
tab medicarepts, m


// drop missing observations
drop if medicarepts == .
 
/*--------------------------------------------------------------------------*/

count
save "nhis19-24_clean.dta", replace

/*--------------------------------------------------------------------------*/


/*============================================================================
				3: Data Analysis
============================================================================*/
cd "~Library/CloudStorage/Box-Box/Medigap_Food/PPAR Manuscript/PPAR_revisions"

macro list

// constants (controlled & uncontrolled):
global C  $A  $R  $E  female
global CX $AX $RX $EX female

// nonconstants:
global NC married live_alone metro emp low_inc snap

// regression vars:
global X  	   $CX $NC low_inc
global X_logit $AX $RX $EX female $NC low_inc 


/*--------------------------------------------------------------------------
			  3.1: Weights & Survey Prep
--------------------------------------------------------------------------*/

* WEIGHTS *
g weight = wtfa_a
count if weight == .
describe weight

bysort year: sum weight

/*--------------------------------------------------------------------------*/

* SURVEY PREP *
svyset ppsu [pweight=weight], strata(pstrat)
svy: mean medigap, over(year)

sum $X
svy: logit medigap $X


/*--------------------------------------------------------------------------
			  3.2: Table 1
--------------------------------------------------------------------------*/
foreach num in 1 2 3 4 {
	estpost tabstat $C $NC if medicarepts == `num' [w=weight], ///
	statistics(mean) columns(statistics)
	eststo est`num'  
}

esttab * using table1_nhis_rv.rtf, ///
cells(mean(fmt(%9.3fc) label(mean)) ) compress unstack ///
mtitles("Traditional Alone" "Drug Coverage" "Medicare Advantage" "Medigap Supplement") ///
label replace nogaps ///
title("Table 1: Demographic Summary Statistics by Medicare Coverage") ///
addnote("NHIS 2019-2024.")

est clear


/*--------------------------------------------------------------------------
			  3.3: Table 2
--------------------------------------------------------------------------*/
eststo:  reg foodinsecure $MCX $TX [w=weight] ,r  
estadd ysumm

eststo:  reg foodinsecure $MCX $TX $X $MX [w=weight] ,r  
estadd ysumm

eststo:  reg medhardshp $MCX $TX [w=weight] ,r  
estadd ysumm

eststo:  reg medhardshp $MCX $TX $X $MX [w=weight] ,r  
estadd ysumm

esttab * using table2_nhis.rtf, ///
se replace star(* 0.10 ** 0.05 *** 0.01) ///
label ar2 compress nogaps indicate("Year FE = y*") ///
stats(N ymean ysd r2 , ///
labels("Observations" "Y Mean" "Y Std" "R-squared") ) ///
addnote("NHIS 2019-2024.")

est clear


/*--------------------------------------------------------------------------
			  3.4: Figure 1
--------------------------------------------------------------------------*/
foreach num in 2019 2020 2021 2022 2023 2024 {
	estpost tabstat $MC if year == `num' [w=weight], ///
	statistics(mean) columns(statistics)
	eststo est`num'  
}

clear
input year mc_adv medigap
2019 . .
2020 . .
2021 . .
2022 . .
2023 . .
2024 . .
end

foreach num in 2019 2020 2021 2022 2023 2024 {
    estimates restore est`num'
    mat b = e(mean)
    replace mc_adv   = b[1,1] if year == `num'
    replace medigap  = b[1,2] if year == `num'
	replace mcpt_ab  = b[1,3] if year == `num'
    replace mcpt_abd = b[1,4] if year == `num'
}

twoway ///
    (line mc_adv year,  lcolor(navy)  lwidth(medium) msymbol(circle)) ///
    (line medigap year, lcolor(orange) lwidth(medium) msymbol(circle)), ///
    ylabel(0 "0%" .1 "10%" .2 "20%" .3 "30%" .4 "40%" .5 "50%" .6 "60%", grid) ///
    xlabel(2019 2020 2021 2022 2023 2024) ///
    legend(label(1 "Medicare Advantage") label(2 "Medigap Supplement") position(6)) ///
	
	
/*--------------------------------------------------------------------------
			  3.5: Figure 2
--------------------------------------------------------------------------*/
eststo:  reg foodinsecure $MCX $TX $X $MX [w=weight] ,r  
eststo:  reg medhardshp   $MCX $TX $X $MX [w=weight] ,r  
 
coefplot (est1, label ("Food Insecure")) ///
		 (est2, label( "Medical Hardship")), ///
		 xline(0) drop(y* _cons north* mid* west)
		 
graph export "fig2.png", as(png) name("Graph") replace

est clear


/*============================================================================
				4: Supplementary Data
============================================================================*/

// NHIS Demographic Summary Statistics by Medicare Coverage Type
foreach num in 1 2 3 4 {
	estpost tabstat $C $NC if medicarepts == `num' [w=weight], ///
	statistics(mean) columns(statistics)
	eststo est`num'  
}

esttab * using table1_nhis.rtf, ///	
cells(mean(fmt(%9.3fc) label(mean))) compress unstack ///
mtitles("Traditional Alone" "Part D" "Medicare Advantage" "Medigap Supplement") ///
label replace nogaps ///
title("Table 2: Demographic Summary Statistics by Medicare Coverage Type") ///
addnote("NHIS 2019-2024.")

est clear

/*--------------------------------------------------------------------------*/

// NHIS Coverage Rate by Year
foreach num in 2019 2020 2021 2022 2023 2024 {
	estpost tabstat $MC if year == `num' [w=weight], ///
	statistics(mean) columns(statistics)
	eststo est`num'  
}

esttab * using table1a_sumstats_mcpts_nhis.rtf, ///
cells(mean(fmt(%9.3fc) label(mean)) ) compress unstack ///
mtitles("2019" "2020" "2021" "2022" "2023" "2024") ///
label replace nogaps ///
title("Table 1: Medicare Coverage by Year") ///
addnote("NHIS 2019-2024.")

est clear

/*--------------------------------------------------------------------------*/
cap log close
/*--------------------------------------------------------------------------*/
