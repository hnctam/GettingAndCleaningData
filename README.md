# Problem
## There are 2 separated data inputs: train data and test data
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Solution
## First step is to merge train and test data together
## then we will filter data with mean and stdev columns
## Bind the activity names as "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
## and write tiny data to destination file using write.table() and row.names=FALSE
# How to run
## Download the data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Extract the zip data to [Working_Folder]/data/UCI HAR Dataset
## Kindly check the existing of this path to make sure setup properly
### [Working_Folder]\data\UCI HAR Dataset\features.txt
## Create folder [Working_Folder]\output
## Type: source("run_analysis.R") in R-console
## Type: build_tidy_dataset()
## Check result in folder [Working_Folder]\output