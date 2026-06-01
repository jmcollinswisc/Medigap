capture log close
clear all
clear matrix
*clear scalar
estimates clear
macro drop _all
set more off


******************************************************
** National Health & Aging Trends Study (NHATS) **
******************************************************

************************
/* NOTES:
************************

* SURVEY STRUCTURE *

NHATS surveys are conducted annually, beginning in 2011 (R1), with currently available data following through 2024 (R14)

The NHATS follows a longitudinal sample, where each Sample Person (SP) is indicated by a unique Sample Person ID number (spid)

To replenish the sample, new cohorts are added over time
// the original cohort consists of respondents who entered the survey in R1
// new cohorts are added in R5, R12, R13

The survey follows a continuous age composition:
// R1(2011) = 65+
// R2(2012) = 66+
   etc...
// R5(2015) the sample is replenished, restarting at 65+

To control of age composition, include the "interval age" variable in the models

Constants are only asked of SPs at in the round they enter the survey
Income and certain financial questions are only asked at entry rounds and/or every other round

The NHATS over samples older, Black (and Hispanic in 2022/2023) individuals and includes proxy responses (6-7%)

************************

* NHATS DATA FILES *

Use the NHATS Public Use Files, Annual Data Files for STATA
Within each round specific data file (R1-14), use the respective SP Files and Tracker Files

Data File merge methods follow NHATS recommendations

The R1-R8 Data Files include a seperate Metro File, first merge each round's SP File with it's respective Metro File
(metro data in R9-R14 is included within the SP Files)
// merge 1:1 spid

Then merge each round's Tracker File with it's respective SP File
// merge 1:1 spid
// keep only matched observations to avoid duplicates (_merge == 3)

With new cohorts added in R5, R12, and R13, the fully merged data files need to be appended together
// the vars used need to be renamed in order to append

************************

* VARIABLE & RESPONSE KEY *

Variable names and labels are round specific
// var names:  first 2 letters indicate section (topic), the following number (#) indicates survey round, the suffix is an abbreviation of the item description
// var labels: begin with R# (indicating survey round), followed by section indicators (series of letter and number abbreviations), and a breif description of the item; 
               derived vars are indicated by a "D" following R#
				
Variable response key:
// -9 = N/A
// -8 = DK
// -7 = Refused
// -1 = Inapplicable

************************

* WEIGHTS *

For panel estimates, use person/spid fixed effects rather than weights

Otherwise, use full tracker weights (w#trfinwgt0) for national estimates
// cumulative - includes all persons ever sampled for NHATS (respondents, nonrespondents, ineligible cases)
// includes info on year SP entered NHATS, status of SP at each round, interview month and year for each round

************************

* SVYSET PSTRAT KEY *

// variance unit (PSU): w#varunit
// variance stratum:    w#varstrat 
// weight:				w#trfinwgt0

*/

******************************************************

******************************************************
** MERGE R1-R8 SP & METRO FILES **
******************************************************

* ROUND 1 *
use "/Users/jennaauth/Desktop/IRP/NHATS/R1_2011_STATA/NHATS_Round_1_SP_File.dta", clear
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/R1_2011_STATA/NHATS_Round_1_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/R1_2011_STATA/NHATS_Round_1_SP_met.dta", replace


* ROUND 2 *
use "/Users/jennaauth/Desktop/IRP/NHATS/R2_2012_STATA/NHATS_Round_2_SP_File_v2.dta", clear
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/R2_2012_STATA/NHATS_Round_2_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/R2_2012_STATA/NHATS_Round_2_SP_met.dta", replace


* ROUND 3 *
use "/Users/jennaauth/Desktop/IRP/NHATS/R3_2013_STATA/NHATS_Round_3_SP_File.dta", clear
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/R3_2013_STATA/NHATS_Round_3_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/R3_2013_STATA/NHATS_Round_3_SP_met.dta", replace


* ROUND 4 *
use "/Users/jennaauth/Desktop/IRP/NHATS/R4_2014_STATA/NHATS_Round_4_SP_File.dta", clear
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/R4_2014_STATA/NHATS_Round_4_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/R4_2014_STATA/NHATS_Round_4_SP_met.dta", replace


* ROUND 5 *
use "/Users/jennaauth/Desktop/IRP/NHATS/R5_2015_STATA/NHATS_Round_5_SP_File_V2.dta", clear
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/R5_2015_STATA/NHATS_Round_5_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/R5_2015_STATA/NHATS_Round_5_SP_met.dta", replace


* ROUND 6 *
use "/Users/jennaauth/Desktop/IRP/NHATS/R6_2016_STATA/NHATS_Round_6_SP_File_V2.dta", clear
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/R6_2016_STATA/NHATS_Round_6_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/R6_2016_STATA/NHATS_Round_6_SP_met.dta", replace


* ROUND 7 *
use "/Users/jennaauth/Desktop/IRP/NHATS/R7_2017_STATA/NHATS_Round_7_SP_File.dta", clear
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/R7_2017_STATA/NHATS_Round_7_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/R7_2017_STATA/NHATS_Round_7_SP_met.dta", replace


* ROUND 8 *
use "/Users/jennaauth/Desktop/IRP/NHATS/R8_2018_STATA/NHATS_Round_8_SP_File.dta", clear
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/R8_2018_STATA/NHATS_Round_8_MetNonMet.dta"
tab _merge
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/R8_2018_STATA/NHATS_Round_8_SP_met.dta", replace

******************************************************

******************************************************
** CLEAN TRACKER FILES **
******************************************************

* ROUND 1 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R1_2011_STATA/NHATS_Round_1_Tracker_File.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R1_tracker_clean.dta", replace


* ROUND 2 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R2_2012_STATA/NHATS_Round_2_Tracker_File_v2.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R2_tracker_clean.dta", replace


* ROUND 3 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R3_2013_STATA/NHATS_Round_3_Tracker_File_V2.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R3_tracker_clean.dta", replace


* ROUND 4 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R4_2014_STATA/NHATS_Round_4_Tracker_File_V2.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R4_tracker_clean.dta", replace


* ROUND 5 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R5_2015_STATA/NHATS_Round_5_Tracker_File_V3.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R5_tracker_clean.dta", replace


* ROUND 6 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R6_2016_STATA/NHATS_Round_6_Tracker_File_V3.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R6_tracker_clean.dta", replace


* ROUND 7 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R7_2017_STATA/NHATS_Round_7_Tracker_File_V2.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R7_tracker_clean.dta", replace


* ROUND 8 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R8_2018_STATA/NHATS_Round_8_Tracker_File_V2.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R8_tracker_clean.dta", replace


* ROUND 9 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R9_2019_STATA/NHATS_Round_9_Tracker_File.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R9_tracker_clean.dta", replace


* ROUND 10 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R10_2020_STATA/NHATS_Round_10_Tracker_File.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R10_tracker_clean.dta", replace


* ROUND 11 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R11_2021_STATA/NHATS_Round_11_Tracker_File.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R11_tracker_clean.dta", replace


* ROUND 12 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R12_2022_STATA/NHATS_Round_12_Tracker_File.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R12_tracker_clean.dta", replace


* ROUND 13 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R13_2023_STATA/NHATS_Round_13_Tracker_File_V2.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R13_tracker_clean.dta", replace


* ROUND 14 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/R14_2024_STATA/NHATS_Round_14_Tracker_File.dta", clear
tab yearsample
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R14_tracker_clean.dta", replace

******************************************************

******************************************************
** MERGE TRACKER & SP FILES **
******************************************************

* ROUND 1 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R1_tracker_clean.dta", clear
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R1_2011_STATA/NHATS_Round_1_SP_met.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R1.dta", replace


* ROUND 2 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R2_tracker_clean.dta", clear
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R2_2012_STATA/NHATS_Round_2_SP_met.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R2.dta", replace


* ROUND 3 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R3_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R3_2013_STATA/NHATS_Round_3_SP_met.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R3.dta", replace


* ROUND 4 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R4_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R4_2014_STATA/NHATS_Round_4_SP_met.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R4.dta", replace


* ROUND 5 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R5_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R5_2015_STATA/NHATS_Round_5_SP_met.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R5.dta", replace


* ROUND 6 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R6_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R6_2016_STATA/NHATS_Round_6_SP_met.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R6.dta", replace


* ROUND 7 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R7_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R7_2017_STATA/NHATS_Round_7_SP_met.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R7.dta", replace


* ROUND 8 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R8_tracker_clean.dta", clear
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R8_2018_STATA/NHATS_Round_8_SP_met.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R8.dta", replace


* ROUND 9 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R9_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R9_2019_STATA/NHATS_Round_9_SP_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R9.dta", replace


* ROUND 10 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R10_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R10_2020_STATA/NHATS_Round_10_SP_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R10.dta", replace


* ROUND 11 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R11_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R11_2021_STATA/NHATS_Round_11_SP_File_V2.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R11.dta", replace


* ROUND 12 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R12_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R12_2022_STATA/NHATS_Round_12_SP_File_V2.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R12.dta", replace


* ROUND 13 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R13_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R13_2023_STATA/NHATS_Round_13_SP_File_V2.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R13.dta", replace


* ROUND 14 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_trackers/R14_tracker_clean.dta", clear
sort spid
capture drop _merge
merge 1:1 spid using "/Users/jennaauth/Desktop/IRP/NHATS/data/R14_2024_STATA/NHATS_Round_14_SP_File.dta"
tab _merge
keep if _merge == 3
drop _merge
sort spid
count
save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R14.dta", replace


clear all


* CHECK MERGED ROUNDS *
foreach r of numlist 1/14 {
    use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R`r'.dta", clear
    duplicates report spid
    display "Round `r' has `=_N' observations"
}

foreach r of numlist 1/14 {
    use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R`r'.dta", clear
    display "Round `r' file:"
    tab yearsample
}

clear all

******************************************************

******************************************************
** PREP & CLEAN MERGED FILES **
******************************************************

* ROUND 1 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R1.dta", clear
describe
count

g year = 2011
label var year "Survey Year"

// respondent type
rename is1resptype resptype

// R1 entry cohort demographic items
rename r1dgender gender
rename rl1dracehisp race
rename el1higstschl entryed

// non-constant demographic items
rename r1d2intvrage intvage
rename hh1martlstat marstat
rename hh1dhshldnum hhsize
rename hh1dlvngarrg lvngarrg

// residential items
rename r1dresid resid
rename ht1placedesc placedesc
rename hh1placekind placekind
rename ht1retiresen retiresen
rename hp1sec8pubsn pubsnhous
rename fq1dfacdescr factype_fq
rename fq1dosfacd othfactype_fq
rename fq1dfacarea facarea_fq
rename fq1dosfaca othfacarea_fq
rename re1dcensdiv censdiv
rename r1dmetnonmet metro

// health items
rename hc1disescn1 disescn1
rename hc1disescn2 disescn2
rename hc1disescn3 disescn3
rename hc1disescn4 disescn4
rename hc1disescn5 disescn5
rename hc1disescn6 disescn6
rename hc1disescn7 disescn7
rename hc1disescn8 disescn8
rename hc1disescn9 disescn9
rename hc1disescn10 disescn10
rename hc1cancerty1 cancerty1

// Medicare items
rename mc1chginspln chginsplng
rename ip1otdrugcov otdrugcov
rename ip1covmedcad partdcov
rename ip1mgapmedsp medigap
rename ip1covtricar tricare
rename ip1cmedicaid medicaid

