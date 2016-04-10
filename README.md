# Getting-and-Cleaning-Data-Course-Project
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The main script of this repository is run_analysis.R which is doing the following:

1- Download compressed data set and uncompress it into the working folder. The files will be created if they did not exist before,
2- Load activity labels and features,
3- Extracts only the measurements on the mean and standard deviation for each measurement,
4- Load the datasets (training and testing data sets),
5- Merge datasets train and test data,
6- Appropriately assign label the data set with descriptive variable names,
7- Write TIDY data into text file describing each Subject, Activity, and other variables fetched from activity labels
      Each row describes variables for each: SUBJECT & ACTIVITY
      
