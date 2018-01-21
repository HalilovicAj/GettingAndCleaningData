---
title: "Getting and Cleaning Data"
output: html_document
---

<br />

####The script run_analysis.R performs the following transformations and calculations:####

<br />

1. It first reads the names of all measurements from a file called features

2. Reads 3 files regarding the test data:
  i. X_test which contains measurements (and names the variables using the file read in 1.)
  ii. y_test which contains an activity label for each test observation (and names it "Activity"), and 
  iii. subject_test which contains information on which person/subject was observed (and names it "Subject")
  
3. Reads 3 similar files for train data

4. Using cbind() forms test and train datasets: In the first column is the subject, followed by the activity type and all the measurement variables

5. Using rbind() merges test and train data into a single dataset

6. Reads activity names and adds them to the dataset using the function merge() 

7. Only optionally makes some of the column names more descriptive, because they are already too long

8. Extracts the relevant variables to form the desired tidy dataset and calcualtes the mean value for all mean and standard deviation measurements for each subject and each activity type.

9. Writes the final dataset to the working directory as a text file.