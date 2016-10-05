# Choosing Variables to Use from the College Scorecard Data

Use this Markdown file to organize/compile the variables that we will include in our clustering algorithm.

## Academics
* sum of `PCIP01`, `PCIP03`, `PCIP05`, `PCIP09`, `PCIP13`, `PCIP16`, `PCIP23`, `PCIP24`, `PCIP26`, `PCIP27`, `PCIP30`, `PCIP31`, `PCIP40`, `PCIP42`, `PCIP45`, and `PCIP54`.  Call this category _Liberal Arts_.
* sum of `PCIP04`, `PCIP10`, `PCIP11`, `PCIP12`, `PCIP14`, `PCIP22`, `PCIP25`, `PCIP29`, `PCIP43`, `PCIP44`, `PCIP43`, `PCIP50`, `PCIP51`, and `PCIP52`. Call this category _Professional_.
* sum of - `PCIP15`, `PCIP19`, `PCIP41`, `PCIP46`, `PCIP47`, `PCIP48`, and `PCIP49`. Call this category _Vocational_.
* sum of - `PCIP38` and `PCIP39`. Call this category _Religious_.


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

* 'INSTNM' -- NOTE: Not for clustering, but for use as our unique identifier.
* 'ZIP' -- NOTE: Not fur clustering, just for mapping purposes.
* 'LOCALE' 
* 'CONTROL'
* 'CCBASIC'
* 'HBCU'
* 'PBI'
* 'ANNHI'
* 'TRIBAL'
* 'AANAPII'
* 'HSI'
* 'NANTI'
* 'WOMENONLY'
* 'MENONLY'
* 'DISTANCEONLY'
* 'INEXPFTE'
* 'AVGFACSAL'
* 'PFTFAC'
* 'HCM2'

## Student

* `UGDS_WHITE`
* `UGDS_BLACK`
* `UGDS_HISP`
* `UGDS_ASIAN`
* `PAR_ED_PCT_1STGEN`
* `UG25abv`
