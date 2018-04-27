#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr 25 15:02:50 2018

@author: Taranpreet

Times series analysis on yelp reviews
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

ts = pd.read_csv("RevCounts.csv",parse_dates=['date'],index_col=['date'])

plt.plot(ts,':b')

#yearly Average of readRate
ts.resample('A').mean()
ts.resample('A').sum()
round(ts.resample('A').mean().rename(index=lambda x: x.strftime('%Y')),0)


    
    
    