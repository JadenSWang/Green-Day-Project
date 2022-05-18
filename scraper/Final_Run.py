import pandas as pd 
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib as matplt


# --- fetching


#zack's attempt to pull one file
import requests
# storage_location = r'/content/drive/MyDrive/greendaySample_test.xlsm'
report = requests.get('https://web.pgcb.gov.bd/report/3345/download')
# with open (storage_location, 'wb') as file:
#     file.write(report.content)


# #Zack's attempt to loop backwards and pull many files
# storage_location = r'/content/drive/MyDrive/bangladesh{}.xlsm'

# #input starting and ending numbers when we actally want to run this
# file_starting_number = 3345 #Right now it starts at the latest
# file_ending_number = 3344 #and loops back only one report


# for i in range(file_starting_number,file_ending_number,-1):
#     report = requests.get('https://web.pgcb.gov.bd/report/{}/download'.format(i))
#     with open (storage_location.format(i), 'wb') as file:
#         file.write(report.content)



# ------- data processing
import xlrd
import openpyxl

# sample = "/content/drive/MyDrive/greendaySample.xlsm"
df = pd.read_excel(report.content, sheet_name=None)

# prints all sheets name in an ordered dictionary
print(df.keys())

# prints first sheet name or any sheet if you know it's index
first_sheet_name = list(df.keys())[0]
# print(first_sheet_name)

sheetName = ['Forecast', 'YesterdayGen', 'P1', 'P2', 'P3', 'Voltage', 'L-Curve', 'En-Curve', 'Generation']
# sheet name: ['Forecast', 'YesterdayGen', 'P1', 'P2', 'P3', 'Voltage', 'L-Curve', 'En-Curve', 'Generation'] 
# turn each sheet to csv and import it as csv


i = 0
for sheet_name in list(df.keys()):
   df[sheet_name].to_csv(sheet_name + 'Sheet.csv')
   print(sheetName[i])
   sheetName[i] = pd.read_csv(sheet_name + 'Sheet.csv')
   i = i+1

# to access the data 
# select, for example, sheetName[1]
df_lcurve = sheetName[6]



# ------------------------------------------------------------------------------forcaset CSV --- Fred



df_forcast = sheetName[0]

# dropping column with null
df_forcast = df_forcast.iloc[7: , 3:]
df_forcast =  df_forcast.drop(df_forcast.iloc[: , 1:2], axis=1)
df_forcast =  df_forcast.drop(df_forcast.iloc[: , 13:14], axis=1)
df_forcast

column_names = ["name", 'generation_type', 'producer', 'installed_capacity(unit_No.X_capacity)', 'installed_capacity(MW)', 'present_capacity(MW)', 
               "actual_generation(day_peak)", 'actual_generation(Ev.peak)', 'forcasted_avaliable_gen(day_peak)', 'forcasted_avaliable_gen(Ev.peak)',
               'Ev.peak_gen_shortage(for_fuel_limitation)', 'Ev.peak_gen_shortage(for_plant.S/D_M/C_problem)', 'plants_under_shut_down_remarks','probable_start_up_date']

df_forcast_filtered = pd.DataFrame(columns = column_names)
for (index, colname) in enumerate(df_forcast):
    df_forcast_filtered[column_names[index]] = df_forcast[colname]

# replace nan
df_forcast_filtered = df_forcast_filtered.fillna(-1)
# df_forcast_filtered




# -------------------------------------------------------------------------------L_Curve CSV ---- Abdiwahid 

lr_Clean_Data = df_lcurve.iloc[:,0:5]
lr_Clean_Data = lr_Clean_Data.iloc[1:,:]
colName = lr_Clean_Data.iloc[0]
lr_Clean_Data = lr_Clean_Data.iloc[1:, :]
lr_Clean_Data_New = pd.DataFrame(columns = colName)
lr_Clean_Data_New
pointer = 0
for(Column, Data) in lr_Clean_Data.iteritems():
  lr_Clean_Data_New[colName[pointer]] = lr_Clean_Data[Column]
  pointer = pointer + 1
# lr_Clean_Data_New



# ------------------------------------------------------------------------------ YesterdayGen --- Zack
#THIS CODE SHOULD WORK
# Block to clean up data in YesterdayGen --- Zack
df_yesGen = sheetName[1]
df_yesGen_test = df_yesGen.iloc[1: , :]
df_yesGen_test.columns = df_yesGen_test.iloc[0]
df_yesGen_test_updated = df_yesGen_test[2:]
df_yesGen_test = df_yesGen_test.drop(
    ['Plant Removed', 
    'WesternBlank', 
    'EasternBlank', 
    'Eastern Grid Total', 
    'Western Grid Total',
    'Total (MW)',
    'Gas (Public)',
    'HVDC',
    'Gas (Private)',
    'HSD (Private)',
    'HFO (Private)',
    'Coal',
    'Hydro',
    'HSD (Public)',
    'HFO (Public)',
    'Tripura',
    'Solar',
    'Shortage'],
    axis = 1
)

clean_yesGen = df_yesGen_test_updated.fillna(-1)
df_yesGen_emissions = clean_yesGen.iloc[:26,]
df_yesGen_emissions_flipped = df_yesGen_emissions.T
#now I will create the other data frame for the summary data (df_yesGen_summary)
df_yesGen_summary = clean_yesGen.iloc[26:33,]
df_yesGen_summary = df_yesGen_summary.T


#See the 2 dataframes

# --------------------df_forcast_filtered, lr_Clean_Data_New, df_yesGen_emissions_flipped, df_yesGen_summary
# --------------------Above are cleaned dataset variable names
df_yesGen_summary.copy()
