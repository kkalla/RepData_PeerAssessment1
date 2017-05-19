##Download and read data
if(!dir.exists("./data")){
    dir.create("./data")
}
if(!file.exists("./data/assign1data.csv")){
    file.create("./data/assign1data.csv")
}
fileUrl <- "https://d3c33hcgiwev3.cloudfront.net/
_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?
Expires=1490832000&Signature=Wy3bez8Yb4oMevAV-AZpje3hW
vPUTxrNsnD6K4QzD8spydVMnNA~vVXEom-cfNi7nHaJvY6VIF50nXjdy
UShs5AB-IcNhEnpJJd~7oBvPA~Umjvk0OI3daj7QzUgs9p0mldLvsC9FCh
SDiHhDHh5tJ8zG8vbdAavK8OqT9qGITo_&
Key-Pair-Id=APKAJLTNE6QMUY6HBC5A"
download.file(fileUrl,"./data/assign1data.csv")

payments <- read.csv("./data/assign1data.csv")

##Processing data to make plot
library(dplyr)
sub1 <- select(payments,Provider.State,
               Average.Covered.Charges,
               Average.Total.Payments) %>%
    filter(Provider.State=="NY")

##Make plot
library(ggplot2)
pdf("assign1_plot1.pdf")
plot1 <- ggplot(payments,aes(log10(Average.Covered.Charges),
                             log10(Average.Total.Payments)))
plot1 <- plot1 + geom_point(alpha = 1/5) + geom_smooth(method = "lm",lwd = 2,alpha = 1/2)
plot1 + labs(title = "Relationship between \nMean coverd charges and mean total paymens \nin New York")+
    labs(x = "Mean covered charges(log10)",
         y = "Mean total payments(log10)")
dev.off()
