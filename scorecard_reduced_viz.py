
# coding: utf-8

# In[26]:

import pandas as pd
df_data = pd.read_csv('data/scorecard_imputed.csv', encoding='iso-8859-1',
                      na_values="PrivacySuppressed")
df_original = pd.read_csv('data/scorecard_reduced_bachelors.csv', encoding='iso-8859-1',
                      na_values="PrivacySuppressed")
df_reduced = pd.read_csv('data/scorecard_reduced_features.csv', encoding='iso-8859-1',
                      na_values="PrivacySuppressed")


# In[27]:

reduced = ['UNITID','INSTNM', 'ZIP']


# In[30]:

df_red_reduced = df_reduced[reduced]


# In[32]:

df_pre_final = pd.concat([df_red_reduced, df_data], axis=1, join_axes=[df_red_reduced.index])


# In[43]:

features = ['UNITID','INSTNM', 'ZIP', 'ADM_RATE_ALL', 'SATVR25', 'SATVR75', 'SAT_AVG_ALL', 'CCSIZSET', 'COST']
new_features = ['UNITID', 'CITY', 'STABBR', 'LATITUDE', 'LONGITUDE']


# In[44]:

df_data_viz = df_pre_final[features]
df_org_feat = df_original[new_features]


# In[45]:

df_result = pd.merge(df_data_viz, df_org_feat, how='left', on=['UNITID'])


# In[49]:

df_result.to_csv('data/scorecard_reduced_features_viz.csv')

