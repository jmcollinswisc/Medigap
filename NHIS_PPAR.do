clear all
clear matrix
*clear scalar
estimates clear
macro drop _all
capture log close
set more off


log using "/Users/jennaauth/Desktop/IRP/NHIS/NHIS2.log", replace


******************************************************
** National Health Interview Survey (NHIS) **
******************************************************

************************
/* NOTES:
************************

The National Health Interview Survey (NHIS) hierarchy for people aged 65 and over prioritizes specific health insurance types into six mutually exclusive categories. 

The hierarchy prioritizes Medicare Advantage, followed by other coverage types in a specific order: traditional Medicare only, private coverage (including those with Medicare and private insurance), other coverage, and finally, no Medicare coverage. 
*/


*********************************************

*********************************************
** APPEND 2019-2024 DATA **
*********************************************

use "/Users/jennaauth/Desktop/IRP/NHIS/data/samadult19.dta"

append using "/Users/jennaauth/Desktop/IRP/NHIS/data/samadult20.dta"
append using "/Users/jennaauth/Desktop/IRP/NHIS/data/samadult21.dta"
append using "/Users/jennaauth/Desktop/IRP/NHIS/data/samadult22.dta"
append using "/Users/jennaauth/Desktop/IRP/NHIS/data/samadult23.dta", force
append using "/Users/jennaauth/Desktop/IRP/NHIS/data/samadult24.dta", force

save "/Users/jennaauth/Desktop/IRP/NHIS/data/nhis2019-24.dta" 

*********************************************

*********************************************
** 2019-2024 NHIS DATA CLEANING **
*********************************************

** YEAR **

rename srvy_yr year
tab year, gen(y)
tab1 y*

global T  y1 y2 y3 y4 y5 y6
global TX y1    y3 y4 y5 y6

*********************************************

** AGE **

// drop respondents under 65
rename agep_a age
keep if age >= 65

// drop refused and n/a obs
drop if (age == 97 | age == 98 | age == 99)
label values age age
label define age 85 "85+"
tab age, m


g under70 = (age < 70)
label var under70 "Under Age 70"
g age70to74 = (70 <= age & age < 75)
label var age70to74 "Age 70-74"
g age75to79 = (75 <= age & age < 80)
label var age75to79 "Age 75-79"
g age80to84 = (80 <= age & age <= 84)
label var age80to84 "Age 80-84"
g over85 = age >= 85
label var over85 "Age 85+"

global A  under70 age70to74 age75to79 age80to84 over85
global AX under70 age70to74 age75to79 age80to84


g agecat = .
replace agecat = 1 if under70 == 1
replace agecat = 2 if age70to74 == 1
replace agecat = 3 if age75to79 == 1
replace agecat = 4 if age80to84 == 1
replace agecat = 5 if over85 == 1
label var agecat "Age Category"
label values agecat agecat
label def agecat 1 "Under 70" 2 "70-74" 3 "75-79" 4 "80-84" 5 "85+"
tab agecat

*********************************************

** SEX **

rename sex_a sex
tab sex, m

g female = sex == 2
label var female "Female"
la def female 0 "Male" 1 "Female"
la val female female

*********************************************

** CENSUS REGION **

g northeast = region == 1
g midwest = region == 2
g south = region == 3
g west = region == 4


global M  northeast midwest south west
global MX northeast midwest       west

*********************************************

** URBAN RURAL CLASSIFICATION **

g urclass = .
replace urclass = urbrrl if year<2024
replace urclass = urbrrl23 if year>2023
label var urclass "Urban Rural County Classification"
label values urclass urclass
label define urclass 1 "Large Central Metro" 2 "Large Fringe Metro" 3 "Medium and Small Metro" 4 "Nonmetropolitan"
tab urclass


g metro = (urclass <= 3)
label var metro "Metro"

*********************************************

** EDUCATION **

g educ = .
replace educ = educp_a if year>2020
replace educ = educ_a if year<2021
tab educ, m


g edn = .
replace edn = 1 if educ<3
replace edn = 2 if inlist(educ,3,4,5)
replace edn = 3 if inlist(educ,6,7,8)
replace edn = 4 if inlist(educ,9,10,11)
label values edn edn
label define edn 1 "High School or Lower" 2 "High School Graduate" 3 "College Graduate" 4 "Advanced Degree" 
label var edn "Education Level"
tab edn, m


