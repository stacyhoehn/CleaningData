---
title: "README"
author: "Stacy Hoehn"
date: "October 16, 2016"
output: html_document
---

The run_analysis.R script processes data from a series of files in the original data set, which can be obtained from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip,](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
) and produces two tidy datasets through the following procedure.

1. Download and unzip the original data set. 
2. Merge the training and the test sets to create one data set by:
  
  + Merging the features data from the "train/X_train.txt" and          "test/X_test.txt" files into a new data frame called "features_data".     
  + Merging the activities data from the "train/y_train.txt" and test/y_test.txt" files into a new data frame called "activities_data".

  + Merging the subjects data from the "train/subject_train.txt" and test/subject_test.txt" files into a new data frame called "subjects_data".

  + Merging the "subjects_data", "activities_data", and "features_data" dataframes to create a single dataset consisting of 10,299 observations of 563 variables (2 identifiers and 561 feature measurements).

3. Extract only the measurements on the mean and standard deviation for each measurement into a new dataset called "mean_and_std_data".  (I interpreted this to mean only measurements that contain mean() or std() in their names.)

4. Use descriptive activity names to rename the activities in the data set.  For example, the activity ID of 1 was replaced by "WALKING".  The "activity_labels.txt" file from the original dataset was used to establish these correspondences.

5. Appropriately label the data set with descriptive variable names. The columns were already named in the previous steps, but in this step, the variable names are cleaned up and made more descriptive. For example, the prefix 't' in feature measurements was replaced with 'time' to indicate that these are from time domain signals, while the prefix 'f' was replaced with 'freq' to indicate that these are from frequency domain signals.  The extra parentheses after mean() and std() were also removed.  At this point, "mean_and_std data" is a tidy dataset consisting of 
10,299 observations of 68 variables (2 identifiers and 66 feature measurements).

6. Create a second, independent tidy dataset with the average of each variable.  This dataset has one row for each Subject+Activity pair and the average is given for each of the 66 selected feature measurements.

7. Write this final tidy dataset to a file, "tidy_averages.txt". This final tidy dataset contains 180 observations of 68 variables (2 identifiers and 66 feature measurements).


To view the final tidy dataset, you can download "tidy_averages.txt" to your computer and enter the following commands in R, where `file_path` is replaced with the path to the location where you stored "tidy_averages.txt" on your computer. 

```
tidy_data <- read.table(file_path, header = TRUE) 
View(tidy_data)
```