// income items
rename ia1totinc totalinc
rename lf1workfpay workpay
rename lf1wrkplstmn wrkplstmn

// food hardship items
rename ha1shopwout shopwout
rename ha1howpaygr5 snpebt_flg
rename ew1progneed1 snpebt

// financial hardship items
rename ha1bankwout bankwout

keep spid yearsample r1* w1* year resptype gender race entryed intvage marstat hhsize lvngarrg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* cancerty1 chginspln otdrugcov partdcov medigap tricare medicaid totalinc workpay wrkplstmn shopwout snpebt_flg snpebt bankwout

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R1_clean.dta", replace

******************************************************

* ROUND 2 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R2.dta", clear
describe
count

g year = 2012
label var year "Survey Year"

// respondent type
rename is2resptype resptype

// deceased cases
tab fl2spdied
rename fl2spdied spdied

// non-constant demographic items
rename r2d2intvrage intvage
rename hh2martlstat marstat
rename hh2marchange marchange
rename hh2dhshldnum hhsize
rename hh2dlvngarrg lvngarrg

// residential items
rename fl2resnew newres_flg
rename r2dresid resid
rename ht2placedesc placedesc
rename hh2placekind placekind
rename ht2retiresen retiresen
rename hp2sec8pubsn pubsnhous
rename fq2dfacdescr factype_fq
rename fq2dosfacd othfactype_fq
rename fq2dfacarea facarea_fq
rename fq2dosfaca othfacarea_fq
rename re2dcensdiv censdiv
rename r2dmetnonmet metro

// health items
rename hc2disescn1 disescn1
rename hc2disescn2 disescn2
rename hc2disescn3 disescn3
rename hc2disescn4 disescn4
rename hc2disescn5 disescn5
rename hc2disescn6 disescn6
rename hc2disescn7 disescn7
rename hc2disescn8 disescn8
rename hc2disescn9 disescn9
rename hc2disescn10 disescn10
* no var for cancerty1 in R2

// Medicare items
rename mc2chginspln chginsplng
rename ip2covmedcad partdcov
rename ip2mgapmedsp medigap
rename ip2otdrugcov otdrugcov
rename ip2covtricar tricare
rename ip2cmedicaid medicaid

// income items
rename lf2workfpay workpay
rename lf2wrkplstmn wrkplstmn

// food hardship items
rename ew2mealskip1 skipmeal
rename ew2mealskip2 freqskipmeal
rename ha2shopwout shopwout
rename ha2howpaygr5 snpebt_flg
rename ew2progneed1 snpebt

// financial hardship items
rename ha2bankwout bankwout
rename ew2nopayhous nopayhous
rename ew2nopayutil nopayutil

// medical-financial hardship items
rename ew2nopaymed nopaymed

keep spid yearsample r2* w2* year resptype spdied intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*
 
// new items in R2: spdied marchange newres_flg skipmeal freqskipmeal nopay*

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R2_clean.dta", replace

******************************************************

* ROUND 3 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R3.dta", clear
describe
count

g year = 2013
label var year "Survey Year"

// respondent type
rename is3resptype resptype

// deceased cases
tab fl3spdied
rename fl3spdied spdied

// non-constant demographic items
rename r3d2intvrage intvage
rename hh3dmarstat marstat
rename hh3marchange marchange
rename hh3dhshldnum hhsize
rename hh3dlvngarrg lvngarrg

// residential items
rename fl3resnew newres_flg
rename r3dresid resid
rename ht3placedesc placedesc
rename hh3placekind placekind
rename ht3retiresen retiresen
rename hp3sec8pubsn pubsnhous
rename fq3dfacdescr factype_fq
rename fq3dosfacd othfactype_fq
rename fq3dfacarea facarea_fq
rename fq3dosfaca othfacarea_fq
rename re3dcensdiv censdiv
rename r3dmetnonmet metro

// health items
rename hc3disescn1 disescn1
rename hc3disescn2 disescn2
rename hc3disescn3 disescn3
rename hc3disescn4 disescn4
rename hc3disescn5 disescn5
rename hc3disescn6 disescn6
rename hc3disescn7 disescn7
rename hc3disescn8 disescn8
rename hc3disescn9 disescn9
rename hc3disescn10 disescn10
* no var for cancerty1 in R3

// Medicare items
rename mc3chginspln chginsplng
rename ip3otdrugcov otdrugcov
rename ip3covmedcad partdcov
rename ip3mgapmedsp medigap
rename ip3covtricar tricare
rename ip3cmedicaid medicaid

// income items
rename ia3totinc totalinc
rename lf3workfpay workpay
rename lf3wrkplstmn wrkplstmn

// food hardship items
rename ew3mealskip1 skipmeal
rename ew3mealskip2 freqskipmeal
rename ha3shopwout shopwout
rename ha3howpaygr5 snpebt_flg
rename ew3progneed1 snpebt

// financial hardship items
rename ha3bankwout bankwout
rename ew3nopayhous nopayhous
rename ew3nopayutil nopayutil

// medical-financial hardship items
rename ew3nopaymed nopaymed

keep spid yearsample r3* w3* year resptype spdied intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid totalinc workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R3_clean.dta", replace

******************************************************

* ROUND 4 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R4.dta", clear
describe
count

g year = 2014
label var year "Survey Year"

// respondent type
rename is4resptype resptype

// deceased cases
tab fl4spdied
rename fl4spdied spdied

// non-constant demographic items
rename r4d2intvrage intvage
rename hh4dmarstat marstat
rename hh4marchange marchange
rename hh4dhshldnum hhsize
rename hh4dlvngarrg lvngarrg

// residential items
rename fl4resnew newres_flg
rename r4dresid resid
rename ht4placedesc placedesc
rename hh4placekind placekind
rename ht4retiresen retiresen
rename hp4sec8pubsn pubsnhous
rename fq4dfacdescr factype_fq
rename fq4dosfacd othfactype_fq
rename fq4dfacarea facarea_fq
rename fq4dosfaca othfacarea_fq
rename re4dcensdiv censdiv
rename r4dmetnonmet metro

// health items
rename hc4disescn1 disescn1
rename hc4disescn2 disescn2
rename hc4disescn3 disescn3
rename hc4disescn4 disescn4
rename hc4disescn5 disescn5
rename hc4disescn6 disescn6
rename hc4disescn7 disescn7
rename hc4disescn8 disescn8
rename hc4disescn9 disescn9
rename hc4disescn10 disescn10
rename hc4cancerty1 cancerty1

// Medicare items
rename mc4chginspln chginsplng
rename ip4otdrugcov otdrugcov
rename ip4covmedcad partdcov
rename ip4mgapmedsp medigap
rename ip4covtricar tricare
rename ip4cmedicaid medicaid

// income items
rename lf4workfpay workpay
rename lf4wrkplstmn wrkplstmn

// food hardship items
rename ew4mealskip1 skipmeal
rename ew4mealskip2 freqskipmeal
rename ha4shopwout shopwout
rename ha4howpaygr5 snpebt_flg
rename ew4progneed1 snpebt

// financial hardship items
rename ha4bankwout bankwout
rename ew4nopayhous nopayhous
rename ew4nopayutil nopayutil

// medical-financial hardship items
rename ew4nopaymed nopaymed

keep spid yearsample r4* w4* year resptype spdied intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R4_clean.dta", replace

******************************************************

* ROUND 5 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R5.dta", clear
describe
count

g year = 2015
label var year "Survey Year"

// respondent type
rename is5resptype resptype

// deceased cases
tab fl5spdied
rename fl5spdied spdied

// continuing or entering survey in R5
tab r5dcontnew

// R5 entry cohort demographic items
rename r5dgender gender
rename rl5dracehisp race
rename el5dage2us entryage
rename el5higstschl entryed

// non-constant demographic items
rename r5d2intvrage intvage
rename hh5martlstat marstat
rename hh5marchange marchange
rename hh5dhshldnum hhsize
rename hh5dlvngarrg lvngarrg

// residential items
rename fl5resnew newres_flg
rename r5dresid resid
rename ht5placedesc placedesc
rename hh5placekind placekind
rename ht5retiresen retiresen
rename hp5sec8pubsn pubsnhous
rename fq5dfacdescr factype_fq
rename fq5dosfacd othfactype_fq
rename fq5dfacarea facarea_fq
rename fq5dosfaca othfacarea_fq
rename re5dcensdiv censdiv
rename r5dmetnonmet metro

// health items
rename hc5disescn1 disescn1
rename hc5disescn2 disescn2
rename hc5disescn3 disescn3
rename hc5disescn4 disescn4
rename hc5disescn5 disescn5
rename hc5disescn6 disescn6
rename hc5disescn7 disescn7
rename hc5disescn8 disescn8
rename hc5disescn9 disescn9
rename hc5disescn10 disescn10
rename hc5cancerty1 cancerty1

// Medicare items
rename mc5chginspln chginsplng
rename ip5otdrugcov otdrugcov
rename ip5covmedcad partdcov
rename ip5mgapmedsp medigap
rename ip5covtricar tricare
rename ip5cmedicaid medicaid

// income items
rename ia5totinc totalinc
rename lf5workfpay workpay
rename lf5wrkplstmn wrkplstmn

// food hardship items
rename ew5mealskip1 skipmeal
rename ew5mealskip2 freqskipmeal
rename ha5shopwout shopwout
rename ha5howpaygr5 snpebt_flg
rename ew5progneed1 snpebt

// financial hardship items
rename ha5bankwout bankwout
rename ew5nopayhous nopayhous
rename ew5nopayutil nopayutil

// medical-financial hardship items
rename ew5nopaymed nopaymed

keep spid yearsample r5* w5* year resptype spdied r5dcontnew gender race entryed intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid totalinc workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

// new items in R5: r5dcontnew

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R5_clean.dta", replace

******************************************************

* ROUND 6 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R6.dta", clear
describe
count

g year = 2016
label var year "Survey Year"

// respondent type
rename is6resptype resptype

// deceased cases
tab fl6spdied
rename fl6spdied spdied

// non-constant demographic items
rename r6d2intvrage intvage
rename hh6dmarstat marstat
rename hh6marchange marchange
rename hh6dhshldnum hhsize
rename hh6dlvngarrg lvngarrg

// residential items
rename fl6resnew newres_flg
rename r6dresid resid
rename ht6placedesc placedesc
rename hh6placekind placekind
rename ht6retiresen retiresen
rename hp6sec8pubsn pubsnhous
rename fq6dfacdescr factype_fq
rename fq6dosfacd othfactype_fq
rename fq6dfacarea facarea_fq
rename fq6dosfaca othfacarea_fq
rename re6dcensdiv censdiv
rename r6dmetnonmet metro

// health items
rename hc6disescn1 disescn1
rename hc6disescn2 disescn2
rename hc6disescn3 disescn3
rename hc6disescn4 disescn4
rename hc6disescn5 disescn5
rename hc6disescn6 disescn6
rename hc6disescn7 disescn7
rename hc6disescn8 disescn8
rename hc6disescn9 disescn9
rename hc6disescn10 disescn10
rename hc6cancerty1 cancerty1

// Medicare items
rename mc6chginspln chginsplng
rename ip6otdrugcov otdrugcov
rename ip6covmedcad partdcov
rename ip6mgapmedsp medigap
rename ip6covtricar tricare
rename ip6cmedicaid medicaid

