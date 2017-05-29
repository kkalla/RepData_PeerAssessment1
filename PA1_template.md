# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data
##Requirements
I use these packages. Install packages if you don't have these.

```r
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 3.3.3
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(ggplot2)
library(grid)
library(RColorBrewer)
```
###Donwloading and loading data
In this step, I download the data from [here]("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip") and store it in data directory under current working directory(Check your working directory before download). And unzip it and load to data frame named activity.

```r
if(!dir.exists("./data")){
    dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
if(!file.exists("./data/pa1zip.zip")){
    file.create("./data/pa1zip.zip")
}
download.file(fileUrl, "./data/pa1zip.zip")
unzip("./data/pa1zip.zip",exdir = "./data")
activity <- read.csv("./data/activity.csv")
```
The variables included in this dataset are:  
-**steps**: Number of steps taking in a 5-minute interval (missing values are coded as NA)  
-**date**: The date on which the measurement was taken in YYYY-MM-DD format  
-**interval**: Identifier for the 5-minute interval in which measurement was taken.
Let's see this dataset briefly(first 6 and last 6 rows).

```r
str(activity)
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ steps   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ date    : Factor w/ 61 levels "2012-10-01","2012-10-02",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```

```r
head(activity)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```

```r
tail(activity)
```

```
##       steps       date interval
## 17563    NA 2012-11-30     2330
## 17564    NA 2012-11-30     2335
## 17565    NA 2012-11-30     2340
## 17566    NA 2012-11-30     2345
## 17567    NA 2012-11-30     2350
## 17568    NA 2012-11-30     2355
```
As you can see, there are NAs in variable *steps*. And variable *date* is loaded as factor not date. Now let's check how many NAs there are in *steps*.


```r
sum<-sum(is.na(activity$steps))
sum
```

```
## [1] 2304
```

```r
sum/length(activity$steps)
```

```
## [1] 0.1311475
```
There are 2304 NAs in the *steps* and it is about 13% of rows. For further analysis I make data.frame **complete_activity** by removing NAs of *steps*.

```r
complete_activity <- activity[complete.cases(activity$steps),]
```

## What is mean total number of steps taken per day?
I make histogram of the total number of steps taken each day.  

```r
total_steps <- select(activity,steps,date) %>% group_by(date)%>% summarise(steps = sum(steps,na.rm = TRUE))
mean_steps <- mean(total_steps$steps)
median_steps <- median(total_steps$steps)
cols <- brewer.pal(3,'Dark2')
mean_string<-paste("mean =",round(mean_steps,2))
median_string<-paste("median =",round(median_steps,2))

g <- ggplot(total_steps,aes(steps))
g + geom_histogram(binwidth = 800) + 
    labs(title = 'The Total Number of Steps\nTaken Each Day', 
         x = 'The total number of steps') + 
    geom_vline(xintercept = mean_steps,lwd = 2,col = cols[1]) +
    geom_vline(xintercept = median_steps,lwd = 2,col = cols[2]) +
    annotate("text",x=5000,y=9.0,label = mean_string,col = cols[1],size = 4) +
    annotate("text",x=5000,y=7.5,label = median_string,col = cols[2],size = 4)+
    theme(plot.title = element_text(size = 28,lineheight=.8,vjust=3))
```

![](PA1_template_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

In this histogram, the mean total number of steps taken per day is 9354.2295082.



## What is the average daily activity pattern?



## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?
