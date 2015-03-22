# Code to read in and assemble the SAmsung data into a tidy data set of summarized means
# Note:  the code assumes the data has been extracted from the zip and all relevant files 
# copied into the working directory


# first, read all the relevant tables into R, including the feature names and activities
train_subjects<-read.table("subject_train.txt")
train_activities<-read.table("y_train.txt")
train_values<-read.table("X_train.txt", sep="")
test_subjects<-read.table("subject_test.txt")
test_activities<-read.table("y_test.txt")
test_values<-read.table("X_test.txt", sep="")
feature_names<-read.table("features.txt", sep="")
activity_labels<-read.table("activity_labels.txt", sep="")

# now, start to join together the relevant test and train data, start with activities
all_activities<-rbind(test_activities,train_activities)
# replace the activity numbers with the relevant label.  I used SQL to do this by joining the
# label to the activity table (V1 is the code number on both the data table and the labels)
library(sqldf)
labelled_activities<-sqldf("SELECT V2 FROM all_activities left join activity_labels
                           USING (V1)")
# similarly, combine test & train for subjects and the main data values
all_subjects<-rbind(test_subjects,train_subjects)
all_values<-rbind(test_values,train_values)
# now use the feature names as column names
colnames(all_values)<-feature_names[,2]
# only keep the mean and std variables that we later want to analyse
subset_av<-all_values[,grepl("mean()|std()",colnames(all_values))]
# now join together the data to assemble the full data set
full_data<-cbind(all_subjects,labelled_activities,subset_av)
# name the subject and activity columns.  Now all columns will have a proper name
colnames(full_data)[1]<-"Subject"
colnames(full_data)[2]<-"Activity"
# finally, create the tidy data set of means that is the output, and write it
av_data<- aggregate( . ~ Subject+Activity, full_data, mean)
write.table(av_data, file="av_data.txt", row.name=FALSE)