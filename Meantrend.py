# -*- coding: utf-8 -*-
"""
Created on Sat Mar 16 13:51:03 2024

@author: ly
"""
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import pytrendseries


df = pd.read_csv("E:/中国区域复合极端事件概率/Figure and codes/datacontibutions/urbancontributions.csv")
# df1 = df[['Year','Urban245']].set_index('Year')
# df1.plot(xlabel='Year',
#         ylabel='Urban area',
#         title='Urban245',
#         figsize=(10,6));


df1 = df[['Year','Urban245']].set_index('Year')
# filtered_data=df1.iloc[:, 0]
# window = 5
# trend = "downtrend"
# trends_detected, statistcs = pytrendseries.detecttrend(filtered_data, trend=trend, window=window)
# pytrendseries.vizplot.plot_trend(filtered_data, trends_detected, trend)

#产生5阶移动平均
#产生5阶移动平均
order1=5
df1[str(order1)+'-MA']=df1['Urban245'].rolling(window=order1,center=True,min_periods=3).mean()
#可视化
df1.plot(xlabel='Year',
        ylabel='Urbanarea245',
        title='5-MA',
        figsize=(6,5));



df2 = df[['Year','Urban585']].set_index('Year')
#产生5阶移动平均
#产生5阶移动平均
order1=5
df2[str(order1)+'-MA']=df2['Urban585'].rolling(window=order1,center=True,min_periods=3).mean()
#可视化
df2.plot(xlabel='Year',
        ylabel='Urbanarea585',
        title='5-MA',
        figsize=(6,5));


df3 = df[['Year','Nonurban245']].set_index('Year')
#产生5阶移动平均
#产生5阶移动平均
order1=5
df3[str(order1)+'-MA']=df3['Nonurban245'].rolling(window=order1,center=True,min_periods=3).mean()
#可视化
df3.plot(xlabel='Year',
        ylabel='Nonurban245',
        title='5-MA',
        figsize=(6,5));


df4= df[['Year','Nonurban585']].set_index('Year')
#产生5阶移动平均
#产生5阶移动平均
order1=5
df4[str(order1)+'-MA']=df4['Nonurban585'].rolling(window=order1,center=True,min_periods=3).mean()
#可视化
df4.plot(xlabel='Year',
        ylabel='Nonurban585',
        title='5-MA',
        figsize=(6,5));


data=[df1['5-MA'],df2['5-MA'],df3['5-MA'],df4['5-MA']]

# 创建DataFrame
df_data = pd.DataFrame(data)

# 将数据导出为txt文件
#df_data.to_csv('data.txt', sep='\t', index=False, header=False)
# order1=5
# df1[str(order1)+'-MA']=df1['num'].rolling(window=order1,center=True,min_periods=3).corr(df1['Urban245'])
# df1.plot(xlabel='Year',
#         ylabel='Urban area',
#         title='5-MA Urban245',
#         figsize=(6,5));

#def trendre(x, y):
    # 计算 x 和 y 的最大值和最小值
    #x_max = x.max()
    #x_min = x.min()
    #y_max = y.max()
    #y_min = y.min()

    # 计算 x 和 y 的趋势系数
    #trend_coefficient = (y_max - y_min) /(x_max - x_min) 
    #return trend_coefficient
    
x=df['num']
y=df2['5-MA']    
diffe = np.diff(y) / np.diff(x)
trend_ = np.mean(diffe)
    




#result = df4['5-MA'].rolling(window=5,center=True,min_periods=3).apply(trendre)

#result = df4['5-MA'].rolling(window=5, center=True, min_periods=3).apply(lambda x: trendre(x, df4['5-MA']))





# x=df['num']
# y=df4['5-MA']
# trend=trendre(x, y)


# df1[str(order1)+'-MA']=df['num','Urban245'].rolling(window=order1,center=True,min_periods=3).apply(trendre)
# df1.plot(xlabel='Year',
#         ylabel='Urban area',
#         title='5-MA Urban245',
#         figsize=(6,5));


# plt.figure(figsize=(10, 6))
# meandf5MA=df1['5-MA'].abs().mean()

# plt.plot(df['Year'], df1[str(order1)+'-MA'], label='(5-R= %0.2f)' % meandf5MA)
# # 添加图例和显示图形
# plt.legend()
# plt.show