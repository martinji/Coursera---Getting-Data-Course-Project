# Coursera---Getting-Data-Course-Project

The code in run_analysis.R is commented to explain how the analysis works.  A codebook is included separately as Codebook.md.
Here is an overview of the stages involved.

- firstly, downloaded, extracted and moved all of the necessary data files and descriptive files (Activity and feature names) into the working directory.  This was done offline and the R code expects the files to be found in the working directory.
- then, read in all of the data into separate tables
- next, join together the test & training data so that I have one larger set with all data, for each of subject, activity and data recorded
- whilst doing this, replaced the activity code numbers with their equivalent activity, I did this using SQLDF to merge the activity name on (I checked this retained the row ordering intact)
- and label the column names of the data recordings with using the feature names table.  I considered these to be meaningful enough without further renaming.
- then, only keep the data recording columns we need - which I interpreted to be the ones with mean() and std() in their name.  

So, at this point I now have three key data frames, one which is a list of subject IDs, one which is a list of activity names, and one which is all of the data recordings.  These all have the same number of rows and the rows are in matching order, as they have been all along, so now I can create my overall data table by cbinding these together.

One last amend to this data table, renaming the first & second columns to be meaningful.

And now I can create the tidy data set required by the exercise, using the aggregate function to create a table of means.
Final step is to use write.table to output this, which is the table uploaded as the solution.
