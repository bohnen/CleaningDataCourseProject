library(dplyr)

## constants
data_dir  <- "UCI HAR Dataset"

## if there isn't data file, download and unzip it.
if(!file.exists(data_dir)){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                "data.zip",
                method="curl")
  unzip("data.zip")
}

## read constants
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
  ## R's data name doesn't accept "-" and "()", so replace it.
  names(data)     <- gsub("\\(\\)","",gsub("-","_",features$V2))
  
  ## extracts only mean and standard deviation (2.)
  ## grep patterns are carefully choosed for excluding "*meanFreq"  
  data     <- data[,grep("_mean_|_std_|_mean$|_std$",names(data),value=TRUE)]
  
  data.frame(activity, subject, data)
}

## merge train and test data (1.)
all_data <- rbind(readData(data_dir,"train"),
                 readData(data_dir,"test"))

## creates tidy data set with the average of each variable
## for each activity and each subject
tidy_data <- tbl_df(all_data) %>%
  group_by(activity,subject) %>%
  summarise_each(funs(mean)) %>%
  arrange(activity,subject)

write.table(tidy_data,"tidy_data.txt",row.name = FALSE)