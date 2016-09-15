library(RSQLite)
library('magrittr')  
library('tidyr')     
library('dplyr')     
library('ggplot2')   
library('gridExtra') 
library('bnlearn')   
library('leaflet')   
library('htmltools') 
library('RColorBrewer')



db <- dbConnect(dbDriver("SQLite"), "D:/college_score/output/database.sqlite")



tmp2<- dbGetQuery(db, "
select Year,INSTNM,
count(*)
from Scorecard 
where Year=2013
group by Year,INSTNM
")

tmp3<- dbGetQuery(db, "
select lower(INSTNM),ZIP,max(Year),min(year),
count(*)
from Scorecard 
group by LOWER(INSTNM),ZIP
order by 5 desc 
")


tmp4<- dbGetQuery(db, "
select LOWER(INSTNM),ZIP,
count(*),
COUNT(*) - SUM(CASE WHEN HBCU                  IS NULL THEN 0 ELSE 1 END) HBCU,
COUNT(*) - SUM(CASE WHEN PBI                   IS NULL THEN 0 ELSE 1 END) PBI,
COUNT(*) - SUM(CASE WHEN ANNHI                 IS NULL THEN 0 ELSE 1 END) ANNHI,
COUNT(*) - SUM(CASE WHEN TRIBAL                IS NULL THEN 0 ELSE 1 END) TRIBAL,
COUNT(*) - SUM(CASE WHEN AANAPII               IS NULL THEN 0 ELSE 1 END) AANAPII,
COUNT(*) - SUM(CASE WHEN HSI                   IS NULL THEN 0 ELSE 1 END) HSI,
COUNT(*) - SUM(CASE WHEN NANTI                 IS NULL THEN 0 ELSE 1 END) NANTI,
COUNT(*) - SUM(CASE WHEN MENONLY               IS NULL THEN 0 ELSE 1 END) MENONLY,
COUNT(*) - SUM(CASE WHEN WOMENONLY             IS NULL THEN 0 ELSE 1 END) WOMENONLY,
COUNT(*) - SUM(CASE WHEN RELAFFIL              IS NULL THEN 0 ELSE 1 END) RELAFFIL,
COUNT(*) - SUM(CASE WHEN ADM_RATE_ALL          IS NULL THEN 0 ELSE 1 END) ADM_RATE_ALL,
COUNT(*) - SUM(CASE WHEN SAT_AVG_ALL           IS NULL THEN 0 ELSE 1 END) SAT_AVG_ALL
, max(year), min(year)

from Scorecard 
group by LOWER(INSTNM),ZIP
HAVING  ((SUM(CASE WHEN ADM_RATE_ALL IS NULL THEN 0 ELSE 1 END)) > 0) AND (SUM(CASE WHEN SAT_AVG_ALL IS NULL THEN 0 ELSE 1 END) > 0)
order by 1,2,3 desc 
")



train<- dbGetQuery(db, "
select year
,PREDDEG,HIGHDEG,CONTROL
,HBCU
,PBI
,ANNHI
,TRIBAL
,AANAPII
,HSI
,NANTI
,MENONLY
,WOMENONLY
,RELAFFIL
,ADM_RATE_ALL
,SAT_AVG_ALL
,PCIP01
,PCIP03
,PCIP04
,PCIP05
,PCIP09
,PCIP10
,PCIP11
,PCIP12
,PCIP13
,PCIP14
,PCIP15
,PCIP16
,PCIP19
,PCIP22
,PCIP23
,PCIP24
,PCIP25
,PCIP26
,PCIP27
,PCIP29
,PCIP30
,PCIP31
,PCIP38
,PCIP39
,PCIP40
,PCIP41
,PCIP42
,PCIP43
,PCIP44
,PCIP45
,PCIP46
,PCIP47
,PCIP48
,PCIP49
,PCIP50
,PCIP51
,PCIP52
,PCIP54
,DISTANCEONLY
,INC_N
,PAR_ED_N

from Scorecard 
WHERE lower(INSTNM) IN 

(select LOWER(INSTNM)

from Scorecard 
group by LOWER(INSTNM),ZIP
HAVING  ((SUM(CASE WHEN ADM_RATE_ALL IS NULL THEN 0 ELSE 1 END)) > 0) AND (SUM(CASE WHEN SAT_AVG_ALL IS NULL THEN 0 ELSE 1 END) > 0)
)
order by year desc
")