// income items
rename lf6workfpay workpay
rename lf6wrkplstmn wrkplstmn

// food hardship items
rename ew6mealskip1 skipmeal
rename ew6mealskip2 freqskipmeal
rename ha6shopwout shopwout
rename ha6howpaygr5 snpebt_flg
rename ew6progneed1 snpebt

// financial hardship items
rename ha6bankwout bankwout
rename ew6nopayhous nopayhous
rename ew6nopayutil nopayutil

// medical-financial hardship items
rename ew6nopaymed nopaymed

keep spid yearsample r6* w6* year resptype spdied intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R6_clean.dta", replace

******************************************************

* ROUND 7 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R7.dta", clear
describe
count

g year = 2017
label var year "Survey Year"

// respondent type
rename is7resptype resptype

// deceased cases
tab fl7spdied
rename fl7spdied spdied

// non-constant demographic items
rename r7d2intvrage intvage
rename hh7dmarstat marstat
rename hh7marchange marchange
rename hh7dhshldnum hhsize
rename hh7dlvngarrg lvngarrg

// residential items
rename fl7resnew newres_flg
rename r7dresid resid
rename ht7placedesc placedesc
rename hh7placekind placekind
rename ht7retiresen retiresen
rename hp7sec8pubsn pubsnhous
rename fq7dfacdescr factype_fq
rename fq7dosfacd othfactype_fq
rename fq7dfacarea facarea_fq
rename fq7dosfaca othfacarea_fq
rename re7dcensdiv censdiv
rename r7dmetnonmet metro

// health items
rename hc7disescn1 disescn1
rename hc7disescn2 disescn2
rename hc7disescn3 disescn3
rename hc7disescn4 disescn4
rename hc7disescn5 disescn5
rename hc7disescn6 disescn6
rename hc7disescn7 disescn7
rename hc7disescn8 disescn8
rename hc7disescn9 disescn9
rename hc7disescn10 disescn10
rename hc7cancerty1 cancerty1

// Medicare items
rename mc7chginspln chginsplng
rename ip7otdrugcov otdrugcov
rename ip7covmedcad partdcov
rename ip7mgapmedsp medigap
rename ip7covtricar tricare
rename ip7cmedicaid medicaid

// income items
rename ia7totinc totalinc
rename lf7workfpay workpay
rename lf7wrkplstmn wrkplstmn

// food hardship items
rename ew7mealskip1 skipmeal
rename ew7mealskip2 freqskipmeal
rename ha7shopwout shopwout
rename ha7howpaygr5 snpebt_flg
rename ew7progneed1 snpebt

// financial hardship items
rename ha7bankwout bankwout
rename ew7nopayhous nopayhous
rename ew7nopayutil nopayutil

// medical-financial hardship items
rename ew7nopaymed nopaymed

keep spid yearsample r7* w7* year resptype spdied intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid totalinc workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R7_clean.dta", replace

******************************************************

* ROUND 8 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R8.dta", clear
describe
count

g year = 2018
label var year "Survey Year"

// respondent type
rename is8resptype resptype

// deceased cases
tab fl8spdied
rename fl8spdied spdied

// non-constant demographic items
rename r8d2intvrage intvage
rename hh8dmarstat marstat
rename hh8marchange marchange
rename hh8dhshldnum hhsize
rename hh8dlvngarrg lvngarrg

// residential items
rename fl8resnew newres_flg
rename r8dresid resid
rename ht8placedesc placedesc
rename hh8placekind placekind
rename ht8retiresen retiresen
rename hp8sec8pubsn pubsnhous
rename fq8dfacdescr factype_fq
rename fq8dosfacd othfactype_fq
rename fq8dfacarea facarea_fq
rename fq8dosfaca othfacarea_fq
rename re8dcensdiv censdiv
rename r8dmetnonmet metro

// health items
rename hc8disescn1 disescn1
rename hc8disescn2 disescn2
rename hc8disescn3 disescn3
rename hc8disescn4 disescn4
rename hc8disescn5 disescn5
rename hc8disescn6 disescn6
rename hc8disescn7 disescn7
rename hc8disescn8 disescn8
rename hc8disescn9 disescn9
rename hc8disescn10 disescn10
rename hc8cancerty1 cancerty1

// Medicare items
rename mc8chginspln chginsplng
rename ip8otdrugcov otdrugcov
rename ip8covmedcad partdcov
rename ip8mgapmedsp medigap
rename ip8covtricar tricare
rename ip8cmedicaid medicaid

// income items
rename lf8workfpay workpay
rename lf8wrkplstmn wrkplstmn

// food hardship items
rename ew8mealskip1 skipmeal
rename ew8mealskip2 freqskipmeal
rename ha8shopwout shopwout
rename ha8howpaygr5 snpebt_flg
rename ew8progneed1 snpebt

// financial hardship items
rename ha8bankwout bankwout
rename ew8nopayhous nopayhous
rename ew8nopayutil nopayutil

// medical-financial hardship items
rename ew8nopaymed nopaymed

keep spid yearsample r8* w8* year resptype spdied intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R8_clean.dta", replace

******************************************************

* ROUND 9 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R9.dta", clear
describe
count

g year = 2019
label var year "Survey Year"

// respondent type
rename is9resptype resptype

// deceased cases
tab fl9spdied
rename fl9spdied spdied

// non-constant demographic items
rename r9d2intvrage intvage
rename hh9dmarstat marstat
rename hh9marchange marchange
rename hh9dhshldnum hhsize
rename hh9dlvngarrg lvngarrg

// residential items
rename fl9resnew newres_flg
rename r9dresid resid
rename ht9placedesc placedesc
rename hh9placekind placekind
rename ht9retiresen retiresen
rename hp9sec8pubsn pubsnhous
rename fq9dfacdescr factype_fq
rename fq9dosfacd othfactype_fq
rename fq9dfacarea facarea_fq
rename fq9dosfaca othfacarea_fq
rename re9dcensdiv censdiv
rename r9dmetnonmet metro

// health items
rename hc9disescn1 disescn1
rename hc9disescn2 disescn2
rename hc9disescn3 disescn3
rename hc9disescn4 disescn4
rename hc9disescn5 disescn5
rename hc9disescn6 disescn6
rename hc9disescn7 disescn7
rename hc9disescn8 disescn8
rename hc9disescn9 disescn9
rename hc9disescn10 disescn10
rename hc9cancerty1 cancerty1

// Medicare items
rename mc9chginspln chginsplng
rename ip9otdrugcov otdrugcov
rename ip9covmedcad partdcov
rename ip9mgapmedsp medigap
rename ip9covtricar tricare
rename ip9cmedicaid medicaid

// income items
rename ia9totinc totalinc
rename lf9workfpay workpay
rename lf9wrkplstmn wrkplstmn

// food hardship items
rename ew9mealskip1 skipmeal
rename ew9mealskip2 freqskipmeal
rename ha9shopwout shopwout
rename ha9howpaygr5 snpebt_flg
rename ew9progneed1 snpebt

// financial hardship items
rename ha9bankwout bankwout
rename ew9nopayhous nopayhous
rename ew9nopayutil nopayutil

// medical-financial hardship items
rename ew9nopaymed nopaymed

keep spid yearsample r9* w9* year resptype spdied intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid totalinc workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R9_clean.dta", replace

******************************************************

* ROUND 10 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R10.dta", clear
describe
count

g year = 2020
label var year "Survey Year"

// respondent type
rename is10resptype resptype

// deceased cases
tab fl10spdied
rename fl10spdied spdied

// non-constant demographic items
rename r10d2intvrage intvage
rename hh10dmarstat marstat
rename hh10marchange marchange
rename hh10dhshldnum hhsize
rename hh10dlvngarrg lvngarrg

// residential items
rename fl10resnew newres_flg
rename r10dresid resid
rename ht10placedesc placedesc
rename hh10placekind placekind
rename ht10retiresen retiresen
rename hp10sec8pubsn pubsnhous
rename fq10dfacdescr factype_fq
rename fq10dosfacd othfactype_fq
rename fq10dfacarea facarea_fq
rename fq10dosfaca othfacarea_fq
rename re10dcensdiv censdiv
rename r10dmetnonmet metro

// health items
rename hc10disescn1 disescn1
rename hc10disescn2 disescn2
rename hc10disescn3 disescn3
rename hc10disescn4 disescn4
rename hc10disescn5 disescn5
rename hc10disescn6 disescn6
rename hc10disescn7 disescn7
rename hc10disescn8 disescn8
rename hc10disescn9 disescn9
rename hc10disescn10 disescn10
rename hc10cancerty1 cancerty1

// Medicare items
rename mc10chginspln chginsplng
rename ip10otdrugcov otdrugcov
rename ip10covmedcad partdcov
rename ip10mgapmedsp medigap
rename ip10covtricar tricare
rename ip10cmedicaid medicaid

// income items
rename lf10workfpay workpay
rename lf10wrkplstmn wrkplstmn

// food hardship items
rename ew10mealskip1 skipmeal
rename ew10mealskip2 freqskipmeal
rename ha10shopwout shopwout
rename ha10howpaygr5 snpebt_flg
rename ew10progneed1 snpebt

// financial hardship items
rename ha10bankwout bankwout
rename ew10nopayhous nopayhous
rename ew10nopayutil nopayutil

// medical-financial hardship items
rename ew10nopaymed nopaymed

keep spid yearsample r10* w10* year resptype spdied intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R10_clean.dta", replace

******************************************************

* ROUND 11 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R11.dta", clear
describe
count

g year = 2021
label var year "Survey Year"

// respondent type
rename is11resptype resptype

// deceased cases
tab fl11spdied
rename fl11spdied spdied

// non-constant demographic items
rename r11d2intvrage intvage
rename hh11dmarstat marstat
rename hh11marchange marchange
rename hh11dhshldnum hhsize
rename hh11dlvngarrg lvngarrg

// residential items
rename fl11resnew newres_flg
rename r11dresid resid
rename ht11placedesc placedesc
rename hh11placekind placekind
rename ht11retiresen retiresen
rename hp11sec8pubsn pubsnhous
rename fq11dfacdescr factype_fq
rename fq11dosfacd othfactype_fq
rename fq11dfacarea facarea_fq
rename fq11dosfaca othfacarea_fq
rename re11dcensdiv censdiv
rename r11dmetnonmet metro

// health items
rename hc11disescn1 disescn1
rename hc11disescn2 disescn2
rename hc11disescn3 disescn3
rename hc11disescn4 disescn4
rename hc11disescn5 disescn5
rename hc11disescn6 disescn6
rename hc11disescn7 disescn7
rename hc11disescn8 disescn8
rename hc11disescn9 disescn9
rename hc11disescn10 disescn10
rename hc11cancerty1 cancerty1

// Medicare items
rename mc11chginspln chginsplng
rename ip11otdrugcov otdrugcov
rename ip11covmedcad partdcov
rename ip11mgapmedsp medigap
rename ip11covtricar tricare
rename ip11cmedicaid medicaid

// income items
rename ia11totinc totalinc
rename lf11workfpay workpay
rename lf11wrkplstmn wrkplstmn

// food hardship items
rename ew11mealskip1 skipmeal
rename ew11mealskip2 freqskipmeal
rename ha11shopwout shopwout
rename ha11howpaygr5 snpebt_flg
rename ew11progneed1 snpebt

// financial hardship items
rename ha11bankwout bankwout
rename ew11nopayhous nopayhous
rename ew11nopayutil nopayutil

