
## 1. Merges the training and the test sets to create one data set.

# get the train data
xTrain <- read.table(file = "train/X_train.txt")
yTrain <- read.table(file = "train/y_train.txt")
subjectTrain <- read.table(file = "train/subject_train.txt")
trainSet <- cbind(subjectTrain, yTrain, xTrain)

# get the test data
xTest <- read.table(file = "test/X_test.txt")
yTest <- read.table(file = "test/y_test.txt")
subjectTest <- read.table(file = "test/subject_test.txt")
testSet <- cbind(subjectTest, yTest, xTest)

# combine test and train data into one data set
dataSet <- rbind(trainSet, testSet)
colnames(dataSet) <- c("Subject", "Activity")
# remove unnecessary data
rm(subjectTest, subjectTrain, xTest, xTrain, yTest, yTrain, testSet, trainSet)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("features.txt", stringsAsFactors = FALSE)
features <- features$V2
## use regular expression to get columns position which name include "mean" or "std"
meanPos <- grep("mean\\(\\)", tolower(features))
stdPos <- grep("std\\(\\)", tolower(features))
pos <- sort(c(meanPos, stdPos))
dataSet <- dataSet[, c(1, 2, pos+2)]

## 3. Uses descriptive activity names to name the activities in the data set

# translate corresponding number to activity names as in activity_labels.txt 
activities <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
activities <- activities$V2
activityName <- function(x){activities[x]}
dataSet$Activity <- sapply(dataSet$Activity, activityName)

## 4. Appropriately labels the data set with descriptive variable names. 

# add feature names to the data set columns as in features.txt
colnames(dataSet) <- c("Subject", "Activity", features[pos])
rm(activities, features, meanPos, stdPos, pos, activityName)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
final <- dataSet %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
#write.table(final, file="final.txt", row.names=FALSE)