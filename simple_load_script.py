#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
A simple loading script for the College Scorecard data.
 '''
# Import pandas.  'pd' is the generally accepted abbreviation.
import pandas as pd

# Provide the file path:
filename = 'data/college-scorecard-raw-data-030216/merged_2012_PP.csv'

# Load the data.  
#	1) The scorecard csv files aren't utf-8 encoded, so we have to specify the
#	   correct encoding.  
#	2) Certain entries are suppressed for privacy reasons, so we need to tell
#	   pandas to interpret 'PrivacySuppressed' as NaN.
df = pd.read_csv(filename, encoding='iso-8859-1', na_values="PrivacySuppressed")

# Print out the first 10 rows:
print(df.head(10))