// medical-financial hardship items
rename ew11nopaymed nopaymed

keep spid yearsample r11* w11* year resptype spdied intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid totalinc workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R11_clean.dta", replace

******************************************************

* ROUND 12 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R12.dta", clear
describe
count

g year = 2022
label var year "Survey Year"

// respondent type
rename is12resptype resptype

// continuing or entering survey in R12
tab r12dcontnew

// deceased cases
tab fl12spdied
rename fl12spdied spdied

// R12 entry cohort demographic items
rename r12dgender gender
rename rl12dracehisp race
rename el12dhigstschl entryed

// non-constant demographic items
rename r12d2intvrage intvage
rename hh12dmarstat marstat
rename hh12marchange marchange
rename hh12dhshldnum hhsize
rename hh12dlvngarrg lvngarrg

// residential items
rename fl12resnew newres_flg
rename r12dresid resid
rename ht12placedesc placedesc
rename hh12placekind placekind
rename ht12retiresen retiresen
rename hp12sec8pubsn pubsnhous
rename fq12dfacdescr factype_fq
rename fq12dosfacd othfactype_fq
rename fq12dfacarea facarea_fq
rename fq12dosfaca othfacarea_fq
rename re12dcensdiv censdiv
rename r12dmetnonmet metro

// health items
rename hc12disescn1 disescn1
rename hc12disescn2 disescn2
rename hc12disescn3 disescn3
rename hc12disescn4 disescn4
rename hc12disescn5 disescn5
rename hc12disescn6 disescn6
rename hc12disescn7 disescn7
rename hc12disescn8 disescn8
rename hc12disescn9 disescn9
rename hc12disescn10 disescn10
rename hc12cancerty1 cancerty1

// Medicare items
rename mc12chginspln chginsplng
rename ip12otdrugcov otdrugcov
rename ip12covmedcad partdcov
rename ip12mgapmedsp medigap
rename ip12covtricar tricare
rename ip12cmedicaid medicaid

// income items
rename ia12totinc totalinc
rename lf12workfpay workpay
rename lf12wrkplstmn wrkplstmn

// food hardship items
rename ew12mealskip1 skipmeal
rename ew12mealskip2 freqskipmeal
rename ha12shopwout shopwout
rename ha12howpaygr5 snpebt_flg
rename ew12progneed1 snpebt

// financial hardship items
rename ha12bankwout bankwout
rename ew12nopayhous nopayhous
rename ew12nopayutil nopayutil

// medical-financial hardship items
rename ew12nopaymed nopaymed

keep spid yearsample r12* w12* year resptype spdied r12dcontnew gender race entryed intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid totalinc workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

// new items in R12: r12dcontnew

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R12_clean.dta", replace

******************************************************

* ROUND 13 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R13.dta", clear
describe
count

g year = 2023
label var year "Survey Year"

// respondent type
rename is13resptype resptype

// continuing or entering survey in R5
tab r13dcontnew

// deceased cases
tab fl13spdied
rename fl13spdied spdied

// R13 entry cohort demographic items
rename r13dgender gender
rename rl13dracehisp race
rename el13dhigstschl entryed

// non-constant demographic items
rename r13d2intvrage intvage
rename hh13dmarstat marstat
rename hh13marchange marchange
rename hh13dhshldnum hhsize
rename hh13dlvngarrg lvngarrg

// residential items
rename fl13resnew newres_flg
rename r13dresid resid
rename ht13placedesc placedesc
rename hh13placekind placekind
rename ht13retiresen retiresen
rename hp13sec8pubsn pubsnhous
rename fq13dfacdescr factype_fq
rename fq13dosfacd othfactype_fq
rename fq13dfacarea facarea_fq
rename fq13dosfaca othfacarea_fq
rename re13dcensdiv censdiv
rename r13dmetnonmet metro

// health items
rename hc13disescn1 disescn1
rename hc13disescn2 disescn2
rename hc13disescn3 disescn3
rename hc13disescn4 disescn4
rename hc13disescn5 disescn5
rename hc13disescn6 disescn6
rename hc13disescn7 disescn7
rename hc13disescn8 disescn8
rename hc13disescn9 disescn9
rename hc13disescn10 disescn10
rename hc13cancerty1 cancerty1

// Medicare items
rename mc13chginspln chginsplng
rename ip13otdrugcov otdrugcov
rename ip13covmedcad partdcov
rename ip13mgapmedsp medigap
rename ip13covtricar tricare
rename ip13cmedicaid medicaid

// income items
rename ia13totinc totalinc
rename lf13workfpay workpay
rename lf13wrkplstmn wrkplstmn

// food hardship items
rename ew13mealskip1 skipmeal
rename ew13mealskip2 freqskipmeal
rename ha13shopwout shopwout
rename ha13howpaygr5 snpebt_flg
rename ew13progneed1 snpebt

// financial hardship items
rename ha13bankwout bankwout
rename ew13nopayhous nopayhous
rename ew13nopayutil nopayutil

// medical-financial hardship items
rename ew13nopaymed nopaymed

keep spid yearsample r13* w13* year resptype spdied r13dcontnew gender race entryed intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid totalinc workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

// new items in R13: r13dcontnew

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R13_clean.dta", replace

******************************************************

* ROUND 14 *
use "/Users/jennaauth/Desktop/IRP/NHATS/data/combined/R14.dta", clear
describe
count

g year = 2024
label var year "Survey Year"

// respondent type
rename is14resptype resptype

// deceased cases
tab fl14spdied
rename fl14spdied spdied

// non-constant demographic items
rename r14d2intvrage intvage
rename hh14dmarstat marstat
rename hh14marchange marchange
rename hh14dhshldnum hhsize
rename hh14dlvngarrg lvngarrg

// residential items
rename fl14resnew newres_flg
rename r14dresid resid
rename ht14placedesc placedesc
rename hh14placekind placekind
rename ht14retiresen retiresen
rename hp14sec8pubsn pubsnhous
rename fq14dfacdescr factype_fq
rename fq14dosfacd othfactype_fq
rename fq14dfacarea facarea_fq
rename fq14dosfaca othfacarea_fq
rename re14dcensdiv censdiv
rename r14dmetnonmet metro

// health items
rename hc14disescn1 disescn1
rename hc14disescn2 disescn2
rename hc14disescn3 disescn3
rename hc14disescn4 disescn4
rename hc14disescn5 disescn5
rename hc14disescn6 disescn6
rename hc14disescn7 disescn7
rename hc14disescn8 disescn8
rename hc14disescn9 disescn9
rename hc14disescn10 disescn10
rename hc14cancerty1 cancerty1

// Medicare items
rename mc14chginspln chginsplng
rename ip14otdrugcov otdrugcov
rename ip14covmedcad partdcov
rename ip14mgapmedsp medigap
rename ip14covtricar tricare
rename ip14cmedicaid medicaid

// income items
rename ia14totinc totalinc
rename lf14workfpay workpay
rename lf14wrkplstmn wrkplstmn

// food hardship items
rename ew14mealskip1 skipmeal
rename ew14mealskip2 freqskipmeal
rename ha14shopwout shopwout
rename ha14howpaygr5 snpebt_flg
rename ew14progneed1 snpebt

// financial hardship items
rename ha14bankwout bankwout
rename ew14nopayhous nopayhous
rename ew14nopayutil nopayutil

// medical-financial hardship items
rename ew14nopaymed nopaymed

keep spid yearsample r14* w14* year resptype spdied intvage marstat marchange hhsize lvngarrg newres_flg resid place* retiresen pubsnhous factype_fq facarea_fq othfac* censdiv metro disescn* chginspln otdrugcov partdcov medigap tricare medicaid totalinc workpay wrkplstmn skipmeal freqskipmeal shopwout snpebt_flg snpebt bankwout nopay*

sort spid
save "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R14_clean.dta", replace

******************************************************

******************************************************
** APPEND ROUNDS 1-14 **
******************************************************

use "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R1_clean.dta", clear
gen round = 1
label var round "Survey Round"
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R2_clean.dta"
replace round = 2 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R3_clean.dta"
replace round = 3 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R4_clean.dta"
replace round = 4 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R5_clean.dta"
replace round = 5 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R6_clean.dta"
replace round = 6 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R7_clean.dta"
replace round = 7 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R8_clean.dta"
replace round = 8 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R9_clean.dta"
replace round = 9 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R10_clean.dta"
replace round = 10 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R11_clean.dta"
replace round = 11 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R12_clean.dta"
replace round = 12 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R13_clean.dta"
replace round = 13 if round == .
count

append using "/Users/jennaauth/Desktop/IRP/NHATS/data/clean_rounds/R14_clean.dta"
replace round = 14 if round == .
count

sort spid
xtset spid round
duplicates report spid round

duplicates tag spid round, gen(dup_flag)
tab dup_flag

save "/Users/jennaauth/Desktop/IRP/NHATS/data/combined_R1-R14.dta", replace

******************************************************

******************************************************
** CLEAN COMBINED R1-R14 DATA FILE **
******************************************************

******************************************************

** HOUSEKEEPING **

sort spid round
xtset spid round
xtdesc

xtsum spid

describe
count

tab round

******************************************************

** YEAR **

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

******************************************************

** ENTRY YEAR (COHORT) **

g r1cohort = round == 1
label var r1cohort "Cohort 1 (R1)"

g r5cohort = r5dcontnew == 2
label var r5cohort "Cohort 2 (R5)"

g r12cohort = r12dcontnew == 2
label var r12cohort "Cohort 3 (R12)"

g r13cohort = r13dcontnew == 2
label var r13cohort "Cohort 4 (R13)"


g cohort = .
replace cohort = 1 if r1cohort == 1
replace cohort = 2 if r5cohort == 1
replace cohort = 3 if r12cohort == 1
replace cohort = 4 if r13cohort == 1
label var cohort "Year SP Entered Survey"
label val cohort cohort
label def cohort 1 "2011" 2 "2015" 3 "2022" 4 "2023"
tab cohort, m

global C i.cohort

******************************************************

** RESPONDENT TYPE **

recode resptype (-9/-1=.)
bysort spid (round): replace resptype = resptype[_n-1] if resptype == .
recode resptype (.=3)
label var resptype "Type of Respondent"
label val resptype resptype
label def resptype 1 "Sample Person" 2 "Proxy" 3 "N/A"
tab resptype, m


g proxy_flg = resptype == 2
label var proxy_flg "Proxy Respondent Flag"
tab proxy_flg

******************************************************

** DECEASED CASES **

recode spdied (-1 .=0) (1=1)
label var spdied "SP Died Prior to Round"
tab round spdied, m

******************************************************

** GENDER **

bysort spid (round): replace gender = gender[_n-1] if gender == .
label var gender "Gender of SP"
label val gender gender
label def gender 1 "Male" 2 "Female"
tab gender, m

g female = gender == 2
label var female "Female"

******************************************************

** RACE/ETHNICITY **

recode race (4=3) (3=4) (5 6=5) (.=.)
bysort spid (round): replace race = race[_n-1] if race == .
label var race "Race & Ethnicity of SP"
label val race race
label def race 1 "Non-Hispanic White" 2 "Non-Hispanic Black" 3 "Hispanic" 4 "Native American, Asian, Native Hawaiian, Pacific Islander, or Other" 5 "Mulitple or Unknown"
tab race, m


g white = race == 1
label var white "Non-Hispanic White"

