# source("complete.R")
# complete("specdata", 1)
##   id nobs
## 1  1  117
# complete("specdata", c(2, 4, 8, 10, 12))
##   id nobs
## 1  2 1041
## 2  4  474
## 3  8  192
## 4 10  148
## 5 12   96
# complete("specdata", 30:25)
##   id nobs
## 1 30  932
## 2 29  711
## 3 28  475
## 4 27  338
## 5 26  586
## 6 25  463
# complete("specdata", 3)
##   id nobs
## 1  3  243
complete <- function(directory, id=1:332) {
     ## 'directory' is a character vector of length 1 indicating
     ## the location of csv files
     
     ## 'id' is an integer vector indicating the monitor id numbers 
     ## to be used
     
     ## return data frame of the form:
     ## id     nobs
     ## 1      117
     ## 2      1041
     ## ...
     ## where 'id' is the monitor id number and 'nobs' is the 
     ## number of complete cases
     ## 
     dataframe <- NULL
     for (i in id) {
          filename <- paste0('00', i, '.csv')
          filename <- paste0(directory, '/', substr(filename,nchar(filename)-6, nchar(filename)))
          # print(filename)
          d <- read.table(filename, sep = ',', quote = '"', na.strings = 'NA', header = TRUE)
          
          d_NA_excluded <- d[complete.cases(d),]
          dataframe <- rbind(dataframe, (data.frame(table(d_NA_excluded$ID))))
     }
     # rename data frame's columns' names
     colnames(dataframe) <- c('id', 'nobs')
     dataframe    
}