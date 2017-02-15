# ZillowAPI
##R
This R script is written to grab the housing data from zillow. 

Several zillow api token (zws-id) because per id can only make 1,500 requests per day.

In this script, I have written a loop to parse the returned XML and get data. 

Additionally, remember the last row number if the zillow id is reached the maximum requests, delete the id from the id lists, and use another id to continue the request.

##JavaScript
The function in .js is to get the real time data from Zillow by the address input.
