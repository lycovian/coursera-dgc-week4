# Coursera: Getting and Cleaning Data Week 4 Code Book

SUMMARY:
Assigment ingests and transforms and summarizes the UCI HAR Dataset realted to realitme measurments of human activity using telemetry from subject worn smartphones.

More details: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Variables
   * Mainly data frames representing the underlying training and test data.

   
## Data
Data in zipfile format is downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  Zip file contains multiple subdirectories that in-turn contain the training and test data sets to be mereged and transformed.

All data can be found in the fixtures directory once the R code has been run.

## Transforms / Clean-up
   * Concatenate training and test datasets.
   * Append the subject id's to combined dataset (`subject_[test|train].txt`).
   * Append activity data to combined dataset.
   * Convert Activity ordinals into human-readible lables (`activity_labels.txt`)
   * Relabel all columns with the appropriate feature label (`features.txt`)
   * Summarized features (by mean) in "tidy" data (`grp`) dataframe is written out as CSV to script source directory as `result.csv`.


