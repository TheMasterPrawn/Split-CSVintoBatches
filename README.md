# Split-CSVintoBatches
Splits a csv file into a number of files each containing N batches.

This is useful if you have a large amount of input data that you are using to make changes to objects in a cloud service and you are restricted to only a number of changes in a certain timeframe. You can use this PowerShell script to break up the master file into a number of files, each containing the number of objects (rows) you specify. 

An example of where you used to need this type of setup was to set custom address books policies for exchange online. 
