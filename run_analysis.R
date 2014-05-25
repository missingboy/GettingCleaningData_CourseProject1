## Load "reshape2" package
library(reshape2)

## Download, unzip and load data 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./data")){dir.create("./data")}
download.file(fileUrl,destfile="./data/smartphone.zip", method= "internal")
unzip("./data/smartphone.zip",exdir="./data")

## Generate training set

xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
trainSet <- cbind(subTrain,yTrain,xTrain)
xLabel <- readLines("./data/UCI HAR Dataset/features.txt")
xLabel <- append(xLabel,"subject",after=0)
xLabel <- append(xLabel,"activity",after=1)
colnames(trainSet) <- xLabel

## Generate testset 

xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
testSet <- cbind(subTest,yTest,xTest)
colnames(testSet) <- xLabel

## Combine trainset and testset 
combined1 <- rbind(xTrain, xTest)
combined2 <- rbind(yTrain, yTest)
combined3 <- rbind(subTrain,subTest)
completeSet <- cbind(combined3,combined2,combined1)
colnames(completeSet) <- xLabel 

## Subset complete dataset to get columns with mean or std, 
## together with subject number and activity 
meanCol <- grep("mean",xLabel,ignore.case=TRUE)
sdCol <- grep("std",xLabel)
subset <- c(c(1,2),meanCol, sdCol)
subset <- sort(subset)
meanSD <- completeSet[ ,subset]

## Convert numbering of activities into descriptive terms 
meanSD[ ,2] <- gsub(1,"walking",meanSD[ ,2])
meanSD[ ,2] <- gsub(2,"walkingUpstairs",meanSD[ ,2])
meanSD[ ,2] <- gsub(3,"walkingDownstairs",meanSD[ ,2])
meanSD[ ,2] <- gsub(4,"sitting",meanSD[ ,2])
meanSD[ ,2] <- gsub(5,"standing",meanSD[ ,2])
meanSD[ ,2] <- gsub(6,"laying",meanSD[ ,2])
meanSD[ ,2] <- as.factor(meanSD[ ,2])
meanSD[ ,1] <- as.factor(meanSD[ ,1])

## Re-label the dataset with descriptive activity names 
columnNames <- names(meanSD)
columnNames <- gsub("Acc","Acceleration",columnNames)
columnNames <- gsub("Gyro","Gyroscope",columnNames)
columnNames <- gsub("-","",columnNames)
columnNames <- gsub("\\()","",columnNames)
columnNames <- gsub("mean","Mean",columnNames)
columnNames <- gsub("std","Std",columnNames)
columnNames <- gsub("fBody","",columnNames)
columnNames <- gsub("tBody","",columnNames)
columnNames <- gsub("^[0-9] |^[0-9][0-9] |^[0-9][0-9][0-9] ","",columnNames)
colnames(meanSD) <- columnNames
write.table(meanSD, file="SamsungActivity.txt", row.names = FALSE, col.names=TRUE,sep="\t")

## Creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject.
meanSDl <- melt(meanSD,id=c("subject","activity"))
meanSDw <- dcast (meanSDl, subject+activity~variable, mean)
write.table(meanSDw, file="SamsungActivityMean.txt", row.names = FALSE, col.names=TRUE,sep="\t")
