##### This script starts with the assumption that the Samsung data is available in the working directory in an unzipped UCI HAR Dataset folder.

Use this lines of code to read the data from the text file  
> data <- read.table(file_path, header = TRUE)  
> View(data)

The data contains activity tracking measurements of 30 subjects which is numbered 1 -> 30.  
For each subject there are 6 different rows stand for 6 activities observed.  
Each column represents the value of one measurement by mean or standard deviation.  
