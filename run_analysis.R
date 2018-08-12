library(plyr)

if(!file.exists("./ProjectDataset.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = "./ProjectDataset.zip", method = "curl")
}

if(!file.exists("UCI HAR Dataset")) {
  unzip(zipfile = "./ProjectDataset.zip")
}


features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
featuresReq <- grep("-(mean|std)\\(\\)", features[,2])

testSubject   <- read.table("UCI HAR Dataset/test/subject_test.txt")
testActivity  <- read.table("UCI HAR Dataset/test/y_test.txt")
testFeatures  <- read.table("UCI HAR Dataset/test/x_test.txt")[featuresReq]
test <- cbind(testSubject, testActivity, testFeatures)

trainSubject  <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt")
trainFeatures <- read.table("UCI HAR Dataset/train/x_train.txt")[featuresReq]
train <- cbind(trainSubject, trainActivity, trainFeatures)

mergedData <- rbind(test, train)

colnames(mergedData) <- c("subject", "activity", features[featuresReq, 2])

actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actLabels[,2] <- as.character(actLabels[,2])
mergedData$activity <- factor(mergedData$activity)
mergedData$activity <- factor(mergedData$activity, labels = as.character(actLabels$V2))

names(mergedData) <- gsub("^t", "time", names(mergedData))
names(mergedData) <- gsub("^f", "frequency", names(mergedData))
names(mergedData) <- gsub("Acc", "Accelerometer", names(mergedData))
names(mergedData) <- gsub("Gyro", "Gyroscope", names(mergedData))
names(mergedData) <- gsub("Mag", "Magnitude", names(mergedData))
names(mergedData) <- gsub("BodyBody", "Body", names(mergedData))

tidyData <- aggregate(. ~subject + activity, mergedData, mean)
tidyData <- tidyData[order(tidyData$subject, tidyData$activity),]

write.table(tidyData, file = "tidyData.txt", row.names = FALSE)



