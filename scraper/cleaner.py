import matplotlib as matplt
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import xlrd
import openpyxl


def cleaner():
    result = []
    # we will mainly use pandas and numpy for data processing
    # seaborn, matplt help to create visualization in case we are confused

    sample = "/content/drive/MyDrive/greendaySample.xlsm"

    df = pd.read_excel(sample, sheet_name=None)

    # prints all sheets name in an ordered dictionary
    print(df.keys())

    # prints first sheet name or any sheet if you know it's index
    first_sheet_name = list(df.keys())[0]
    # print(first_sheet_name)

    sheetName = ['Forecast', 'YesterdayGen', 'P1', 'P2',
                 'P3', 'Voltage', 'L-Curve', 'En-Curve', 'Generation']
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

    # ---------

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
    df_forcast_filtered_no_total = pd.DataFrame(columns = column_names);
    for index, row in df_forcast_filtered.iterrows():
        currName  =  row["name"]
    if isinstance(currName, str):
        if "area Total" not in currName and "Area Total" not in currName:
        # print(row)
            df_forcast_filtered_no_total.loc[index]= row
    else:
        df_forcast_filtered_no_total.loc[index]= row

    df_forcast_filtered = df_forcast_filtered_no_total
    df_forcast_filtered



    # --------
    lr_Clean_Data = df_lcurve.iloc[:,0:5]
    lr_Clean_Data = lr_Clean_Data.iloc[1:,:]
    colName = lr_Clean_Data.iloc[0]
    lr_Clean_Data = lr_Clean_Data.iloc[1:, :]
    lr_Clean_Data_New = pd.DataFrame(columns = colName)
    pointer = 0
    for(Column, Data) in lr_Clean_Data.iteritems():
        lr_Clean_Data_New[colName[pointer]] = lr_Clean_Data[Column]
        pointer = pointer + 1
    result.append(lr_Clean_Data_New)

    # ----------
    # Zack
    #THIS CODE SHOULD WORK
    # Block to clean up data in YesterdayGen --- Zack
    df_yesGen = sheetName[1]

    #drop first row of unstructured values and summary values at the end
    df_yesGen_test = df_yesGen.iloc[1: , :]

    #set column names and drop the second row which is empty
    df_yesGen_test.columns = df_yesGen_test.iloc[0]

    #drop the first and 3rd rows which are empty
    df_yesGen_test_updated = df_yesGen_test[2:]

    #Rename the column that is called 'Plant Name' to 'End Time', as that is what it really reflects.
    df_yesGen_test_updated.rename(columns = {'Plant Name':'End Time'}, inplace= True)

    #clean out unnecessary columns
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

    # Clean out NULLS
    clean_yesGen = df_yesGen_test_updated.fillna(-1) 

    #now I want to create 2 seperate dataframes: one that is just the emissions per plant (df_yesGen_emissions), and another that is summary data
    df_yesGen_emissions = clean_yesGen.iloc[:26,]

    #now I will create the other data frame for the summary data (df_yesGen_summary)
    df_yesGen_summary_1 = clean_yesGen.iloc[:1,]
    df_yesGen_summary_2 = clean_yesGen.iloc[28:34,]
    df_yesGen_summary = df_yesGen_summary_1.append(df_yesGen_summary_2)
    df_yesGen_summary = df_yesGen_summary.T
    result.append(df_yesGen_emissions)
    result.append(df_yesGen_summary)
    # print(df_yesGen_emissions)
    # print(df_yesGen_summary)

    return result