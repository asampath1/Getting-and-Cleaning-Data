Getting-and-Cleaning-Data
=========================
DataSource for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Creater this  R script called run_analysis.R that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


output files

* MergedCleanData.txt file  - Merged Clean data.txt output file  will have features.txt file and activity_labels.txt  cleaned and merged together.

* DataSet_Averages.txt file  - independent tidy data set with the average of each variable for each activity and each subject.


Scripts logic

* Firstly read the training and test file for X
* Merge using rbind function
* Read the subject_train and subject Test files - Each row identifies the subject who performed the activity for each window sample.  Its range is from 1 to 30
* The extract the measurements on the mean and standard deviation for each measurement using grep and gsub function

(grep search for matches to argument pattern within each element of a character vector.
gsub perform replacement of the first and all matches respectively.
tolower () - Translate characters in character vectors, in particular from upper to lower case or vice versa)

* Read the activity_labels.txt file that links the class labels with their activity name.
* Create clean and completly merged data set
* Finally create independent tidy data set with the average of each variable for each activity and each subject. using unique function and by using for loop

* We may check the results by executing the following in the R console
* > res2 <- read.table("DataSet_Averages.txt")
* > result[4,4]
* [1] -0.001308288
* > res2[4,4]
* [1] -0.001308288
* > res2[4,4]==result[4,4]
* [1] FALSE
* > result[6,4]
* [1] -0.04051395
* > res2[6,4]
* [1] -0.04051395
* > res2[6,4]==result[6,4]
* [1] TRUE


