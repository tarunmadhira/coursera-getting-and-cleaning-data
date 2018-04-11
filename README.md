# Getting and Cleaning Data - Course Project

This is the course project for course 3 week 4.
The R script, `run_analysis.R`, does the following:

1. Download the dataset (if it does not already exist)
2. Load activity and feature info and both the training and test datasets, and keeps only those columns which
   reflect a mean or standard deviation.
3. Loads the activity and subject data for each dataset and merges those
   columns with the dataset.
4. Merges the two datasets.
5. Converts the `activity` and `subject` columns into factors.
6. Creates a tidy dataset consisiting of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file `tidy.txt`.
