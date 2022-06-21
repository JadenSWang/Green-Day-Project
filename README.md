# Green-Day-Project

## Scraper
Please see "cleaner.py" in the scaper folder.
The "scraper" is actually accessing an API which take data fetched from the internet and seperate them into a different datasets.  
The API we are calling produces a downloadable version of a multi-tab Excel file.  Thus, to create accessible data, we have to call the API, seperate the sheets into dataframes, and then parse those dataframes to create clean data frames.  These clean data frames are titled: 
1) "df_yesGen_emissions"- daily emissions data for each plant
2) "df_yesGen_summary"- summary of the above information, it also includes cost information
3) "df_forcast_filtered"- summary data on powerplants- mostly used for informing descriptive tables in database
4) "lr_Clean_Data_New"- demand data from Bangladesh

A few notes about the script:
The current script runs it for one "random" API call.  It calls the API based on a unique number attached to the file.  THis random number will be clear if you hover over the attachment symbol for each report on this website: http://pgcb.gov.bd/site/page/0dd38e19-7c70-4582-95ba-078fccb609a8/-.  It is the 4 digit code within the endpoint of the api.

However, we also have an "commented out" section of the "scraper" which will allow you to loop over calls back in time, which should allow you to programmatically call and parse prior days of data.


## Database
We also have created a database which should, theoretically serve as a scalable and flexible database.  If a pipeline is created, the data can be fed from the data frames into the Database.


## To Run
run: npm run dev
