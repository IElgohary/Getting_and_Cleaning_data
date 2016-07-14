# Analysis steps:

#### Step 1 : Merge the training and the test sets to create one data set

>load the files from the original dataset into the workspace and rename the columns to make the processing easier then merge all the data into one data set.

#### Step 2 : Extract only the measurements on the mean and standard deviation for each measurement

> subsets only the variables related to either the standard deviation or the mean.
  
#### Step 3 : Use descriptive activity names to name the activities in the data set

>merge the current data set with the activity_label.txt table to add a new variable containing the activity.

#### Step 4 : Appropriately labels the data set with descriptive variable names

>edit variable names of the new data set to make them more descriptive 

#### Step 5 : Create a second, independent tidy data set with the average of each variable for each activity and each subject

> melt the dataset to define the id variables as subject id and activity id then casting it to a new dataset while averaging the variables, and finally, saves the resulting dataset in a new file.

#Data 

The data used is downloaded from : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Identifiers

- subjectId
- activityId

#Variables of the Produced Dataset

The values are the average of each of the variables.
The prefix "Time" represent the time domain while "Frequency" represents the frequency domain.
