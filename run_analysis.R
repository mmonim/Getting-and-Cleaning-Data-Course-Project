## The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

##The main script of this repository is run_analysis.R which is doing the following:
  
##  1- Download compressed data set and uncompress it into the working folder. The files will be created if they did not exist before,

install.packages("reshape2")  ## to use melt and dcast functions during building "tidy" text file  
library(reshape2)

setwd("Coursera/Data Science-Getting and Cleaning Data")
filename <- "Human_Activity_dataset.zip"

## check if file exists or downloaded before
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  

## uncompress the file into a new folder called UCI HAR Dataset
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## - 'activity_labels.txt': Links the class labels with their activity name.

# Load activity labels + features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])   ## second column = LABELS - coerce it into charcater vector
features <- read.table("UCI HAR Dataset/features.txt")   ## Read features list
features[,2] <- as.character(features[,2])

## Extracts only the measurements on the mean and standard deviation for each measurement.

RequiredFeatures <- grep(".*mean.*|.*std.*", features[,2])
RequiredFeaturesNames <- features[RequiredFeatures,2]
RequiredFeaturesNames = gsub('-mean', 'Mean', RequiredFeaturesNames)
RequiredFeaturesNames = gsub('-std', 'Std', RequiredFeaturesNames)
RequiredFeaturesNames <- gsub('[-()]', '', RequiredFeaturesNames)

## load datasets
# Load the datasets
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")[RequiredFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainData <- cbind(trainSubjects, trainActivities, trainData)


## Load test data

testData <- read.table("UCI HAR Dataset/test/X_test.txt")[RequiredFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testData <- cbind(testSubjects, testActivities, testData)

# Merge datasets train and test data
FullData <- rbind(trainData, testData)   ## bind 2 data sets by rows

## Appropriately labels the data set with descriptive variable names.
colnames(FullData) <- c("Subject", "Activity", RequiredFeaturesNames)

# turn activities & subjects into factors
FullData$Activity <- factor(FullData$Activity, levels = activityLabels[,1], labels = activityLabels[,2])
FullData$Subject <- as.factor(FullData$Subject)

## Convert columns into one row
FullDataMelted <- melt(FullData, id = c("Subject", "Activity"))

FullDataMean <- dcast(FullDataMelted, Subject + Activity ~ variable, mean)

## Write TIDY data into text file describing each subject, Activity, and other variables fetched from activity labels
## Each row describes variables for each: SUBJECT & ACTIVITY  
write.table(FullDataMean, "tidy.txt", row.names = FALSE, quote = FALSE)










