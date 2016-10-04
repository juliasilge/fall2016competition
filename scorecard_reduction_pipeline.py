import numpy as np
import pandas as pd

root_features = ['UNITID','INSTNM', 'sch_deg']

include_features = [
                    'ADM_RATE_ALL', 'SATVR25', 'SATVR75', 'SAT_AVG_ALL',
                    'PCTFLOAN', 'DEBT_MDN', 'C150_4', 'C150_4_BLACK',
                    'C150_4_HISP', 'C150_4_ASIAN', 'C150_4_AIAN',
                    'C150_4_NRA', 'LO_INC_COMP_ORIG_YR6_RT',
                    'MD_INC_COMP_ORIG_YR6_RT', 'HI_INC_COMP_ORIG_YR6_RT',
                    'FIRSTGEN_COMP_ORIG_YR6_RT', 'pct75_earn_wne_p8',
                    'pct90_earn_wne_p8', 'pct25_earn_wne_p8', 'mn_earn_wne_p8',
                    'RPY_3YR_RT_SUPP', 'LO_INC_RPY_3YR_RT_SUPP',
                    'MD_INC_RPY_3YR_RT_SUPP', 'HI_INC_RPY_3YR_RT_SUPP',
                    'NONCOM_RPY_3YR_RT_SUPP', 'FIRSTGEN_RPY_3YR_RT_SUPP',
                    'UGDS_WHITE', 'UGDS_BLACK', 'UGDS_HISP', 'UGDS_ASIAN',
                    'PAR_ED_PCT_1STGEN', 'UG25abv'
                    ]
combo_features = {
                  'COST': ['COSTT4_A', 'COSTT4_P'],
                  'PCT_RELIGIOUS': ['PCIP38', 'PCIP39'],
                  'PCT_VOCATIONAL': ['PCIP15', 'PCIP19', 'PCIP41', 'PCIP46',
                                     'PCIP47', 'PCIP48', 'PCIP49'],
                  'PCT_PROFESSIONAL': ['PCIP04', 'PCIP10', 'PCIP11', 'PCIP12',
                                       'PCIP14', 'PCIP22', 'PCIP25', 'PCIP29',
                                       'PCIP43', 'PCIP44', 'PCIP43', 'PCIP50',
                                       'PCIP51', 'PCIP52'],
                  'PCT_LIBERAL_ARTS': ['PCIP01', 'PCIP03', 'PCIP05', 'PCIP09',
                                       'PCIP13', 'PCIP16', 'PCIP23', 'PCIP24',
                                       'PCIP26', 'PCIP27', 'PCIP30', 'PCIP31',
                                       'PCIP40', 'PCIP42', 'PCIP45', 'PCIP54']
                  }


#get a flattened list of features in the combo_features dictionary:
ml_features = [val for sublist in combo_features.values() for val in sublist]
ml_features += include_features

def load_all_data(path):
    all_data = pd.DataFrame()
    for yr in range(1996,2014):
        data = pd.read_csv(path+'/merged_'+str(yr)+'_PP.csv', encoding='iso-8859-1',
                           na_values="PrivacySuppressed", index_col='UNITID',
                           usecols=root_features + ml_features)
        data['year'] = yr
        all_data = pd.concat((all_data,data))
    return all_data

def reduce_data(df):
    yearly = df.groupby("year")
    reduced = yearly.get_group(2013)
    for yr in range(2012,1995,-1):
        df = yearly.get_group(yr)
        reduced = reduced.combine_first(df)
    reduced = reduced[reduced.index.isin(yearly.get_group(2013).index)]
    return reduced.drop('year', axis=1)

def select_features(df):
    for combo in combo_features.keys():
        df[combo] = df[combo_features[combo]].dropna(how='all').sum(axis=1)
    return df

def select_bachelors(df):
    return df[df.sch_deg == 3].drop('sch_deg', axis=1)

if __name__ == '__main__':
    path = 'data/college-scorecard-raw-data-030216'
    data = load_all_data(path)
    data = reduce_data(data)
    data = select_bachelors(data)
    data = select_features(data)
    data.to_csv('data/scorecard_reduced_bachelors.csv')