g black = race == 2
label var black "Non-Hispanic Black"

g hispanic = race == 3
label var hispanic "Hispanic"

g otherrc = race == 4
label var otherrc "Native American, Asian, Native Hawaiian, Pacific Islander, or Other"

g multirc = race == 5
label var multirc "Multiple or Unknown Race(s)"

global R  white black hispanic otherrc multirc
global RX white black hispanic otherrc

******************************************************

** AGE **

recode intvage (-1=.)
bysort spid (round): replace intvage = intvage[_n-1] if intvage == .
label var intvage "Categorical Age of SP at Interview"
label val intvage intvage
label def intvage 1 "65-69" 2 "70-74" 3 "75-79" 4 "80-84" 5 "85-89" 6 "90+"
tab intvage, m


g under70 = intvage == 1
label var under70 "Age 65-69"

g under75 = intvage == 2
label var under75 "Age 70-74"

g under80 = intvage == 3
label var under80 "Age 75-79"

g under85 = intvage == 4
label var under85 "Age 80-84"

g under90 = intvage == 5
label var under90 "Age 85-89"

g over90 = intvage == 5
label var over90 "Age 90+"

global IA  under70 under75 under80 under85 under90 over90
global IAX under70 under75 under80 under85 under90

******************************************************

** EDUCATIONAL ATTAINMENT **

recode entryed (-9 -8 -7 -1 .=.)
bysort spid (round): replace entryed = entryed[_n-1] if entryed == .
recode entryed (.=10)
label var entryed "Highest Degree of School SP Completed at Entry"
label val entryed entryed
label def entryed 1 "No Schooling" 2 "Grade 1-8" 3 "Some High School" 4 "High School Diploma" 5 "Vocational, Tech, or Trade School" 6 "Some College, No Degree" 7 "Associate's Degree" 8 "Bachelor's Degree" 9 "Professional Degree" 10 "N/A"
tab entryed, m


g hsdrop = inlist(entryed,1,2,3)
label var hsdrop "Some High School or Lower"

g hsgrad = entryed == 4
label var hsgrad "High School Diploma"

g postsec = inlist(entryed,5,6)
label var postsec "Post-Secondary Education"

g underdeg = inlist(entryed,7,8)
label var underdeg "College Degree"

g profdeg = entryed == 9
label var profdeg "Professional Degree"

global E  hsdrop hsgrad postsec underdeg profdeg
global EX hsdrop hsgrad postsec underdeg


g educ = .
replace educ = 1 if hsdrop == 1
replace educ = 2 if hsgrad == 1
replace educ = 3 if postsec == 1
replace educ = 4 if underdeg == 1
replace educ = 5 if profdeg == 1
replace educ = 6 if entryed == 10
label var educ "Educational Attainment Recode"
label val educ educ
label def educ 1 "Some High School or Lower" 2 "High School Diploma" 3 "Post-Secondary Education" 4 "College Degree" 5 "Professional Degree" 6 "N/A"
tab educ, m

******************************************************

** MARITAL STATUS **

recode marstat (-9/-1=.)
bysort spid (round): replace marstat = marstat[_n-1] if marstat == .
recode marstat (.=7)
label var marstat "Marital Status of SP"
label val marstat marstat
label def marstat 1 "Married" 2 "Living with Partner" 3 "Separated" 4 "Divorced" 5 "Widowed" 6 "Never Married" 7 "N/A"
tab marstat, m


recode marchange (-9 -8 -7 -1 .=.)
bysort spid (round): replace marchange = marchange[_n-1] if marchange == .
recode marchange (.=3)
label var marchange "Change in SP's Marital Status"
label val marchange marchange
label def marchange 1 "Yes" 2 "No" 3 "N/A"
tab round marchange, m


g married = (marstat == 1 & marchange == 2)
label var married "Married"
tab married

******************************************************

** LIVING ARRANGEMENT **

recode lvngarrg (4=3) (3=4) (-9 -1=.)
bysort spid (round): replace lvngarrg = lvngarrg[_n-1] if lvngarrg == .
recode lvngarrg (.=5)
label var lvngarrg "SP's Living Arrangement"
label val lvngarrg lvngarrg
label def lvngarrg 1 "Alone" 2 "With Partner" 3 "With Others" 4 "With Partner and Others" 5 "N/A"
tab lvngarrg, m

g lvalone = lvngarrg == 1
label var lvalone "SP Lives Alone"
tab round lvalone


recode hhsize (-1 0=.)
bysort spid (round): replace hhsize = hhsize[_n-1] if hhsize == .
recode hhsize (.=0)
label var hhsize "Number of People Living in SP's Household"
tab hhsize, m

******************************************************

** RESIDENCE TYPE **

recode placedesc (91=5) (-9/-1=.)
bysort spid (round): replace placedesc = placedesc[_n-1] if placedesc == .
recode placedesc (.=6)
label var placedesc "Residence Description"
label val placedesc placedesc
label def placedesc 1 "Private Residence" 2 "Group Home" 3 "Assisted Living" 4 "Religious Group Quarters" 5 "Other" 6 "N/A"
tab placedesc, m

recode placekind (5=4) (91=5) (-9/-1=.)
bysort spid (round): replace placekind = placekind[_n-1] if placekind == .
recode placekind (.=6)
label var placekind "Type of Residence"
label val placekind placekind
label def placekind 1 "Private Residence" 2 "Group Home" 3 "Assisted Living" 4 "Nursing Home" 5 "Other" 6 "N/A"
tab placekind, m

recode resid (2 3 7=2) (4 5 8=3) (6=4)
label var resid "Residential Care Status"
label val resid resid
label def resid 1 "Community" 2 "Residential Care" 3 "Nursing Home" 4 "Deceased"
tab resid, m

recode retiresen (-9/-1=.)
bysort spid (round): replace retiresen = retiresen[_n-1] if retiresen == .
recode retiresen (2 .=0) (1=1)
label var retiresen "Retirement Community/Senior Housing"

recode pubsnhous (-9/-1=.)
bysort spid (round): replace pubsnhous = pubsnhous[_n-1] if pubsnhous == .
recode pubsnhous (2 .=0) (1=1)
label var pubsnhous "Public Senior Housing (HME Section 8)"

recode factype_fq (-9 -8 -7 -1 10=.)
bysort spid (round): replace factype_fq = factype_fq[_n-1] if factype_fq == .
recode factype_fq (91=9) (.=10)
label var factype_fq "Living Facility Type"
label val factype_fq factype_fq
label def factype_fq 1 "Nursing Home" 2 "Assisted Living" 3 "Nursing Home and Assisted Living Facility" 4 "Continuing Care Community" 5 "Adult Family Care Home" 6 "Group Home" 7 "Board and Care Home" 8 "Retirement Community or Senior Housing" 9 "Other (Specify)" 10 "N/A"
tab factype_fq, m

recode othfactype_fq (-9/-1=.)
bysort spid (round): replace othfactype_fq = othfactype_fq[_n-1] if othfactype_fq == .
recode othfactype_fq (.=12)
label var othfactype_fq "Specify Other Living Facility Type"
label val othfactype_fq othfactype_fq
label def othfactype_fq 1 "Nursing Home" 2 "Assisted Living" 3 "Nursing Home and Assisted Living Facility" 4 "Continuing Care Community" 5 "Adult Family Care Home" 6 "Group Home" 7 "Board and Care Home" 8 "Retirement Community or Senior Housing" 9 "Independent Living" 10 "Assisted and Independent Retirement Housing" 11 "Housing (Apt, Condo, etc.)" 12 "N/A"
tab othfactype_fq, m

recode facarea_fq (-9/-1=.)
bysort spid (round): replace facarea_fq = facarea_fq[_n-1] if facarea_fq == .
recode facarea_fq (91=5) (.=6)
label var facarea_fq "Living Facility Area"
label val facarea_fq facarea_fq
label def facarea_fq 1 "Independent Living" 2 "Assisted Living" 3 "Special or Memory Care" 4 "Nursing Home" 5 "Other (Specify)" 6 "N/A"
tab facarea_fq, m

recode othfacarea_fq (-9/-1=.)
bysort spid (round): replace othfacarea_fq = othfacarea_fq[_n-1] if othfacarea_fq == .
recode othfacarea_fq (.=5)
label var othfacarea_fq "Specify Other Living Facility Area"
label val othfacarea_fq othfacarea_fq
label def othfacarea_fq 1 "Independent Living" 2 "Assisted Living" 3 "Special or Memory Care" 4 "Nursing Home" 5 "N/A"
tab othfacarea_fq, m


g privres = resid == 1 & (placedesc == 1 | placekind == 1 | othfactype_fq == 9 | othfactype_fq == 11 | facarea_fq == 1 | othfacarea_fq == 1)
label var privres "Private Residence"

g seniorhous = resid == 1 & (retiresen == 1 | factype_fq == 8 | othfactype_fq == 8)
label var seniorhous "Retirement Community"

g rescarehm = resid == 2 & (placedesc == 2 | placekind == 2 | factype_fq == 5 | othfactype_fq == 5 | factype_fq == 6 | othfactype_fq == 6 | factype_fq == 7 | othfactype_fq == 7)
label var rescarehm "Residential Care Home"

g asstlvng = (placedesc == 3 | placekind == 3 | factype_fq == 2 | othfactype_fq == 2 | facarea_fq == 2 | othfacarea_fq == 2)
label var asstlvng "Assisted Living"

g nursinghm = (placekind == 4 | resid == 3 | factype_fq == 1 | othfactype_fq == 1 | factype_fq == 3 | othfactype_fq == 3 | facarea_fq == 3 | othfacarea_fq == 3 | facarea_fq == 4 | othfacarea_fq == 4)
label var nursinghm "Nursing or Special Care Home"


g residtype = .
replace residtype = 1 if privres == 1
replace residtype = 2 if pubsnhous == 1
replace residtype = 3 if seniorhous == 1
replace residtype = 4 if rescarehm == 1
replace residtype = 5 if asstlvng == 1
replace residtype = 6 if nursinghm == 1
bysort spid (round): replace residtype = residtype[_n-1] if residtype == .
replace residtype = 7 if residtype == .
label var residtype "Type of Residence Recode"
label val residtype residtype
label def residtype 1 "Private" 2 "Public Senior Housing" 3 "Retirement Community" 4 "Residential Care Home" 5 "Assisted Living" 6 "Nursing or Special Care Home" 7 "N/A"
tab residtype, m

g indpdntlv = 1 if inlist(residtype,1,2,3)
label var indpdntlv "Independent Living"
tab indpdntlv, m
tab round indpdntlv

******************************************************

** CENSUS DIVISION **

recode censdiv (-9=10)
label var censdiv "Census Division SP Resides In"
label val censdiv censdiv
label def censdiv 1 "New England" 2 "Mid Atlantic" 3 "Northeast Midwest" 4 "Northwest Midwest" 5 "South Atlantic" 6 "Southeast Central" 7 "Southwest Central" 8 "West Mountain" 9 "West Pacific" 10 "N/A"
tab censdiv, m


g newengland = censdiv == 1
label var newengland "New England Census Division: ME, NH, VT, MA, RI, CT"
tab round newengland

g midatlantic = censdiv == 2
label var midatlantic "Mid Atlantic Census Division: NY, NJ, PA"
tab round midatlantic

g ne_mwcentr = censdiv == 3
label var ne_mwcentr "Northeast Midwest Census Division: OH, IN, IL, MI, WI"
tab round ne_mwcentr