g hsdrop = edn == 1
label var hsdrop "High School or Lower"
g hsgrad = edn == 2
label var hsgrad "High School Graduate"
g colgrad = edn == 3
label var colgrad "College Graduate"
g advndegree = edn == 4
label var advndegree "Advanced Degree"

global E  hsdrop hsgrad colgrad advndegree
global EX hsdrop hsgrad colgrad


g college = (edn == 3 | edn == 4)
label var college "Obtained College Degree"
tab college, m

*********************************************

** MARITAL STATUS **

g married = (marstat_a <= 3)
label var married "Married"
tab married, m

*********************************************

** RACE/ETHNICITY **

g hispanic = hisp_a == 1
label var hispanic "Hispanic"
g white = (raceallp_a == 1 & hisp_a == 2)
label var white "Non-Hispanic White"
g black = (raceallp_a == 2 & hisp_a == 2)
label var black "Non-Hispanic Black"
g asian = (raceallp_a == 3 & hisp_a == 2)
label var asian "Non-Hispanic Asian"
g other_r = (raceallp_a == 6 & hisp_a == 2)
label var other_r "Other or Multiple Races"
g raceuk = raceallp_a > 6
label var raceuk "Unknown Race"

global R white black asian hispanic


g racecat = .
replace racecat = 1 if white == 1
replace racecat = 2 if black == 1
replace racecat = 3 if asian == 1
replace racecat = 4 if hispanic == 1
replace racecat = 5 if (other_r == 1 | raceuk == 1)
label var racecat "Race/Ethnicity"
label values racecat racecat
label define racecat 1 "Non-Hispanic White" 2 "Non-Hispanic Black" 3 "Non-Hispanic Asian" 4 "Hispanic" 5 "Other or Multiple Races"
tab racecat, m

*********************************************

** EMPLOYMENT **

g emp = (empwrklswk_a == 1 | empwrklsw1_a == 1)
label var emp "Worked for Pay Recently"
tab emp, m

*********************************************

** POVERTY TO INCOME RATIO (PIR) **

tab ratcat_a, m

g pir = .
replace pir = 1 if ratcat_a <= 3
replace pir = 2 if inlist(ratcat_a,4,5,6,7)
replace pir = 3 if inlist(ratcat_a,8,9,10,11)
replace pir = 4 if ratcat_a >= 12
label var pir "Categorical Income-to-Poverty Ratio Recode"
label values pir pir
label define pir 1 "0.00 - 0.99" 2 "1.00 - 1.99" 3 "2.00 - 3.99" 4 "4.00 or greater"
// 0.00 - 0.99 = below 100% FPL // poor
// 1.00 - 1.99 = below 200% FPL // near poor
// 2.00 - 3.99 = below 400% FPL
// 4.00 + = above 400% FPL
tab pir


g low_inc = (pir == 2 | pir == 1)
label var low_inc "Below 200% FPL"
tab low_inc

*********************************************

** LOG INCOME **

g loginc=ln(1+faminctc_a )
la var loginc "Income (ln)"

*********************************************

** HOUSING **

g lowrent = hougvasst_a == 1
label var lowrent "Rent Subsidy Recipient"
tab lowrent

*********************************************

** FAMILY/HOUSEHOLD SIZE **

g numadult = pcntadlt_a if pcntadlt < 8
label var numadult "Number of Adutls in SA's Family"
label values numadult numadult
label define numadult 3 "3+"

g numkid = pcntkids_a if pcntkids < 8
label var numkid "Number of Children in SA's Family"
label values numkid numkid
label define numkid 3 "3+"

g famsize = numadult+numkid
recode famsize (1=1) (2=2) (3/max=3)
label var famsize "Family Size"
label values famsize famsize
label define famsize 1 "Lives Alone" 2 "Two Person Household" 3 "Household of Three or More"
tab famsize


g live_alone = famsize == 1
label var live_alone "Lives Alone"
tab live_alone

*********************************************

** SNAP EBT **

g snap = (fsnap12m_a == 1 | fsnap30d_a == 1)
label var snap "Food Stamp Recipient"
tab snap

*********************************************

** HEALTH CONDITIONS **

