library(reshape2)

## Step 0: Download the data set and set the working directory
##############################################################

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

## Step 1: Merges the training and the test sets to create one data set
###############################################################################

#read in the names of all of the features
features <- read.table("features.txt")

#read in the features data
features_train <- read.table("train/X_train.txt")
features_test <- read.table("test/X_test.txt")
features_data <- rbind(features_train,features_test)
names(features_data) <- features[,2] #give descriptive column headings

#read in the activities data
activities_train <- read.table("train/y_train.txt")
activities_test <- read.table("test/y_test.txt")
activities_data <- rbind(activities_train,activities_test)
names(activities_data) <- 'Activity' #change the column heading

#read in the subjects data
subjects_train <- read.table("train/subject_train.txt")
subjects_test <- read.table("test/subject_test.txt")
subjects_data <- rbind(subjects_train,subjects_test)
names(subjects_data) <- 'Subject' #change the column heading


#concatenate the subjects, activities, and features data 
all_data <- cbind(subjects_data,activities_data,features_data)


# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################


#determine which features have mean() or std() in their names
mean_and_std_features <- grep("-(mean\\(\\)|std\\(\\))", features[, 2])

#extract the desired columns from the features data set
selected_features_data <- features_data[,mean_and_std_features]

#concatenate the subjects, activities, and selected features data sets
mean_and_std_data <- cbind(subjects_data,activities_data,selected_features_data)

##Step 3: Use descriptive activity names to name the activities in the data set
###############################################################################

#read in the different activity types
activity_labels <- read.table("activity_labels.txt")

# update values with correct activity names
all_data$Activity <- activity_labels[all_data$Activity, 2]
mean_and_std_data$Activity <- activity_labels[mean_and_std_data$Activity,2]

##Step 4:
# Appropriately label the data set with descriptive variable names
###############################################################################

# The columns were already named in Step 1, but in this step, I will 
# clean up the variable names a little more
for (i in 3:length(names(mean_and_std_data))) 
{
  #the prefix t represents time
  names(mean_and_std_data)[i] = gsub("^(t)","time-",names(mean_and_std_data)[i])
  
  #the prefix f represents frequency
  names(mean_and_std_data)[i] = gsub("^(f)","freq-",names(mean_and_std_data)[i])
  
  #removes extra parentheses after mean and std
  names(mean_and_std_data)[i] = gsub("\\()","",names(mean_and_std_data)[i])
  
  #removes the duplicate in variables named BodyBody
  names(mean_and_std_data)[i] = gsub("[Bb]ody[Bb]ody","Body",names(mean_and_std_data)[i])
};

# At this point, mean_and_std data is a tidy data set consisting of 
# 10299 observations of 563 variables (2 identifiers and 561 feature measurements)


##Step 5: Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

#reshape the data so that there is one row for each subject+activity pairing
#with averages given
melted_data <- melt(mean_and_std_data,id=c('Subject','Activity'),measure.vars=names(mean_and_std_data)[-(1:2)])
averaged_data <- dcast(melted_data,Subject+Activity~variable,mean)

#write the tidy data to a text file
write.table(averaged_data, "tidy_averages.txt", row.name=FALSE)

#this final tidy dataset contains 180 observations of 
#68 variables (2 identifiers and 66 feature measurements)