g nw_mwcentr = censdiv == 4
label var nw_mwcentr "Northwest Midwest Census Division: MN, IA, MO, ND, SD, NE, KS"
tab round nw_mwcentr

g satlantic = censdiv == 5
label var satlantic "South Atlantic Census Division: DE, MD, DC, VA, WV, NC, SC, GA, FL"
tab round satlantic

g se_centr = censdiv == 6
label var se_centr "Southeast Central Census Division: KY, TN, AL, MS"
tab round se_centr

g sw_centr = censdiv == 7
label var sw_centr "Southwest Central Census Division: AR, LA, OK, TX"
tab round sw_centr

g wmountain = censdiv == 8
label var wmountain "West Mountain Census Division: MT, ID, WY, CO, NM, AZ, UT NV"
tab round wmountain

g wpacific = censdiv == 9
label var wpacific "West Pacific Census Division: WA, OR, CA, AK, HI"
tab round wpacific

global D  newengland midatlantic ne_mwcentr nw_mwcentr satlantic se_centr sw_centr wmountain wpacific 
global DX newengland midatlantic ne_mwcentr nw_mwcentr satlantic          sw_centr wmountain wpacific

******************************************************

** METROPOLITAN RESIDENCE STATUS **

recode metro (2=0) (1=1)
label var metro "SP's Metropolitan Residence Status"
label val metro metro
label def metro 0 "Non-metropolitan" 1 "Metropolitan"
tab metro, m

******************************************************

** HEALTH CONDITIONS **

recode disescn* (-9/-1=.)
bysort spid (round): replace disescn1 = disescn1[_n-1] if disescn1 == .
bysort spid (round): replace disescn2 = disescn2[_n-1] if disescn2 == .
bysort spid (round): replace disescn3 = disescn3[_n-1] if disescn3 == .
bysort spid (round): replace disescn4 = disescn4[_n-1] if disescn4 == .
bysort spid (round): replace disescn5 = disescn5[_n-1] if disescn5 == .
bysort spid (round): replace disescn6 = disescn6[_n-1] if disescn6 == .
bysort spid (round): replace disescn7 = disescn7[_n-1] if disescn7 == .
bysort spid (round): replace disescn8 = disescn8[_n-1] if disescn8 == .
bysort spid (round): replace disescn9 = disescn9[_n-1] if disescn9 == .
bysort spid (round): replace disescn10 = disescn10[_n-1] if disescn10 == .
recode disescn* (2 .=0) (1=1)

recode cancerty1 (-9/-1=.)
bysort spid (round): replace cancerty1 = cancerty1[_n-1] if cancerty1 == .
recode cancerty1 (2 .=0) (1=1)

g disescn10r = (disescn10 == 1 | cancerty1 == 1)
label var disescn10r "Cancer Recode"


g hlthcond = .
replace hlthcond = 1 if disescn1 == 1
replace hlthcond = 2 if disescn2 == 1
replace hlthcond = 3 if disescn3 == 1
replace hlthcond = 4 if disescn4 == 1
replace hlthcond = 5 if disescn5 == 1
replace hlthcond = 6 if disescn6 == 1
replace hlthcond = 7 if disescn7 == 1
replace hlthcond = 8 if disescn8 == 1
replace hlthcond = 9 if disescn9 == 1
replace hlthcond = 10 if disescn10r == 1
bysort spid (round): replace hlthcond = hlthcond[_n-1] if hlthcond == .
recode hlthcond (.=11)
label var hlthcond "Health Conditions"
label val hlthcond hlthcond
label def hlthcond 1 "Heart Attack" 2 "Heart Disease" 3 "Hypertension" 4 "Arthritis" 5 "Osteoporosis" 6 "Diabetes" 7 "Lung Disease" 8 "Stroke" 9 "Dementia or Alzheimers" 10 "Cancer" 11 "N/A"
tab hlthcond, m


local hlthcond " disescn1 disescn2 disescn3 disescn4 disescn5 disescn6 disescn7 disescn8 disescn9 disescn10r "

g numhlthcond = disescn1+disescn2+disescn3+disescn4+disescn5+disescn6+disescn7+disescn8+disescn9+disescn10r
label var numhlthcond "Number of Health Conditions"
sum numhlthcond
tab numhlthcond

g hlthcondev = numhlthcond >= 1
label var hlthcondev "Have Health Condition(s)"
tab hlthcondev

egen meanhlthcondev = mean(hlthcondev)

local total_count = 0
local num_vars = 0