g hypev = hypev_a == 1
label var hypev "Hypertension"
g chdev = chdev_a == 1
label var chdev "Coronary Heart Disease"
g angev = angev_a == 1
label var angev "Angina"
g miev = miev_a == 1 
label var miev "Heart Attack"
g strev = strev_a == 1
label var strev "Stroke"
g dibev = dibev_a == 1
label var dibev "Diabetes"
g asthma = astill_a == 1
label var asthma "Asthma"
g canev = canev_a == 1
label var canev "Cancer"
g arthev = arthev_a == 1
label var arthev "Arthritis"
g copdev = copdev_a == 1
label var copdev "COPD"
g hepev = hepev_a == 1
label var hepev "Hepatitis"
g crohnsev = crohnsev_a == 1
label var crohnsev "Crohns Disease"
g ulccolev = ulccolev_a == 1
label var ulccolev "Ulcerative Colitis"
g wkimmun = (medrxtrt_a == 1 & hlthcond_a == 1)
label var wkimmun "Weakened Immune System"


g hlthcond = .
replace hlthcond = 1 if hypev == 1
replace hlthcond = 2 if chdev == 1
replace hlthcond = 3 if angev == 1
replace hlthcond = 4 if miev == 1
replace hlthcond = 5 if strev == 1
replace hlthcond = 6 if dibev == 1
replace hlthcond = 7 if asthma == 1
replace hlthcond = 8 if canev == 1
replace hlthcond = 9 if arthev == 1
replace hlthcond = 10 if copdev == 1
replace hlthcond = 11 if hepev == 1
replace hlthcond = 12 if crohnsev == 1
replace hlthcond = 13 if ulccolev == 1
replace hlthcond = 14 if wkimmun == 1
label var hlthcond "Health Conditions"
label values hlthcond hlthcond
label define hlthcond 1 "Hypertension" 2 "Coronary Heart Disease" 3 "Angina" 4 "Heart Attack" 5 "Stroke" 6 "Diabetes" 7 "Asthma" 8 "Cancer" 9 "Arthritis" 10 "COPD" 11 "Hepatitis" 12 "Crohns Disease" 13 "Ulcerative Colitis" 14 "Weak Immune System"
tab hlthcond


local hlthcond "hypev chdev angev miev strev canev asthma dibev arthev copdev hepev crohnsev ulccolev wkimmun"

g numhlthcond = hypev+chdev+angev+miev+strev+canev+asthma+dibev+arthev+copdev+wkimmun+hepev+crohnsev+ulccolev
label var numhlthcond "Number of Health Conditions"
sum numhlthcond

g hlthprobev = numhlthcond >= 1
label var hlthprobev "Have Health Condition(s)"
tab hlthprobev

egen meanhlthprobev = mean(hlthprobev)

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

*********************************************

*********************************************
** TREATMENT VARIABLES **
*********************************************

** MEDICARE COVERAGE **

drop if notcov_a == 1

g dual_elig = (medicaid_a == 1 | hikind04_a == 1 | mcaidprb_a == 1)
tab dual_elig, m
drop if dual_elig == 1


tab cover65_a, m


g mc_adv = (mcadvr_a == 1 | mchmo_a == 1 | mcchoice_a == 1 | cover65_a == 3) & (cover65_a~=1 | cover65_a~=5)
label var mc_adv "Medicare Advantage (Part C)"

g medigap = (hikind03_a == 1 | cover65_a == 1) & mc_adv == 0 
label var medigap "Medigap Supplement"

g mcpt_ab = (mcpart_a == 1 | mcpart_a == 2 | mcpart_a == 3 | cover65_a == 4) & mcpartd_a == 2 & medigap == 0 & mc_adv == 0 
label var mcpt_ab "Traditional Medicare Alone"

g mcpt_abd = (mcpart_a == 1 | mcpart_a == 2 | mcpart_a == 3 | cover65_a == 4) & mcpartd_a == 1 & medigap == 0 & mc_adv == 0 
label var mcpt_abd "Part D Drug Coverage"


global MC  mc_adv medigap mcpt_ab mcpt_abd
global MCX mc_adv medigap         mcpt_abd

*********************************************

*********************************************
** Mutually Exclusive Medicare Parts **
*********************************************

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
label var medicarepts "Mutually Exclusive Medicare Coverage Type Recode"
label define medicarepts 1 "Traditional Alone" 2 "Traditional + Drug Coverage" 3 "Medicare Advantage" 4 "Medigap Supplement"
label values medicarepts medicarepts
tab medicarepts, m

