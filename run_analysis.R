library(reshape2)

## Preliminaries: Download the data set and set the working directory

#create a directory called "data" if it does not already exist
if(!file.exists("data"))
{
  dir.create("data")
}

#Download the zipped data set file to the data directory
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "data/zipped_data.zip")

#unzip the data set file in the data directory
unzip("data/zipped_data.zip",exdir="./data")

#set the working directory to the location of the dataset
setwd("./data/UCI HAR Dataset")

# Step 1
# Merge the training and test sets to create one data set
###############################################################################

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)

# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################

features <- read.table("features.txt")

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean\\(\\)|std\\(\\))", features[, 2])

# subset the desired columns
select_x_data <- x_data[, mean_and_std_features]

# give descriptive feature names to columns
names(select_x_data) <- features[mean_and_std_features, 2]

# Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################

activities <- read.table("activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(select_x_data, y_data, subject_data)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# 66 <- 68 columns but last two (activity & subject)
melt_all_data <- melt(all_data,id=c("subject","activity"),measure.vars=names(all_data)[-c(67,68)])
averaged_data <- dcast(melt_all_data,subject+activity~variable,mean)

write.table(averaged_data, "averaged_data.txt", row.name=FALSE)