# CleaningDataCourseProject

## Description of the assignment

1. Submit a tidy data set as described below
2. Submit a link to a Github repository with your script for performing the analysis
3. The repository must have a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
4. You should also include a README.md in the repo with your scripts

### Tidy data set 

Download https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, then create script called run_analysis.R which create tidy data set as follows:

* TD-1: Merges the training and the test sets to create one data set.
* TD-2: Extracts only the measurements on the mean and standard deviation for each measurement. 
* TD-3: Uses descriptive activity names to name the activities in the data set
* TD-4: Appropriately labels the data set with descriptive variable names. 
* TD-5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## description of run_analysis.R

### Prerequisite

This script uses `dplyr` package, so you have to install the package before running it.

### Description of the logic

This script is composed of these parts:

* Download and unzip the data
* read activity labels and features
* read train/test data 
  ** using descriptive activity names (TD-3)
* merge train and test data (TD-1)
* Labels the data set (TD-4)
* Extracts mean and standard deviation for each measurement  (TD-2)
* Creates a tidy data set (TD-5)
* Write the tidy data set to "tidy_data.txt"

### Download and unzip the data 

If there is not exist *UCI HAR Dataset* directory, then download and unzip it.

### Read activity labels and features

From the top directory of UCI HAR Dataset, read features for column labels (TD-4), activity labels for activity names (TD-3).

### Read train/test data

There are 3 files in each directory:

* subject_[train|test].txt : subject on each observation
* data_[train|test].txt : data on each observation
* activity_[train|test].txt : activity code on each observation

Read each file then make data.frame using cbind. It also convert activity code to activity name merging with activity label, loaded at previous step.

### Label the data set

Label columns with feature label loaded at previous step.

R column name may not accept some characters, like *-* or *(* or *)* which feature label includes. 
To avoid errors, use `make.names` function. It substitute such character to "." , and also make them unique.

### Extract mean and standard deviation

Select columns based on it's name pattern. Description on the *features_info.txt*, each observation has `sum()` and `std()` respectively.
At original *features.txt*, they are follows these conventions: `-sum()-[XYZ]`, `-std()-[XYZ]`, `-sum()`, `-std()`. 
After `make.names` these conventions change to `.sum...[XYZ]`, `.std...[XYZ]`, `.sum..`, `.std..`. 

Extraction was done by `select` and it's sub routine `match` dplyr function. 
I choose "\\.sum\\.|\\.std\\." regex patterns for match parameter, which match the conventions noted above.

### Create a tidy data set

It's just map requirements to appropriate dplyr functions.

1. The data set is grouped by activity and subject, using `group_by` function.
2. Calculate average with `mean` function, repeating for each column with `summarise_each`  function.

### Write tidy data set to the file

Use `write.table` as noted on coursera page.