drop if medicarepts == .

*********************************************

*********************************************
** OUTCOMES **
*********************************************

** FOOD SECURITY **

g fdscat3 = .
replace fdscat3 = 1 if fdscat3_a == 1
replace fdscat3 = 2 if fdscat3_a == 2
replace fdscat3 = 3 if fdscat3_a == 3
label var fdscat3 "Three Category Food Security Recode"
tab fdscat3


g fdscat4 = .
replace fdscat4 = 1 if fdscat4_a == 1
replace fdscat4 = 2 if fdscat4_a == 2
replace fdscat4 = 3 if fdscat4_a == 3
replace fdscat4 = 4 if fdscat4_a == 4
label var fdscat4 "Four Category Food Security Recode"
tab fdscat4


// food security score items
g runout = fdsrunout_a <= 2
label var runout  "Worried food would run out"
g notlast = fdslast_a <= 2
label var notlast "Food bought would not last"
g balmeal = fdsbalance_a <= 2
label var balmeal "Could not afford to eat balanced meals"
g skip = fdsskip_a == 1
label var skip "Cut size or skipped meals"
g skipdays = (fdsskipdys_a >= 3 & fdsskipdys_a < 31)
label var skipdays  "Cut/skipped one meal 3+ days"
g eatless = fdsless_a == 1 
label var eatless "Ate less than should have"
g hungry = fdshungry_a == 1 
label var hungry "Hungry but did not eat"
g losewt = fdsweight_a == 1 
label var losewt "Lost weight"
g wholeday = fdsnoteat_a == 1
label var wholeday "Not eat for whole day"
g whldays = (fdsnedays_a >= 3 & fdsnedays_a < 31)
label var whldays  "Not eat for day 3+ days"


local fsout " runout notlast balmeal skip skipdays eatless hungry losewt wholeday whldays "

g fsscore = runout+notlast+balmeal+skip+skipdays+eatless+hungry+losewt+wholeday+whldays
label var fsscore "Food Security Raw Score"

