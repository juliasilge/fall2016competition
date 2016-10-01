import numpy as np
import pandas as pd


def load_all_data(path):
    all_data = pd.DataFrame()
    for yr in range(1996,2014):
        data = pd.read_csv(path+'/merged_'+str(yr)+'_PP.csv', encoding='iso-8859-1',
                           na_values="PrivacySuppressed")
        data['year'] = yr
        all_data = pd.concat((all_data,data))
    return all_data.set_index('UNITID')

def reduce_data(all_data):
    yearly = all_data.groupby("year")
    reduced = yearly.get_group(2013)
    for yr in range(2012,1995,-1):
        df = yearly.get_group(yr)
        reduced = reduced.combine_first(df)
    reduced = reduced[reduced.index.isin(yearly.get_group(2013).index)]
    return reduced

def select_bachelors(df):
    return df[df.sch_deg == 3]

if __name__ == '__main__':
    path = 'data/college-scorecard-raw-data-030216'
    alldata = load_all_data(path)
    reduced = reduce_data(alldata)
    bachelors = select_bachelors(reduced)
    bachelors.to_csv('data/scorecard_reduced_bachelors.csv')