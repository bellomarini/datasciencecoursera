#setwd("/Users/luigibellomarini/doc/uni/corsi_presentazioni_altri/coursera/getting_and_cleaning_data/project/UCI HAR Dataset")
# fetches measurements
library(plyr)
test <- read.table("test/X_test.txt", colClasses=numeric())
train <- read.table("train/X_train.txt", colClasses=numeric())

# load variable names
variables <- read.table("features.txt")

# fetches data about activities
test_activities <- read.table("test/y_test.txt")
train_activities <- read.table("train/y_train.txt")
activity_labels <- read.table("activity_labels.txt")

# merges 
merged <- rbind(test,train)
activities <- rbind(test_activities,train_activities)

# decodes activities
decoded_activities <- merge(activities, activity_labels, by.x="V1",by.y="V1", sort=FALSE)[2]
names(decoded_activities) <- "activity"

#sets variable names
names(merged) <- variables$V2

# gets the variables for mean and standard deviation
mean_std_pos <- grep("mean|std",names(merged))
# subsets the data frame
merged_mean_std <- merged[,mean_std_pos]

# tidy ds
tidy_ds <- data.frame(decoded_activities, merged_mean_std)

# extracts and merges the subjects
subject_test <- read.table("test/subject_test.txt") 
subject_train <- read.table("train/subject_train.txt") 
subjects <- rbind(subject_test, subject_train)
names(subjects) <- "subject"

tidy_ds2 <- cbind(tidy_ds, subjects)
tidy_ds3<- aggregate(tidy_ds2, by=list(tidy_ds2$activity,tidy_ds2$subject), FUN=mean)
tidy_ds3$activity = NULL
tidy_ds3$subject = NULL
tidy_ds4 <- rename(tidy_ds3,c("Group.1"="activity","Group.2"="subject"))

write.table(tidy_ds4,"output_dataset.txt",row.name=FALSE)
