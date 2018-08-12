# GCD_Course_Project

run_analysis.R performs the following:


1    : Loads the package necessary for certain functions.

3-10 : Downloads and unzips the dataset if it does not already exist in the working directory.

13-15: Loads the features and subsets the features required for the study (those representing a mean or standard deviation).

17-25: Loads the test and training datasets with only the required features.

27-29: Merges the test and training datasets and labels the columns accordingly.

31-34: Loads the activity labels and applies them to the activity column.

36-41: Makes the column names more understandable.

43-44: Creates a tidy data set with the average of each variable for each activity and each subject.

46   : Writes the tidy data set into a table and saves as a text file. 
