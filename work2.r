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
library("gplots")
library("cluster")


db <- dbConnect(dbDriver("SQLite"), "D:/college_score/output/database.sqlite")


train<- dbGetQuery(db, "select year,zip, LOWER(INSTNM) || '-' || ZIP AS INSTNM_ZIP

                   ,ADM_RATE_ALL
                   
                   ,SAT_AVG_ALL
                   
                   ,COSTT4_A --cost anual academic year
                   
                   ,COSTT4_P --cost for program year
                   
                   ,C150_4 -- completion rate
                   
                   ,PCTFLOAN --federal loan rate
                   
                   ,UG25abv -- undergrad over age 25
                   
                  --- ,INC_N,CASE WHEN INC_N = 'PrivacySuppressed' THEN AVG(INC_N) ELSE  INC_N END AS INC_N
                   
                   ,PAR_ED_N
                   
                   ,PAR_ED_PCT_1STGEN
                   
                   ,PCTPELL -- pell grant percent
                   
                   ,DEBT_MDN -- median debt
                   
                   ,gt_25k_p6 -- shareof students earning over 25k after 6 year
                   
                   ---,CASE WHEN COMPL_RPY_5YR_RT = 'PrivacySuppressed' THEN AVG(COMPL_RPY_5YR_RT) ELSE  COMPL_RPY_5YR_RT END AS INC_N 
                   
                   ,NONCOM_RPY_5YR_RT
                   
                   ,UGDS
                   
                   ,female
                   
                   ,married
                   
                   ,dependent
                   
                   ,veteran
                   
                   ,first_gen
                   
                   , md_faminc
                   
                   ,pct_ba
                   
                   , pct_grad_prof
                   
                   , pct_born_us
                   
                   , median_hh_inc
                   
                   , poverty_rate
                   
                   , unemp_rate
                   
                   ,loan_ever
                   
                   from Scorecard 
                   
                   WHERE 
                   
                   lower(INSTNM) IN 
                   
                   (select LOWER(INSTNM)
                   
                   from Scorecard 
                   
                   group by LOWER(INSTNM),ZIP
                   
                   HAVING (SUM(CASE WHEN SAT_AVG_ALL IS NULL THEN 0 ELSE 1 END) > 0))
                   
                   order by year desc,LOWER(INSTNM),ZIP
                   
                   ")



length(unique(train$INSTNM_ZIP))

summary(train$COMPL_RPY_5YR_RT)




trainSummary<- dbGetQuery(db, "

                   select LOWER(INSTNM) || '-' || ZIP AS INSTNM_ZIP
                          
                          ,AVG(ADM_RATE_ALL)
                          
                          ,AVG(SAT_AVG_ALL)
                          
                          ,AVG(COSTT4_P)
                          
                          --,AVG(CASE WHEN COSTT4_A = 'NA' THEN AVG(COSTT4_P) ELSE  COSTT4_A END)  --cost anual academic year 
                          
                          ,AVG(COSTT4_A)
                          
                          ,AVG(C150_4) -- completion rate
                          
                          ,AVG(PCTFLOAN) --federal loan rate
                          
                          ,AVG(UG25abv) -- undergrad over age 25
                          
                          --,AVG(CASE WHEN INC_N = 'PrivacySuppressed' THEN AVG(INC_N) ELSE  INC_N END )
                          
                          ,AVG(PAR_ED_N)
                          
                          ,AVG(PAR_ED_PCT_1STGEN)
                          
                          ,AVG(PCTPELL) -- pell grant percent
                          
                          ,AVG(DEBT_MDN) -- median debt
                          
                          ,AVG(gt_25k_p6) -- shareof students earning over 25k after 6 year
                          
                          --,AVG(CASE WHEN COMPL_RPY_5YR_RT = 'PrivacySuppressed' THEN AVG(COMPL_RPY_5YR_RT) ELSE  COMPL_RPY_5YR_RT END )
                          
                          ,AVG(NONCOM_RPY_5YR_RT)
                          
                          ,AVG(UGDS)
                          
                          ,AVG(female)
                          
                          ,AVG(married)
                          
                          ,AVG(dependent)
                          
                          ,AVG(veteran)
                          
                          ,AVG(first_gen)
                          
                          , AVG(md_faminc)
                          
                          ,AVG(pct_ba)
                          
                          , AVG(pct_grad_prof)
                          
                          , AVG(pct_born_us)
                          
                          , AVG(median_hh_inc)
                          
                          , AVG(poverty_rate)
                          
                          , AVG(unemp_rate)
                          
                          ,AVG(loan_ever)
                          
                          FROM Scorecard 
                          
                          WHERE
                          
                          LOWER(INSTNM) IN 
                          
                          (select LOWER(INSTNM) 
                          
                          from Scorecard 
                          
                          group by LOWER(INSTNM),ZIP
                          
                          HAVING (SUM(CASE WHEN SAT_AVG_ALL IS NULL THEN 0 ELSE 1 END) > 0))
                          
                          GROUP BY LOWER(INSTNM) || '-' || ZIP")


for(i in 1:ncol(trainSummary)){
  trainSummary[,i][is.na(trainSummary[,i])] <- mean(trainSummary[,i], na.rm = TRUE)
}

trainSum=trainSummary[-c(4)]
hc.complete =hclust(dist(trainSum), method="complete")
x=cutree(hc.complete , 15) 
plot(hc.complete, labels = NULL, hang = 0.02, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE,
     main = "Cluster Dendrogram",
     sub = NULL, xlab = NULL, ylab = "Height")

hc.agnes=agnes(trainSum)
pltree(hc.agnes)