foreach var of local hlthcond {
	count if `var' == 1
	local count_`var' = r(N)
	local total_count = `total_count' + r(N)
	local num_vars = `num_vars' + 1
	display "`var': `r(N)' SP's have this condition"
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
tab totalhcond

******************************************************

** WORKING/EMPLOYMENT STATUS **

recode workpay (-9/-1=.)
bysort spid (round): replace workpay = workpay[_n-1] if workpay == .
tab workpay, m

recode wrkplstmn (-9/-1=.)
bysort spid (round): replace wrkplstmn = wrkplstmn[_n-1] if wrkplstmn == .
tab wrkplstmn, m


g work4pay = (workpay == 1 | wrkplstmn == 1)
label var work4pay "SP Recently Worked for Pay"
tab work4pay, m

******************************************************

** INCOME **

recode totalinc (-9 -8 -7 -1 .=.)
bysort spid (round): replace totalinc = totalinc[_n-1] if totalinc == .
label var totalinc "Total Income"
tab totalinc, m

******************************************************

** FPL & POVERTY TO INCOME RATIO (PIR) **

* calcualted using annual HHS Poverty Guidelines

/// 2011
g fpl_threshold = .
replace fpl_threshold = 10890 if year == 2011 & hhsize == 1
replace fpl_threshold = 14710 if year == 2011 & hhsize == 2
replace fpl_threshold = 18530 if year == 2011 & hhsize == 3
replace fpl_threshold = 22350 if year == 2011 & hhsize == 4
replace fpl_threshold = 26170 if year == 2011 & hhsize == 5
replace fpl_threshold = 29990 if year == 2011 & hhsize == 6
replace fpl_threshold = 33810 if year == 2011 & hhsize == 7
replace fpl_threshold = 37630 if year == 2011 & hhsize == 8
* for households over 8, add 3820 for each additional person
replace fpl_threshold = 41450 if year == 2011 & hhsize == 9
replace fpl_threshold = 45270 if year == 2011 & hhsize == 10
replace fpl_threshold = 49090 if year == 2011 & hhsize == 11
replace fpl_threshold = 52910 if year == 2011 & hhsize == 12
replace fpl_threshold = 56730 if year == 2011 & hhsize == 13
replace fpl_threshold = 60550 if year == 2011 & hhsize == 14

/// 2012
replace fpl_threshold = 11170 if year == 2012 & hhsize == 1
replace fpl_threshold = 15130 if year == 2012 & hhsize == 2
replace fpl_threshold = 19090 if year == 2012 & hhsize == 3
replace fpl_threshold = 23050 if year == 2012 & hhsize == 4
replace fpl_threshold = 27010 if year == 2012 & hhsize == 5
replace fpl_threshold = 30970 if year == 2012 & hhsize == 6
replace fpl_threshold = 34930 if year == 2012 & hhsize == 7
replace fpl_threshold = 38890 if year == 2012 & hhsize == 8
* for households over 8, add 3960 for each additional person
replace fpl_threshold = 42850 if year == 2012 & hhsize == 9
replace fpl_threshold = 46810 if year == 2012 & hhsize == 10
replace fpl_threshold = 50770 if year == 2012 & hhsize == 11
replace fpl_threshold = 54730 if year == 2012 & hhsize == 12
replace fpl_threshold = 58690 if year == 2012 & hhsize == 13
replace fpl_threshold = 62650 if year == 2012 & hhsize == 14

/// 2013
replace fpl_threshold = 11490 if year == 2013 & hhsize == 1
replace fpl_threshold = 15510 if year == 2013 & hhsize == 2
replace fpl_threshold = 19530 if year == 2013 & hhsize == 3
replace fpl_threshold = 23550 if year == 2013 & hhsize == 4
replace fpl_threshold = 27570 if year == 2013 & hhsize == 5
replace fpl_threshold = 31590 if year == 2013 & hhsize == 6
replace fpl_threshold = 35610 if year == 2013 & hhsize == 7
replace fpl_threshold = 39630 if year == 2013 & hhsize == 8
* for households over 8, add 4020 for each additional person
replace fpl_threshold = 43650 if year == 2013 & hhsize == 9
replace fpl_threshold = 47670 if year == 2013 & hhsize == 10
replace fpl_threshold = 51690 if year == 2013 & hhsize == 11
replace fpl_threshold = 55710 if year == 2013 & hhsize == 12
replace fpl_threshold = 59730 if year == 2013 & hhsize == 13
replace fpl_threshold = 63750 if year == 2013 & hhsize == 14

/// 2014
replace fpl_threshold = 11670 if year == 2014 & hhsize == 1
replace fpl_threshold = 15730 if year == 2014 & hhsize == 2
replace fpl_threshold = 19790 if year == 2014 & hhsize == 3
replace fpl_threshold = 23850 if year == 2014 & hhsize == 4
replace fpl_threshold = 27910 if year == 2014 & hhsize == 5
replace fpl_threshold = 31970 if year == 2014 & hhsize == 6
replace fpl_threshold = 36030 if year == 2014 & hhsize == 7
replace fpl_threshold = 40090 if year == 2014 & hhsize == 8
* for households over 8, add 4060 for each additional person
replace fpl_threshold = 44150 if year == 2014 & hhsize == 9
replace fpl_threshold = 48210 if year == 2014 & hhsize == 10
replace fpl_threshold = 52270 if year == 2014 & hhsize == 11
replace fpl_threshold = 56330 if year == 2014 & hhsize == 12
replace fpl_threshold = 60390 if year == 2014 & hhsize == 13
replace fpl_threshold = 64450 if year == 2014 & hhsize == 14

/// 2015
replace fpl_threshold = 11770 if year == 2015 & hhsize == 1
replace fpl_threshold = 15930 if year == 2015 & hhsize == 2
replace fpl_threshold = 20090 if year == 2015 & hhsize == 3
replace fpl_threshold = 24250 if year == 2015 & hhsize == 4
replace fpl_threshold = 28410 if year == 2015 & hhsize == 5
replace fpl_threshold = 32570 if year == 2015 & hhsize == 6
replace fpl_threshold = 36730 if year == 2015 & hhsize == 7
replace fpl_threshold = 40890 if year == 2015 & hhsize == 8
* for households over 8, add 4160 for each additional person
replace fpl_threshold = 45050 if year == 2015 & hhsize == 9
replace fpl_threshold = 49210 if year == 2015 & hhsize == 10
replace fpl_threshold = 53370 if year == 2015 & hhsize == 11
replace fpl_threshold = 57530 if year == 2015 & hhsize == 12
replace fpl_threshold = 61690 if year == 2015 & hhsize == 13
replace fpl_threshold = 65850 if year == 2015 & hhsize == 14

/// 2016
replace fpl_threshold = 11880 if year == 2016 & hhsize == 1
replace fpl_threshold = 16020 if year == 2016 & hhsize == 2
replace fpl_threshold = 20160 if year == 2016 & hhsize == 3
replace fpl_threshold = 24300 if year == 2016 & hhsize == 4
replace fpl_threshold = 28440 if year == 2016 & hhsize == 5
replace fpl_threshold = 32580 if year == 2016 & hhsize == 6
replace fpl_threshold = 36730 if year == 2016 & hhsize == 7
replace fpl_threshold = 40890 if year == 2016 & hhsize == 8
* for households over 8, add 4160 for each additional person
replace fpl_threshold = 45050 if year == 2016 & hhsize == 9
replace fpl_threshold = 49210 if year == 2016 & hhsize == 10
replace fpl_threshold = 53370 if year == 2016 & hhsize == 11
replace fpl_threshold = 57530 if year == 2016 & hhsize == 12
replace fpl_threshold = 61690 if year == 2016 & hhsize == 13
replace fpl_threshold = 65850 if year == 2016 & hhsize == 14

/// 2017
replace fpl_threshold = 12060 if year == 2017 & hhsize == 1
replace fpl_threshold = 16240 if year == 2017 & hhsize == 2
replace fpl_threshold = 20420 if year == 2017 & hhsize == 3
replace fpl_threshold = 24600 if year == 2017 & hhsize == 4
replace fpl_threshold = 28780 if year == 2017 & hhsize == 5
replace fpl_threshold = 32960 if year == 2017 & hhsize == 6
replace fpl_threshold = 37140 if year == 2017 & hhsize == 7
replace fpl_threshold = 41320 if year == 2017 & hhsize == 8
* for households over 8, add 4180 for each additional person
replace fpl_threshold = 45500 if year == 2017 & hhsize == 9
replace fpl_threshold = 49680 if year == 2017 & hhsize == 10
replace fpl_threshold = 53860 if year == 2017 & hhsize == 11
replace fpl_threshold = 58040 if year == 2017 & hhsize == 12
replace fpl_threshold = 62220 if year == 2017 & hhsize == 13
replace fpl_threshold = 66400 if year == 2017 & hhsize == 14

/// 2018
replace fpl_threshold = 12140 if year == 2018 & hhsize == 1
replace fpl_threshold = 16460 if year == 2018 & hhsize == 2
replace fpl_threshold = 20780 if year == 2018 & hhsize == 3
replace fpl_threshold = 25100 if year == 2018 & hhsize == 4
replace fpl_threshold = 29420 if year == 2018 & hhsize == 5
replace fpl_threshold = 33740 if year == 2018 & hhsize == 6
replace fpl_threshold = 38060 if year == 2018 & hhsize == 7
replace fpl_threshold = 42380 if year == 2018 & hhsize == 8
* for households over 8, add 4320 for each additional person
replace fpl_threshold = 46700 if year == 2018 & hhsize == 9
replace fpl_threshold = 51020 if year == 2018 & hhsize == 10
replace fpl_threshold = 55340 if year == 2018 & hhsize == 11
replace fpl_threshold = 59660 if year == 2018 & hhsize == 12
replace fpl_threshold = 63980 if year == 2018 & hhsize == 13
replace fpl_threshold = 68300 if year == 2018 & hhsize == 14

/// 2019
replace fpl_threshold = 12490 if year == 2019 & hhsize == 1
replace fpl_threshold = 16910 if year == 2019 & hhsize == 2
replace fpl_threshold = 21330 if year == 2019 & hhsize == 3
replace fpl_threshold = 25750 if year == 2019 & hhsize == 4
replace fpl_threshold = 30170 if year == 2019 & hhsize == 5
replace fpl_threshold = 34590 if year == 2019 & hhsize == 6
replace fpl_threshold = 39010 if year == 2019 & hhsize == 7
replace fpl_threshold = 43430 if year == 2019 & hhsize == 8
* for households over 8, add 4420 for each additional person
replace fpl_threshold = 47850 if year == 2019 & hhsize == 9
replace fpl_threshold = 52270 if year == 2019 & hhsize == 10
replace fpl_threshold = 56690 if year == 2019 & hhsize == 11
replace fpl_threshold = 61110 if year == 2019 & hhsize == 12
replace fpl_threshold = 65530 if year == 2019 & hhsize == 13
replace fpl_threshold = 69950 if year == 2019 & hhsize == 14

/// 2020
replace fpl_threshold = 12760 if year == 2020 & hhsize == 1
replace fpl_threshold = 17240 if year == 2020 & hhsize == 2
replace fpl_threshold = 21720 if year == 2020 & hhsize == 3
replace fpl_threshold = 26200 if year == 2020 & hhsize == 4
replace fpl_threshold = 30680 if year == 2020 & hhsize == 5
replace fpl_threshold = 35160 if year == 2020 & hhsize == 6
replace fpl_threshold = 39640 if year == 2020 & hhsize == 7
replace fpl_threshold = 44120 if year == 2020 & hhsize == 8
* for households over 8, add 4480 for each additional person
replace fpl_threshold = 48600 if year == 2020 & hhsize == 9
replace fpl_threshold = 53080 if year == 2020 & hhsize == 10
replace fpl_threshold = 57560 if year == 2020 & hhsize == 11
replace fpl_threshold = 62040 if year == 2020 & hhsize == 12
replace fpl_threshold = 66520 if year == 2020 & hhsize == 13
replace fpl_threshold = 71000 if year == 2020 & hhsize == 14

/// 2021
replace fpl_threshold = 12880 if year == 2021 & hhsize == 1
replace fpl_threshold = 17420 if year == 2021 & hhsize == 2
replace fpl_threshold = 21960 if year == 2021 & hhsize == 3
replace fpl_threshold = 26500 if year == 2021 & hhsize == 4
replace fpl_threshold = 31040 if year == 2021 & hhsize == 5
replace fpl_threshold = 35580 if year == 2021 & hhsize == 6
replace fpl_threshold = 40120 if year == 2021 & hhsize == 7
replace fpl_threshold = 44660 if year == 2021 & hhsize == 8
* for households over 8, add 4540 for each additional person
replace fpl_threshold = 49200 if year == 2021 & hhsize == 9
replace fpl_threshold = 53740 if year == 2021 & hhsize == 10
replace fpl_threshold = 58280 if year == 2021 & hhsize == 11
replace fpl_threshold = 62820 if year == 2021 & hhsize == 12
replace fpl_threshold = 67360 if year == 2021 & hhsize == 13
replace fpl_threshold = 71900 if year == 2021 & hhsize == 14

/// 2022
replace fpl_threshold = 13590 if year == 2022 & hhsize == 1
replace fpl_threshold = 18310 if year == 2022 & hhsize == 2
replace fpl_threshold = 23030 if year == 2022 & hhsize == 3
replace fpl_threshold = 27750 if year == 2022 & hhsize == 4
replace fpl_threshold = 32470 if year == 2022 & hhsize == 5
replace fpl_threshold = 37190 if year == 2022 & hhsize == 6
replace fpl_threshold = 41910 if year == 2022 & hhsize == 7
replace fpl_threshold = 46630 if year == 2022 & hhsize == 8
* for households over 8, add 4720 for each additional person
replace fpl_threshold = 51350 if year == 2022 & hhsize == 9
replace fpl_threshold = 56070 if year == 2022 & hhsize == 10
replace fpl_threshold = 60790 if year == 2022 & hhsize == 11
replace fpl_threshold = 65510 if year == 2022 & hhsize == 12
replace fpl_threshold = 70230 if year == 2022 & hhsize == 13
replace fpl_threshold = 74950 if year == 2022 & hhsize == 14

/// 2023
replace fpl_threshold = 14580 if year == 2023 & hhsize == 1
replace fpl_threshold = 19720 if year == 2023 & hhsize == 2
replace fpl_threshold = 24860 if year == 2023 & hhsize == 3
replace fpl_threshold = 30000 if year == 2023 & hhsize == 4
replace fpl_threshold = 35140 if year == 2023 & hhsize == 5
replace fpl_threshold = 40280 if year == 2023 & hhsize == 6
replace fpl_threshold = 45420 if year == 2023 & hhsize == 7
replace fpl_threshold = 50560 if year == 2023 & hhsize == 8
* for households over 8, add 5140 for each additional person
replace fpl_threshold = 55700 if year == 2023 & hhsize == 9
replace fpl_threshold = 60840 if year == 2023 & hhsize == 10
replace fpl_threshold = 65980 if year == 2023 & hhsize == 11
replace fpl_threshold = 71120 if year == 2023 & hhsize == 12
replace fpl_threshold = 76260 if year == 2023 & hhsize == 13
replace fpl_threshold = 81400 if year == 2023 & hhsize == 14

/// 2024
replace fpl_threshold = 15060 if year == 2024 & hhsize == 1
replace fpl_threshold = 20440 if year == 2024 & hhsize == 2
replace fpl_threshold = 25820 if year == 2024 & hhsize == 3
replace fpl_threshold = 31200 if year == 2024 & hhsize == 4
replace fpl_threshold = 36580 if year == 2024 & hhsize == 5
replace fpl_threshold = 41960 if year == 2024 & hhsize == 6
replace fpl_threshold = 47340 if year == 2024 & hhsize == 7
replace fpl_threshold = 52720 if year == 2024 & hhsize == 8
* for households over 8, add 5380 for each additional person
replace fpl_threshold = 58100 if year == 2024 & hhsize == 9
replace fpl_threshold = 63480 if year == 2024 & hhsize == 10
replace fpl_threshold = 68860 if year == 2024 & hhsize == 11
replace fpl_threshold = 74240 if year == 2024 & hhsize == 12
replace fpl_threshold = 79620 if year == 2024 & hhsize == 13
replace fpl_threshold = 85000 if year == 2024 & hhsize == 14


g fpl_ratio = totalinc / fpl_threshold

g lowinc = fpl_ratio < 2 if !missing(fpl_ratio)
label var lowinc "Low Income"
tab lowinc, m


recode totalinc (min/0=.), gen(income)
replace income=income/1000
label var income "Income (000)"
gen lninc=log(income)
la var lninc "Log Income"

******************************************************

** FOOD ASSISTANCE **

recode snpebt (-9/-1=.)
bysort spid (round): replace snpebt = snpebt[_n-1] if snpebt == .
recode snpebt (2 .=0) (1=1)

recode snpebt_flg (-9/-1=.)
bysort spid (round): replace snpebt_flg = snpebt_flg[_n-1] if snpebt_flg == .
recode snpebt_flg (2 .=0) (1=1)

g foodstamps = (snpebt == 1 | snpebt_flg == 1)
label var foodstamps "Food Stamp Recipient"
tab foodstamps, m

******************************************************

******************************************************
** TREATMENT VARIABLES **
******************************************************

** FOOD HARDSHIP **

recode shopwout (-9/-1=.)
bysort spid (round): replace shopwout = shopwout[_n-1] if shopwout == .
recode shopwout (2 .=0) (1=1)
label var shopwout "Ever Go Without Groceries"
label val shopwout shopwout
label def shopwout 0 "0" 1 "1"
tab shopwout, m

recode skipmeal (-9/-1=.)
bysort spid (round): replace skipmeal = skipmeal[_n-1] if skipmeal == .
recode skipmeal (2 .=0) (1=1)
label var skipmeal "Skipped Meals, No Money"
label val skipmeal skipmeal
label def skipmeal 0 "0" 1 "1"
tab skipmeal, m

recode freqskipmeal (-9/-1=.)
bysort spid (round): replace freqskipmeal = freqskipmeal[_n-1] if freqskipmeal == .
recode freqskipmeal (.=0) (1=4) (2=3) (3=2) (4=1)
label var freqskipmeal "Skip Meals How Often"
label val freqskipmeal freqskipmeal
label def freqskipmeal 0 "N/A" 1 "A Few Days" 2 "Several Days" 3 "More Than Half the Days" 4 "Nearly Every Day"
tab freqskipmeal, m


g hi_freqskipmeal = inlist(freqskipmeal,2,3,4)
label var hi_freqskipmeal "Frequently Skips Meals"

g fhscore = shopwout+skipmeal+hi_freqskipmeal
label var fhscore "Total Food Hardships"
tab fhscore


g foodhardshp = fhscore >= 1
label var foodhardshp "Severe Food Hardship"
tab foodhardshp

******************************************************

** FINANCIAL HARDSHIPS **

recode bankwout (-9/-1=.)
bysort spid (round): replace bankwout = bankwout[_n-1] if bankwout == .
recode bankwout (2 .=0) (1=1)
label val bankwout bankwout
label def bankwout 0 "0" 1 "1"
label var bankwout "Ever Go Without Paying Bills"
tab bankwout, m

recode nopayhous (-9/-1=.)
bysort spid (round): replace nopayhous = nopayhous[_n-1] if nopayhous == .
recode nopayhous (2 .=0) (1=1)
label val nopayhous nopayhous
label def nopayhous 0 "0" 1 "1"
label var nopayhous "No Money for Housing"
tab nopayhous, m

recode nopayutil (-9/-1=.)
bysort spid (round): replace nopayutil = nopayutil[_n-1] if nopayutil == .
recode nopayutil (2 .=0) (1=1)
label val nopayutil nopayutil
label def nopayutil 0 "0" 1 "1"
label var nopayutil "No Money for Utilities"
tab nopayutil, m


g numfhardshp = bankwout+nopayhous+nopayutil
label var numfhardshp "Total Financial Hardships"
tab numfhardshp

g finhardshp = numfhardshp >= 1
label var finhardshp "Financial Hardship"
tab finhardshp

******************************************************

** MEDICAL HARDSHIPS **

tab nopaymed, m

recode nopaymed (-9/-1=.)
bysort spid (round): replace nopaymed = nopaymed[_n-1] if nopaymed == .
recode nopaymed (2 .=0) (1=1)
label val nopaymed nopaymed
label def nopaymed 0 "0" 1 "1"
label var nopaymed "Medical-Financial Hardship"
tab nopaymed, m

******************************************************

** MEDICARE COVERAGE **

recode medicaid (-9/-1=.)
bysort spid (round): replace medicaid = medicaid[_n-1] if medicaid == .
recode medicaid (2 .=0) (1=1)
tab medicaid, m

drop if medicaid == 1


recode partdcov (-9/-1=.)
bysort spid (round): replace partdcov = partdcov[_n-1] if partdcov == .
recode partdcov (2 .=0) (1=1)

recode otdrugcov (-9/-1=.)
bysort spid (round): replace otdrugcov = otdrugcov[_n-1] if otdrugcov == .
recode otdrugcov (2 .=0) (1=1)

recode tricare (-9/-1=.)
bysort spid (round): replace tricare = tricare[_n-1] if tricare == .
recode tricare (2 .=0) (1=1)


recode medigap (-9/-1=.)
bysort spid (round): replace medigap = medigap[_n-1] if medigap == .
recode medigap (2 .=0) (1=1)
label var medigap "Medigap Coverage"
label val medigap medigap
label def medigap 0 "0" 1 "1"
tab medigap, m

g othinscov = medigap == 0
label var othinscov "Other Health Care Coverage"


g mcpts = .
replace mcpts = 1 if medigap == 1
replace mcpts = 2 if partdcov == 1
replace mcpts = 3 if otdrugcov == 1
replace mcpts = 4 if tricare == 1
label val mcpts mcpts
label define mcpts 1 "Medigap" 2 "Medicare Part D" 3 "Other Drug Coverage" 4 "VA Care"
label var mcpts "Categorical Health Care Coverage Type"
tab mcpts, m

drop if mcpts == .

******************************************************

save "/Users/jennaauth/Desktop/IRP/NHATS/data/NHATS_PPAR_clean.dta", replace

******************************************************

******************************************************
** ANALYSIS **
******************************************************

cd "/Users/jennaauth/Desktop/IRP/NHATS/nhats_output"

xtset spid round
xtdesc

******************************************************

** WEIGHTS **

g weight = .
forvalues r = 1/14 {
	replace weight = w`r'trfinwgt0 if round == `r'
}
label var weight "Full Final Weight (Full Tracker)"
count if weight == .
count if missing(weight)
describe weight

bysort year: sum weight
bysort round: sum weight

******************************************************

** SVYSET PSTRAT **

g varunit = .
g varstrat = .
forvalues r = 1/14 {
	replace varunit = w`r'varunit if round == `r'
	replace varstrat = w`r'varstrat if round == `r'
}
count if varunit == .
describe varunit
count if varstrat == .
describe varstrat

******************************************************

** SURVEY PREP **

svyset varunit [pweight=weight], strata(varstrat)
forvalues r = 1/14 {
    svy: mean medigap if round == `r'
}

******************************************************

** DEFINE GLOBAL MACROS **

// survey year
global Y  y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14
global YX y1 y2 y3 y4 y5 y6 y7 y8 y9     y11 y12 y13 y14

// cohort
global C i.cohort

// race
global R  white black hispanic otherrc multirc
global RX white black hispanic otherrc

// categorical interview age
global IA  under70 under75 under80 under85 under90 over90
global IAX under70 under75 under80 under85 under90

// categorical educational attainment
global E  hsdrop hsgrad postsec underdeg profdeg
global EX hsdrop hsgrad postsec underdeg

// census division
global D  newengland midatlantic ne_mwcentr nw_mwcentr satlantic sw_centr wmountain wpacific se_centr
global DX newengland midatlantic ne_mwcentr nw_mwcentr satlantic sw_centr wmountain wpacific

// Medicare coverage parts
global MC medigap othinscov

// non-constant controls
global X $IA married lvalone metro work4pay lninc hlthcondev

******************************************************

******************************************************
** SUMMARY STATISTICS **
******************************************************

** Table 1b: NHATS Coverage Rate by Year with Full Panel

est clear

foreach num of numlist 2011/2024 {
    estpost tabstat $MC if year == `num' , statistics(mean) columns(statistics)
    eststo est`num'
}

esttab * using table1b_sumstats_nhats.rtf, cells(mean(fmt(%9.3fc) label(mean)) ) compress unstack  ///
 mtitles("2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" "2020" "2021" "2022" "2023" "2024") ///
label replace nogaps title("Table 1: Medicare Coverage by Year") ///
 addnote("NHATS 2011-2024.")

est clear

******************************************************

** TABLE 2b: NHATS Demographic Summary Statistics (mean) by Medicare Coverage, 2011 Cohort

foreach var of varlist $MC {
    estpost tabstat $IA $RX $E female married lvalone metro work4pay lninc foodstamps if `var' == 1 & cohort == 1, statistics(mean) columns(statistics)
    eststo est_`var'
}

esttab * using table2_sumstats_c1_nhats.rtf, cells(mean(fmt(%9.3fc) label(mean))) compress unstack ///
mtitles("Medigap" "Other Coverage") ///
label replace nogaps title("Table 2: Demographic Summary Statistics by Medicare Coverage, 2011 Cohort") ///
addnote("NHATS 2011.")

est clear

******************************************************

******************************************************
** OLS (LPM) REGRESSIONS **
******************************************************

** Table 4: NHATS Person Fixed Effects Estimates of Hardship for Change in Medigap/Supplemental Coverage

/// col 1 - Food Hardship + Year + Non Constant Controls
eststo est1: xtreg foodhardshp medigap $YX $X if indpdntlv == 1 , fe
estadd ysumm

/// col 2 - Food Hardship + Year + Non Constant Controls + Census Division
eststo est2: xtreg foodhardshp medigap $YX $X $DX if indpdntlv == 1 , fe
estadd ysumm

/// col 3 - Financial Hardships + Year + Non Constant Controls
eststo est3: xtreg finhardshp medigap $YX $X if indpdntlv == 1 , fe
estadd ysumm

/// col 4 - Financial Hardships + Year + Non Constant Controls + Census Division
eststo est4: xtreg finhardshp medigap $YX $X $DX if indpdntlv == 1 , fe
estadd ysumm

/// col 5 - Medical Hardship + Year + Non Constant Controls
eststo est5: xtreg nopaymed medigap $YX $X if indpdntlv == 1 , fe
estadd ysumm

/// col 6 - Medical Hardship + Year + Non Constant Controls + Census Division
eststo est6: xtreg nopaymed medigap $YX $X $DX if indpdntlv == 1 , fe
estadd ysumm

/// full table
esttab est1 est2 est3 est4 est5 est6 using table4_spfe_nhats.rtf, se replace star(* 0.10 ** 0.05 *** 0.01) ///
label ar2 compress nogaps indicate("Year FE = y*") ///
mtitles("Food Hardship" "Food Hardship" "Financial Hardship" "Financial Hardship" "Medical Hardship" "Medical Hardship") ///
mgroups("Food Hardship" "Financial Hardship" "Medical Hardship", pattern(1 0 1 0 1 0)) ///
stats(N ymean ysd r2, labels("Observations" "Y Mean" "Y Std" "R-squared")) ///
 addnote("NHATS 2011-2024.")

est clear

******************************************************

** Table 5: NHATS Person Fixed Effects Estimates of Hardship for Change in Medigap/Supplemental Coverage Conditional on Female and Non-White Respondents

/// cols 1 & 2 - Food Hardship + Year + Non Constant Controls + Census Division
eststo est1: xtreg foodhardshp medigap $YX $X $D if indpdntlv == 1 & female == 1 , fe
estadd ysumm
eststo est2: xtreg foodhardshp medigap $YX $X $D if indpdntlv == 1 & white==0, fe
estadd ysumm

/// cols 3 & 4 - Financial Hardships + Year + Non Constant Controls + Census Division
eststo est3: xtreg finhardshp medigap $YX $X $D if indpdntlv == 1 & female==1, fe
estadd ysumm
eststo est4: xtreg finhardshp medigap $YX $X $D if indpdntlv == 1 & white==0, fe
estadd ysumm

/// cols 4 & 5 - Medical Hardship + Year + Non Constant Controls + Census Division
eststo est5: xtreg nopaymed medigap $YX $X $D if indpdntlv == 1 & female==1 , fe
estadd ysumm
eststo est6: xtreg nopaymed medigap $YX $X $D if indpdntlv == 1 & white==0 , fe
estadd ysumm

/// full table
esttab est1 est2 est3 est4 est5 est6 using table5_spfe_estxcont_nhats.rtf, se replace star(* 0.10 ** 0.05 *** 0.01) ///
label ar2 compress nogaps indicate("Year FE = y*") ///
mtitles("Food Hardship" "Food Hardship" "Financial Hardship" "Financial Hardship" "Medical Hardship" "Medical Hardship") ///
mgroups("Food Hardship" "Financial Hardship" "Medical Hardship", pattern(1 0 1 0 1 0)) ///
stats(N ymean ysd r2, labels("Observations" "Y Mean" "Y Std" "R-squared")) ///
 addnote("NHATS 2011-2024.")

est clear

******************************************************
cap log close
clear all
******************************************************
