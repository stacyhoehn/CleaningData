---
title: "Codebook"
author: "Stacy Hoehn"
date: "October 16, 2016"
output: html_document
---

This codebook will explain the variables, the data, and transformations I performed to clean up the data.

### The Original Data

The original data can be obtained from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
)  

The data for the experiments recorded within this dataset were carried out with a group of 30 volunteers aged 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the authors of the study captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.  The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

To see a more thorough description of the original dataset, you can view
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


## The Transformations

The training and test data were merged back together to obtain a single dataset that contained 563 columns: the subject's ID number, the activity type ID, and 561 feature measurements.   The activity ID was then replaced by a descriptive label for the type of activity that was performed; for example, an activity ID of "1" was replaced with "WALKING".  Each column was also given a more descriptive name, like "Subject", "Activity", or a description of the feature measurement from features_info.txt.  This produced a tidy dataset containing 10,299 observations of 563 variables (2 identifiers and 561 feature measurements).

To obtain a smaller tidy dataset, only those columns containing information about the mean and standard deviation for each measurement  were extracted.  I interpreted these directions to include only those columns that contained the substring mean() or std() in their name.  This dataset was then reshaped so that it contained only one row for each of the 180 possible subject + activity pairs, with the feature measurements being averaged.  This resulted in a new tidy dataset with 180 observations of 68 variables (2 identifiers and 66 feature measurement averages).    

## The Variables 

### Identifiers

* Subject - the ID (1-30) assigned to each subject
* Activity - the type of activity that each subject was performing during the test

### Activity Labels
1. WALKING - subject was walking during the test
2. WALKING_UPSTAIRS - subject was walking up a staircase during the test
3. WALKING_DOWNSTAIRS - subject was walking down a staircase during the test
4. SITTING - subject was sitting during the test
5. STANDING - subject was standing during the test
6. LAYING - subject was laying down during the test

### Features

According to features_info.txt, "the features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals)." 

The specific feature measurements involving mean() or std() that remained in our tidy data set are listed below.  The variable names given below differ from the original variable names slightly in order to make them more descriptive.  The prefix 't' was replaced with 'time' to indicate that these are from time domain signals, while the prefix 'f' was replaced with 'freq' to indicate that these are from frequency domain signals.  The extra parentheses after mean() and std() were also removed.  

Note that in the variables below, '-XYZ' is used as shorthand to indicate three separate feature measurements that only differ in terms of the axial direction.  For example, time-BodyAcc-mean-XYZ represents time-BodyAcc-mean-X, time-BodyAcc-mean-Y, and time-BodyAcc-mean-Z.

* time-BodyAcc-mean-XYZ  
* time-BodyAcc-std-XYZ 
* time-GravityAcc-mean-XYZ
* time-GravityAcc-std-XYZ
* time-BodyAccJerk-mean-XYZ
* time-BodyAccJerk-std-XYZ
* time-BodyGyro-mean-XYZ 
* time-BodyGyro-std-XYZ
* time-BodyGyroJerk-mean-XYZ
* time-BodyGyroJerk-std-XYZ
* time-BodyAccMag-mean
* time-BodyAccMag-std 
* time-GravityAccMag-mean 
* time-GravityAccMag-std  
* time-BodyAccJerkMag-mean
* time-BodyAccJerkMag-std
* time-BodyGyroMag-mean
* time-BodyGyroMag-std
* time-BodyGyroJerkMag-mean
* time-BodyGyroJerkMag-std
* freq-BodyAcc-mean-XYZ
* freq-BodyAcc-std-XYZ 
* freq-BodyAccJerk-mean-XYZ
* freq-BodyAccJerk-std-XYZ  
* freq-BodyGyro-mean-XYZ
* freq-BodyGyro-std-XYZ 
* freq-BodyAccMag-mean 
* freq-BodyAccMag-std 
* freq-BodyAccJerkMag-mean
* freq-BodyAccJerkMag-std
* freq-BodyGyroMag-mean
* freq-BodyGyroMag-std
* freq-BodyGyroJerkMag-mean
* freq-BodyGyroJerkMag-std

Note that all of the feature measurements are normalized and bounded within [-1,1].

