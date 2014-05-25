GettingCleaningData_CourseProject1
==================================

The repository for courese project of Getting and Cleaning Data from Coursera 

## 1. Merge the training and the test sets to create one data set
      xTrain.txt, yTrain.txt and subTrain are combined to form the training set by cbind.
      xTest.txt, yTest.txt and subTrain are combined to form the test set by cbind.
      features are read into the R environment and "subject" (numbering of each pariticipated subject) and             "activity" (code of each type of activity) are appended into features as complete labels of training set          and test set.
      Training set and test set are combined by rbind and named by features.  


## 2. Subset complete dataset to get columns with mean or std
      All columns with mean and standard deviation of measurements are selected and isolated to form a subset.

## 3. Convert numbering of activities into descriptive terms 
      For the subset from 2, convert the coding of activities by numbers into descriptive terms, like walking,       standing, etc.

## 4. Re-label the dataset with descriptive activity names  
      Clean the labels of each variable by: 
      (1) Expand each abbreviation into full terms.
      (2) Remove labels like underscores.
      (3) Remove ambiguious or repeated terms like "fBody".
      (4) Remove number at the beginning of each variable name. 
      Output the cleaned file into a text file named "SamsungActivity.txt".

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each ##    subject
      Reshape the data from 4 by using "subject" and "acitivity" as id variable and the rest as values.
      Recast the reshaped data by calculating the mean of each variable except "subject" and "activity". 
      Output the cleaned file into a text file named "SamsungActivityMean.txt".

        