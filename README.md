Script to clean the data
========================================================

The script expects to find in the working directory the
following paths:

- test/X_test.txt
- train/X_train.txt
- features.txt
- test/y_test.txt
- train/y_train.txt
- activity_labels.txt
- test/subject_test.txt
- train/subject_train.txt

It loads test and train datasets ("X_test.txt", "X_train.txt" respectively) 
and decodes the variables according to features.txt.

The two datasets are merged, in order to obtain one single dataset.

Each row is enriched with the activity name and subject number.

A dataset is produced in output, and written in the current working directory as
"output_dataset.txt".