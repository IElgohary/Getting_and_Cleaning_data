library(plyr)
# 1.Merge the training and the test sets to create one data set

#load and rename labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
colnames(activityLabels) <- c("activityId", "activity")

#load features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

#load X data and rename columns
Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(Xtrain) <- features[,2]
colnames(Xtest) <- features[,2]

#load Y data and rename columns
Ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
Ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
colnames(Ytrain) <- "activityId"
colnames(Ytest) <- "activityId"

#load subject data and rename columns
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(subjectTrain) <- "subjectId"
colnames(subjectTest) <- "subjectId"

#merge data into one dataset
Xdata <- rbind(Xtrain, Xtest)
Ydata <- rbind(Ytrain, Ytest)
subjectData <- rbind(subjectTrain, subjectTest)

data <- cbind(Xdata, Ydata, subjectData)

######################################################################
# 2.Extract only the measurements on the mean and standard deviation for each measurement

#get columns contatining only the Std and mean 
stdAndMean <- grep("(mean|std)\\(\\)",features[,2])

#subset the std, mean and Id columns
data <- data[,c(stdAndMean,562,563)]

######################################################################
# 3.Use descriptive activity names to name the activities in the data set

#merge dataset with the activity_labels
data <- merge(data, activityLabels, by = "activityId", all.x = T)

######################################################################
# 4.Appropriately label the data set with descriptive variable names

#get descreptive name of every variable
columns <- names(data)
for(i in 1:length(names(data)))
{
    columns[i] <- gsub("\\(\\)", "", columns[i])
    columns[i] <- gsub("^t","Time", columns[i] )
    columns[i] <- gsub("^f","Frequency", columns[i] )
    columns[i] <- gsub("[Aa]cc", "Acceleration", columns[i] )
    columns[i] <- gsub("[Mm]ag", "Magnitude", columns[i] )
    columns[i] <- gsub("std","StandardDeviation", columns[i] )
    columns[i] <- gsub("mean","Mean", columns[i] )
}

#rename vsriables in dataset
colnames(data) <- columns

######################################################################
# 5.Create a second, independent tidy data set with the average of each variable for each activity and each subject

dataWithAverage<- ddply(data, .(subjectId, activityId), function(x) colMeans(x[, 1:66]))
#create new file with the new dataset
write.table(dataWithAverage, "finalData.txt", row.names = FALSE)
