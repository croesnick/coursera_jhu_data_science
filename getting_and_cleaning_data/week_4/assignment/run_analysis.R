library(dplyr)

### Constants

har.const.remoteZipFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

### Helper functions

har.buildFileReader <- function(remoteZipFile) {
  localZipFile <- "uci_har_dataset.zip"
  
  downloadRawData <- function(url, target) {
    download.file(url, target, method = "curl")
  }
  
  if (!file.exists(localZipFile)) { downloadRawData(remoteZipFile, localZipFile) }
  
  function(...) {
    unz(localZipFile, file.path("UCI HAR Dataset", ...))
  }
}

har.loadData <- function(zipFile) {
  fileReader <- har.buildFileReader(zipFile)
  
  x_train <- read.table(fileReader("train", "X_train.txt"))
  y_train <- read.table(fileReader("train", "y_train.txt"))
  subj_train <- read.table(fileReader("train","subject_train.txt"))
  x_test <- read.table(fileReader("test", "X_test.txt"))
  y_test <- read.table(fileReader("test", "y_test.txt"))
  subj_test <- read.table(fileReader("test", "subject_test.txt"))
  activity_labels <- read.table(fileReader("activity_labels.txt"), stringsAsFactors = F)
  
  feature_labels.raw <- read.table("features.txt", stringsAsFactors = F)$V2
  feature_labels <- gsub("-$", "", gsub("[().,-]+", "-", feature_labels.raw))
  
  # Merge training and test data, interpret activities as factors
  
  data <- rbind(x_train, x_test)
  activities <- rbind(y_train, y_test)
  activities.f <- factor(activities$V1, labels = activity_labels$V2)
  subjects <- rbind(subj_train, subj_test)
  
  # Merge all the properly labeled data together
  
  full <- cbind(subjects, activities.f, data)
  colnames(full) <- c("subject", "activity", feature_labels)

  full
}

har.full <- har.loadData(har.const.remoteZipFile)

# Create a smaller dataset containing only columns containing measurements on the mean and std deviation

har.mean_std <- har.full[, c(1, 2, grep("-(mean|std)", names(har.full)))]

# Compute the average of each measurement on the mean and std deviation

har.tidy <- har.mean_std %>% group_by(subject, activity) %>% summarize_each(funs(mean))