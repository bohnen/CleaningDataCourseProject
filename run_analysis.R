## read constants
data_dir  <- "UCI HAR Dataset"
features  <- read.table(sprintf("%s/features.txt",data_dir))
act_label <- read.table(sprintf("%s/activity_labels.txt",data_dir))

# read train/test data 
readData <- function(dir, spec="test"){
  subject  <- read.table(sprintf("%s/%s/subject_%s.txt",dir,spec,spec))
  data     <- read.table(sprintf("%s/%s/X_%s.txt",dir,spec,spec))
  activity <- read.table(sprintf("%s/%s/y_%s.txt",dir,spec,spec))

  ## add label
  ## uses descriptive activity names (3.)
  activity <- merge(activity, act_label,sort=FALSE)$V2
  names(subject)  <- "subject"
  names(activity) <- "activity"
  ## labels the data set with descriptive variable names (4.)
  names(data)     <- features$V2
  
  ## extracts only mean and standard deviation (2.)
  data     <- data[,grep("mean\\(\\)|std\\(\\)",features$V2,value=TRUE)]
  
  data.frame(activity, subject, data)
}

## merge train and test data (1.)
all_data = rbind(readData(data_dir,"train"),
                 readData(data_dir,"test"))

## creates tidy data set with the average of each variable
## for each activity and each subject
tidy_data = aggregate(. ~ activity + subject, all_data, mean)
write.table(tidy_data,"tidy_data.txt",row.name = FALSE)