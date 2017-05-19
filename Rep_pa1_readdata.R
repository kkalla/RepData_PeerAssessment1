##download and reading file
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

