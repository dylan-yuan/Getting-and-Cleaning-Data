# 1.Merges the training and the test sets to create one data set.
#merge rows
x_train <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\train\\X_train.txt")
x_test <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\test\\X_test.txt")
x_all <- rbind(x_train, x_test)
#merge subjects
subject_train <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\train\\subject_train.txt")
subject_test <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\test\\subject_test.txt")
subject_all <- rbind(subject_train, subject_test)
#merge columns
y_train <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\train\\y_train.txt")
y_test <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\test\\y_test.txt")
y_all <- rbind(y_train, y_test)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\features.txt")
# Extracting only the mean and standard deviation from the "features.txt"
features2 <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
x_all <- X_all[, indices_of_good_features]
# Replaces all matches of a string features 
names(x_all) <- gsub("\\(|\\)", "", (features[features2, 2]))

# 3. Uses descriptive activity names to name the activities in the data set
activities <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
y_all[,1] = activities[y_all[,1], 2]
names(y_all) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.
names(subject_all) <- "subject"
cleaned <- cbind(subject_all, y_all, x_all)
write.table(cleaned, "file1.txt")

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#write to text file on disk
write.table(result,file="TidyDataSet.txt", row.name=FALSE)
