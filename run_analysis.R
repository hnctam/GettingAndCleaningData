## Create one R script called run_analysis.R that does the following.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for
##    each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set
##    with the average of each variable for each activity and each subject.

library(plyr)

# Create tidy dataset and  output to /output/tidy-data.txt
build_tidy_dataset <- function() {
    # Merge training and test datasets
    message("Merge training and test datasets. merge_data function returns a list[x,y,subject]")
    mergedData <- merge_data()
    # Filter Mean and Stdev columns
    xColumn <- filter_mean_and_stdev(mergedData$x)
    # Bind column name
    yColumn <- bind_activity_name(mergedData$y)
    # Use descriptive column name for subjects
    colnames(mergedData$subject) <- c("subject")
    # Bind column data to created final result
    finalDataset <- cbind(xColumn, yColumn, mergedData$subject)
    # Create tidy dataset
	message("Create the tidy data set")
	tidyDataset <- ddply(finalDataset, .(subject, activity), function(x) colMeans(x[,1:60]))
    # Write tidy dataset as text file
	message("Write tidy data as text file using method write.table and row.names=FALSE")
    write.table(tidyDataset, file = "./output/tidy-data.txt", row.names=FALSE)
}

# Filter Mean and Stdev columns from raw data
filter_mean_and_stdev <- function(data) {
    message("Read the data/UCI HAR Dataset/features.txt")
    features <- read.table("data/UCI HAR Dataset/features.txt")
    # Find the mean and stdev column names
    message("Find Mean and Stdev columns")
    meanColumn <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
    stdevColumn <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
    # Filter Mean and Stdev from the raw data
    message("Filter only Mean and Stdev column")
    filterData <- data[, (meanColumn | stdevColumn)]
    colnames(filterData) <- features[(meanColumn | stdevColumn), 2]
    return (filterData)
}
# Bind the activity column with names
bind_activity_name <- function(data) {
    colnames(data) <- "activity"
    data$activity[data$activity == 1] = "WALKING"
    data$activity[data$activity == 2] = "WALKING_UPSTAIRS"
    data$activity[data$activity == 3] = "WALKING_DOWNSTAIRS"
    data$activity[data$activity == 4] = "SITTING"
    data$activity[data$activity == 5] = "STANDING"
    data$activity[data$activity == 6] = "LAYING"
    return (data)
}

# Merge train and test data
# Return list of 3 merged items: [x, y, subject]
merge_data <- function() {
    message("Merge train and test datasets")
    # Read train data
    message("Read data/UCI HAR Dataset/train/X_train.txt")
    xTrain <- read.table("data/UCI HAR Dataset/train/X_train.txt")
    message("Read data/UCI HAR Dataset/train/y_train.txt")
    yTrain <- read.table("data/UCI HAR Dataset/train/y_train.txt")
    message("Read data/UCI HAR Dataset/train/subject_train.txt")
    subjTrain <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
	# Read test data
    message("Read data/UCI HAR Dataset/test/X_test.txt")
    xTest <- read.table("data/UCI HAR Dataset/test/X_test.txt")
    message("Read data/UCI HAR Dataset/test/y_test.txt")
    yTest <- read.table("data/UCI HAR Dataset/test/y_test.txt")
    message("Read data/UCI HAR Dataset/test/subject_test.txt")
    subjTest <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
    # Merge
    message("Merge X")
    xMerge <- rbind(xTrain, xTest)
    message("Merge y")
    yMerge <- rbind(yTrain, yTest)
    message("Merge subject")
    subjMerge <- rbind(subjTrain, subjTest)
    # merge train and test datasets and return
    message("Return the list [xMerge, yMerge, subjectMerge]")
    list(x=xMerge, y=yMerge, subject=subjMerge)
}