sum `fsout' fsscore


g hifs = fsscore == 0
label var hifs "High Food Security"
g margfs = (fsscore == 1 | fsscore == 2)
label var margfs "Marginal Food Security"
g lowfs = (fsscore >= 3 & fsscore <= 5)
label var lowfs "Low Food Security"
g vlowfs = (fsscore >= 6 & fsscore <= 10)
label var vlowfs "Very Low Food Security"


g foodinsecure = 1 if (fsscore >= 3 & fsscore <= 10)
label var foodinsecure "Food Insecure"
tab foodinsecure, missing
replace foodinsecure = 0 if missing(foodinsecure)
tab year foodinsecure


g fsstat = .
replace fsstat = 1 if hifs == 1
replace fsstat = 2 if margfs == 1
replace fsstat = 3 if lowfs == 1
replace fsstat = 4 if vlowfs == 1
label var fsstat "Food Security Status"
label values fsstat fsstat
label define fsstat 1 "High" 2 "Marginal" 3 "Low" 4 "Very Low"
tab fsstat

*********************************************

** MEDICAL HARDSHIPS ** 

// medical hardships
g prob_bill = (paybll12m_a == 1 | paynobllnw_a == 1)
label var prob_bill "Difficulty Paying Medical Bills"
tab prob_bill

g prob_care = meddl12m_a == 1
label var prob_care "Delayed Medical Care Due to Cost"
tab prob_care

g probtake_rx = (rxsk12m == 1 | rxls12m == 1)
label var probtake_rx "Skipped Doses or Took Less Prescription Medication Due to Cost"
tab probtake_rx

g probfill_rx = rxdl12m == 1
label var probfill_rx "Delayed Re-filling Prescription Medication Due to Cost"
tab probfill_rx


// unmet medical needs
g unmet_cr = medng12m_a == 1
label var unmet_cr "Did Not Get Medical Care Due to Cost"
tab unmet_cr

g unmet_rx = rxdg12m == 1
label var unmet_rx "Did Not Get Prescription Medication Due to Cost"
tab unmet_rx

g unmet_mnds = (unmet_cr == 1 | unmet_rx == 1)
label var unmet_mnds "Cost-Related Unmet Medical Needs"
tab unmet_mnds


g numprobmed = prob_bill+prob_care+probtake_rx+probfill_rx+unmet_cr+unmet_rx
label var numprobmed "Total Medical Hardships"

g medhardshp = numprobmed >= 3
label var medhardshp "Experienced 3+ Medical Hardships"
tab medhardshp
 
*********************************************

save "/Users/jennaauth/Desktop/IRP/NHIS/data/nhis19-24_clean.dta", replace

clear all

*********************************************

*********************************************
** ANALYSIS **
*********************************************

use "/Users/jennaauth/Desktop/IRP/NHIS/data/nhis19-24_clean.dta", clear
cd "/Users/jennaauth/Desktop/IRP/NHIS/output"

*********************************************

** WEIGHTS **

g weight = wtfa_a
count if weight == .
describe weight

bysort year: sum weight

*********************************************

** SURVEY PREP **

svyset ppsu [pweight=weight], strata(pstrat)
svy: mean medigap, over(year)

*********************************************

** DEFINE MACROS **

// year
global T  y1 y2 y3 y4 y5 y6
global TX y1    y3 y4 y5 y6

// age
global A  under70 age70to74 age75to79 age80to84 over85
global AX under70 age70to74 age75to79 age80to84

// region
global M  northeast midwest south west
global MX northeast midwest       west

// educational attainment
global E  hsdrop hsgrad colgrad advndegree
global EX hsdrop hsgrad colgrad

// race
global R white black asian hispanic

// Medicare coverage
global MC  mc_adv medigap mcpt_ab mcpt_abd
global MCX mc_adv medigap         mcpt_abd

// constant characteristics
global C  $A  $R $E  female
global CX $AX $R $EX female

// non-constant characteristics
global NC married live_alone metro emp hlthprobev

// all characteristics
global X $CX $NC low_inc

// all characteristics, controlled
global X_logit $AX $R $EX female $NC low_inc 

sum $X
svy: logit medigap $X

*********************************************

*********************************************
** SUMMARY STATISTICS **
*********************************************

** Table 1a: NHIS Coverage Rate by Year

est clear

foreach num in 2019 2020 2021 2022 2023 2024 {
	estpost tabstat $MC if year == `num' [w=weight], statistics(mean) columns(statistics)
	eststo est`num'  
}

esttab * using table1a_sumstats_mcpts_nhis.rtf, cells(mean(fmt(%9.3fc) label(mean)) ) compress unstack  ///
 mtitles("2019" "2020" "2021" "2022" "2023" "2024") ///
label replace nogaps title("Table 1: Medicare Coverage by Year") ///
 addnote("NHIS 2019-2024.")

est clear

*********************************************

** Table 2a: NHIS Demographic Summary Statistics by Medicare Coverage Type

foreach num in 1 2 3 4 {
	estpost tabstat under70 age70to74 age75to79 age80to84 over85 white black asian hispanic hsdrop hsgrad colgrad advndegree female married live_alone metro emp low_inc snap if medicarepts == `num' [w=weight], statistics(mean) columns(statistics)
	eststo est`num'  
}

esttab * using table2a_sumstats_nhis.rtf, cells(mean(fmt(%9.3fc) label(mean)) ) compress unstack  ///
 mtitles("Traditional Alone" "Drug Coverage" "Medicare Advantage" "Medigap Supplement") ///
label replace nogaps title("Table 2: Demographic Summary Statistics by Medicare Coverage Type") ///
 addnote("NHIS 2019-2024.")

est clear

*********************************************

*********************************************
** OLS (LPM) REGRESSIONS **
*********************************************

** Table 3: NHIS OLS Estimates of Food Security by Coverage Type

/// col 1 - Medicare + Year
eststo:  reg foodinsecure $MCX $TX [w=weight] ,r  
estadd ysumm

/// col 2 - Medicare + Year + Region + Controls + Region
eststo:  reg foodinsecure $MCX $TX $X $MX [w=weight] ,r  
estadd ysumm

/// full table
esttab * using table3_fi_nhis.rtf, se replace star(* 0.10 ** 0.05 *** 0.01) ///
label ar2 compress nogaps indicate("Year FE = y*") ///
stats(N ymean ysd r2 , labels("Observations" "Y Mean" "Y Std" "R-squared") ) ///
addnote("NHIS 2019-2024.")

est clear

*********************************************

*********************************************
cap log close
*********************************************
