# CleaningDataCourseProject

## description of run_analysis.R

First, this script reads all features and activity names for later use, as labels.

Then read data from each sub-directory, 'train' and 'test'. As both directory has same structure,
reading from that directory should be the same process. 'readData' function is the process.

Not all feature is necessary. This script subset the data using R 'grep' function, which subset feature list
only which has 'mean()' or 'std()' in it's name. 

Finary, calculate mean for each variable for each activity and each subject. R 'aggregate' function do that work.

## Code Book

* subject  : The number of each subject. Unit: none.
* activity : Performed activities. (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

Measurement is identical original feature. Quotes from feature_info.txt:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
> 
> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
> 
> tBodyAcc-XYZ
> tGravityAcc-XYZ
> tBodyAccJerk-XYZ
> tBodyGyro-XYZ
> tBodyGyroJerk-XYZ
> tBodyAccMag
> tGravityAccMag
> tBodyAccJerkMag
> tBodyGyroMag
> tBodyGyroJerkMag
> fBodyAcc-XYZ
> fBodyAccJerk-XYZ
> fBodyGyro-XYZ
> fBodyAccMag
> fBodyAccJerkMag
> fBodyGyroMag
> fBodyGyroJerkMag
> 
> The set of variables that were estimated from these signals are: 
> 
> mean(): Mean value
> std(): Standard deviation
> 

Each value is grouped and averaged for activity and subject. It's unit is gravity(g). 
