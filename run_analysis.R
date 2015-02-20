# 1.Merges the training and the test sets to create one data set.

x_train <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\train\\X_train.txt")
x_test <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\test\\X_test.txt")
x_all <- rbind(x_train, x_test)

subject_train <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\train\\subject_train.txt")
subject_test <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\test\\subject_test.txt")
subject_all <- rbind(subject_train, subject_test)

y_train <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\train\\y_train.txt")
y_test <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\test\\y_test.txt")
y_all <- rbind(y_train, y_test)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("C:\\Users\\Admin\\Desktop\\UCI HAR Dataset\\features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
x_all <- X_all[, indices_of_good_features]
names(x_all) <- features[indices_of_good_features, 2]
names(x_all) <- gsub("\\(|\\)", "", names(x_all))
names(x_all) <- tolower(names(x_all))

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
Subjects = unique(subject_all)[,1]
numSubjects = length(unique(subject_all)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
	for (a in 1:numActivities) {
		result[row, 1] = Subjects[s]
		result[row, 2] = activities[a, 2]
		tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
		result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
		row = row+1
	}
}
write.table(result,file="TidyDataSet.txt", row.name=FALSE)
