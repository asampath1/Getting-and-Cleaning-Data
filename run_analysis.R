
# DataSource for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
# A full description is available at the site where the data was obtained: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# 1. Merges the training and the test sets to create one data set.
X <- rbind(read.table("train/X_train.txt"), read.table("test/X_test.txt"))

# subject_train.txt - Each row identifies the subject who performed the activity for each window sample. 
#Its range is from 1 to 30. 

S <- rbind(read.table("train/subject_train.txt"), read.table("test/subject_test.txt"))
Y <- rbind(read.table("train/y_train.txt"), read.table("test/y_test.txt"))

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

#grep search for matches to argument pattern within each element of a character vector.
#gsub perform replacement of the first and all matches respectively.
#tolower () - Translate characters in character vectors, in particular from upper to lower case or vice versa

# Refer features_info text file for the details of the features description
features <- read.table("features.txt")
good_features_index <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, good_features_index]
names(X) <- features[good_features_index, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))  

# 3. Uses descriptive activity names to name the activities in the data set

# activity_labels.txt - Links the class labels with their activity name.
activities <- read.table("activity_labels.txt") 
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
mergedCleaned <- cbind(S, Y, X)
write.table(mergedCleaned, "MergedCleanData.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
#unique returns a vector, data frame or array like x but with duplicate elements/rows removed.
uniqueCases = unique(S)[,1] 
totCases = length(unique(S)[,1])
eachActivities = length(activities[,1])
numCols = dim(mergedCleaned)[2]
final = mergedCleaned[1:(totCases*eachActivities), ]

row = 1 # initialize to 1

for (s in 1:totCases) {
  for (a in 1:eachActivities) {
    final[row, 1] = uniqueCases[s]
    final[row, 2] = activities[a, 2]
    tmp <- mergedCleaned[mergedCleaned$subject==s & mergedCleaned$activity==activities[a, 2], ]
    final[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(final, "DataSet_Averages.txt")
