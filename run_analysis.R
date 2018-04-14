library(reshape2)

tName <- "getdata_dataset.zip"

## download the given data into R and unzip it
if (!file.exists(tName)){
  fURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fURL, tName, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(tName) 
}

# load activity features and labels
actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actLabels[,2] <- as.character(actLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
featuWanted <- grep(".*mean.*|.*std.*", features[,2])
featWanted.names <- feat[featWanted,2]
featWanted.names = gsub('-mean', 'Mean', featWanted.names)
featWanted.names = gsub('-std', 'Std', featWanted.names)
featWanted.names <- gsub('[-()]', '', featWanted.names)


# load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

#binding 

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featWanted.names)

# turn subjects and activites into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
