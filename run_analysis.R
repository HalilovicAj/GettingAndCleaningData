#Setting wd and downloading the files
#setwd("C:/Users/admin/Desktop/Coursera R Prog/")
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="./Dataset.zip")

#Reading variable names
features <- read.csv("./Dataset/UCI HAR Dataset/features.txt",sep = "",dec = ".",header=FALSE)

#Reading test data and naming the variables
X_test <- read.csv("./Dataset/UCI HAR Dataset/test/X_test.txt",sep = "",dec = ".",header=FALSE)
colnames(X_test) <- features[,2]

y_test <- read.csv("./Dataset/UCI HAR Dataset/test/y_test.txt",sep = "",dec = ".",header=FALSE)
colnames(y_test) <- "Activity"

subject_test <- read.csv("./Dataset/UCI HAR Dataset/test/subject_test.txt",sep = "",dec = ".",header=FALSE)
colnames(subject_test) <- "Subject"

#Reading train data and naming the variables
X_train <- read.csv("./Dataset/UCI HAR Dataset/train/X_train.txt",sep = "",dec = ".",header=FALSE)
colnames(X_train) <- features[,2]

y_train <- read.csv("./Dataset/UCI HAR Dataset/train/y_train.txt",sep = "",dec = ".",header=FALSE)
colnames(y_train) <- "Activity"

subject_train <- read.csv("./Dataset/UCI HAR Dataset/train/subject_train.txt",sep = "",dec = ".",header=FALSE)
colnames(subject_train) <- "Subject"


#Putting together test and train data
test <- cbind(subject_test,y_test,X_test)
train <- cbind(subject_train,y_train,X_train)

#Merging test and train data into one dataset
dataset <- rbind(train,test)
dim(dataset)

#Using descriptive activity names
activity_labels <- read.csv("./Dataset/UCI HAR Dataset/activity_labels.txt",sep = "",dec = ".",header=FALSE)
dataset <- merge(dataset,activity_labels, by.x = "Activity", by.y = "V1") 
dataset$Activity <- dataset$V2
dataset <- dataset[,1:563]

#Using a few more descriptive names (but names already too long, and descriptive enough)
#colnames(dataset) <- gsub("Gyro", "Gyroscope", names(dataset))
#colnames(dataset) <- gsub("Acc", "Accelerometer", names(dataset))
#colnames(dataset) <- gsub("Mag", "Magnitude", names(dataset))
#colnames(dataset) <- gsub("gravity", "Gravity", names(dataset))
#colnames(dataset) <- gsub("^f|Freq", "Frequency", names(dataset))
#colnames(dataset) <- gsub("^t", "Time", names(dataset))

#Extracting relevant variables
mean_and_std_indices <- grep("mean|std", names(dataset))
dataset <- dataset[,c(1,2,mean_and_std_indices)]

#Creating the "tidy" dataset and aggregating
tidy_data <- aggregate(. ~ Subject + Activity, data = dataset, mean)

#Exporting the tidy dataset
write.table(tidy_data, file="tidy_data.txt", sep = ",", row.name=FALSE)
