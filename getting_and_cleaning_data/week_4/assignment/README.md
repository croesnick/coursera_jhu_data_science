# Coursera JHU Data Science Track: Getting and Cleaning Data Course Project

This repository contains the code for the week 4 peer-graded assignment of the
"Getting and Cleaning Data" course which is part of the
[John Hopkins Data Science Track on Coursera][jhu-ds-coursera].
The provided `run_analysis.R` downloads, aggregates, and tidies up data from the
[UCI HAR ("Human Activity Recognition Using Smartphones")][uci-har-website]
[dataset][uci-har-dataset].

## About `run_analysis.R`

This script exposes a couple of variables (constants, helper functions, and
datasets) when run:

- Constants and functions
  * `har.const.remoteZipFile`: URL of the raw data (the [UCI HAR dataset][uci-har-dataset])
  * `har.buildFileReader`: Downloads the dataaet if not already present in the
    local directory.
    Returns a function, a _file reader_, which takes the path for a file in the
    zip file and returns its contents.
  * `har.loadData`: Loads the data from the zip file and builds a properly
    labeled data frame.
    For detailed information about the labels and the units of the data, see the
    provided [CookBook.md][./CookBook.md].
- Exposed datasets
  * `har.full`: The full dataset (10299 x 563), containing the data from all
    30 volunteers (the "subjects"), their activities, and the 561-dimensional
    feature vectors with the measurements.
  * `har.mean_and_std`: Like `har.full`, but containing only columns with
    measurements on the mean and standard deviation.
  * `har.tidy`: Same features as in `har.mean_and_std`, but averaged per
    measurement within each group of subject and activity.

[jhu-ds-coursera]: https://www.coursera.org/specializations/jhu-data-science
[uci-har-website]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
[uci-har-dataset]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
