# Code Book

This document described how the datasets
- `har.full`,
- `har.mean_and_std`, and
- `har.tidy`
are build up from the original UCI HAR dataset.

## Source Files

The original dataset contains the following files relevant for our analysis:
- `train/X_train.txt` and `test/X_test.txt`: 561-dimensional feature vectors
  describing the data collected through Smartwatches of subjects performing
  certain activities (walking, sitting, etc.).
- `train/y_train.txt` and `test/y_test.txt`: IDs of the performed activities.
  The activity *labels* are contained in `activity_labels.txt` and will be used
  by us to properly label a subject's activities.
- `train/subject_train.txt` and `test/subject_train.txt`: Number of the subject
  for which the respective data was collected.
- `features.txt`: Column names for the 561-dimensional measurements/feature vectors.

## How the Datasets are Build Up

The 561-dimensional feature vectors of the training and test data are merged in
the first step.
Thereafter, the lists of subjects and activities are prepended.
The activity labels as well as the column names are adjusted in the final step.

## Feature labels

The original feature labels (as in `features.txt`) are cleaned up by replacing
every sequence of characters `(`, `)`, `.`, `,`, and `-` by a single dash `-`.
Resulting dashes at the end of a feature label are removed.
Example:

- before tbe cleanup: `angle(tBodyGyroJerkMean,gravityMean)`
- after the cleanp: `angle-tBodyGyroJerkMean-gravityMean`

The feature labels of the tidy dataset, for instance, are like follows:

```
> names(har.tidy)[-c(1,2)]
 [1] "tBodyAcc-mean-X"           "tBodyAcc-mean-Y"           "tBodyAcc-mean-Z"          
 [4] "tBodyAcc-std-X"            "tBodyAcc-std-Y"            "tBodyAcc-std-Z"           
 [7] "tGravityAcc-mean-X"        "tGravityAcc-mean-Y"        "tGravityAcc-mean-Z"       
[10] "tGravityAcc-std-X"         "tGravityAcc-std-Y"         "tGravityAcc-std-Z"        
[13] "tBodyAccJerk-mean-X"       "tBodyAccJerk-mean-Y"       "tBodyAccJerk-mean-Z"      
[16] "tBodyAccJerk-std-X"        "tBodyAccJerk-std-Y"        "tBodyAccJerk-std-Z"       
[19] "tBodyGyro-mean-X"          "tBodyGyro-mean-Y"          "tBodyGyro-mean-Z"         
[22] "tBodyGyro-std-X"           "tBodyGyro-std-Y"           "tBodyGyro-std-Z"          
[25] "tBodyGyroJerk-mean-X"      "tBodyGyroJerk-mean-Y"      "tBodyGyroJerk-mean-Z"     
[28] "tBodyGyroJerk-std-X"       "tBodyGyroJerk-std-Y"       "tBodyGyroJerk-std-Z"      
[31] "tBodyAccMag-mean"          "tBodyAccMag-std"           "tGravityAccMag-mean"      
[34] "tGravityAccMag-std"        "tBodyAccJerkMag-mean"      "tBodyAccJerkMag-std"      
[37] "tBodyGyroMag-mean"         "tBodyGyroMag-std"          "tBodyGyroJerkMag-mean"    
[40] "tBodyGyroJerkMag-std"      "fBodyAcc-mean-X"           "fBodyAcc-mean-Y"          
[43] "fBodyAcc-mean-Z"           "fBodyAcc-std-X"            "fBodyAcc-std-Y"           
[46] "fBodyAcc-std-Z"            "fBodyAccJerk-mean-X"       "fBodyAccJerk-mean-Y"      
[49] "fBodyAccJerk-mean-Z"       "fBodyAccJerk-std-X"        "fBodyAccJerk-std-Y"       
[52] "fBodyAccJerk-std-Z"        "fBodyGyro-mean-X"          "fBodyGyro-mean-Y"         
[55] "fBodyGyro-mean-Z"          "fBodyGyro-std-X"           "fBodyGyro-std-Y"          
[58] "fBodyGyro-std-Z"           "fBodyAccMag-mean"          "fBodyAccMag-std"          
[61] "fBodyBodyAccJerkMag-mean"  "fBodyBodyAccJerkMag-std"   "fBodyBodyGyroMag-mean"    
[64] "fBodyBodyGyroMag-std"      "fBodyBodyGyroJerkMag-mean" "fBodyBodyGyroJerkMag-std"
[66] "fBodyBodyGyroJerkMag-std"
```

## Resulting Datasets

Running `run_analysis.R` exposes the following three datasets to your R session.

### `har.full`

The full dataset (10299 x 563), containing the data from all 30 volunteers
(the "subjects"), their activities, and the 561-dimensional feature vectors with
the measurements.

```
> har.full[1:5,1:6]
  subject activity tBodyAcc-mean-X tBodyAcc-mean-Y tBodyAcc-mean-Z tBodyAcc-std-X
1       1 STANDING       0.2885845     -0.02029417      -0.1329051     -0.9952786
2       1 STANDING       0.2784188     -0.01641057      -0.1235202     -0.9982453
3       1 STANDING       0.2796531     -0.01946716      -0.1134617     -0.9953796
4       1 STANDING       0.2791739     -0.02620065      -0.1232826     -0.9960915
5       1 STANDING       0.2766288     -0.01656965      -0.1153619     -0.9981386
```

### `har.mean_std`

Like `har.full`, but containing only columns with measurements on the mean and
standard deviation.

### `har.tidy`

Same features as in `har.mean_and_std`, but averaged per measurement within
each group of subject and activity.
It contains measurements from 30 volunteers with 6 activities each, resulting in
180 rows.

```
> har.tidy[1:5,1:6]
Source: local data frame [5 x 5]
Groups: subject [1]

  subject           activity `tBodyAcc-mean-X` `tBodyAcc-mean-Y` `tBodyAcc-mean-Z`
    <int>             <fctr>             <dbl>             <dbl>             <dbl>
1       1            WALKING         0.2773308      -0.017383819        -0.1111481
2       1   WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020
3       1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662
4       1            SITTING         0.2612376      -0.001308288        -0.1045442
5       1           STANDING         0.2789176      -0.016137590        -0.1106018
```
