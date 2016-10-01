# Choosing Variables to Use from the College Scorecard Data

Use this Markdown file to organize/compile the variables that we will include in our clustering algorithm.

## Academics

## Admissions

* `ADM_RATE_ALL`
* `SATVR25`
* `SATVR75`
* `SAT_AVG_ALL`

## Aid  
* `PCTFLOAN`
* `DEBT_MDN`

## Completion
* `C150_4`
* `C150_4_BLACK`
* `C150_4_HISP`
* `C150_4_ASIAN`
* `C150_4_AIAN`
* `C150_4_NRA`
* `LO_INC_COMP_ORIG_YR6_RT`
* `MD_INC_COMP_ORIG_YR6_RT`
* `HI_INC_COMP_ORIG_YR6_RT`
* `FIRSTGEN_COMP_ORIG_YR6_RT`

## Cost  
* sum of `COSTT4_A` and `COSTT4_P`, removing `NA` values

## Earnings
* `pct75_earn_wne_p8`
* `pct90_earn_wne_p8`
* `pct25_earn_wne_p8`
* `mn_earn_wne_p8`


## Repayment
* `RPY_3YR_RT_SUPP`
* `LO_INC_RPY_3YR_RT_SUPP`
* `MD_INC_RPY_3YR_RT_SUPP`
* `HI_INC_RPY_3YR_RT_SUPP`
* `NONCOM_RPY_3YR_RT_SUPP`
* `FIRSTGEN_RPY_3YR_RT_SUPP`


## Root  
* `UNITID` -- NOTE: Not for clustering, but for use as our unique identifier.

## School

## Student

* `UGDS_WHITE`
* `UGDS_BLACK`
* `UGDS_HISP`
* `UGDS_ASIAN`
* `PAR_ED_PCT_1STGEN`
* `UG25abv`
