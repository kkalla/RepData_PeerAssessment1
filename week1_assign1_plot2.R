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
sub2 <- select(payments,Average.Covered.Charges,Average.Total.Payments,
               DRG.Definition,Provider.State)
drg <- levels(sub2$DRG.Definition)
levels(sub2$DRG.Definition) <-drg_code <- c("SIMPLE PNEUMONIA &\n PLEURISY W CC",
                                            "HEART FAILURE &\n SHOCK W CC",
                                            "ESOPHAGITIS,GASTROENT\n& MISC DIGEST DISORDERS\n W/O MCC",
                                            "MISC DISORDERS OF \nNUTRITION,METABOLISM,\n FLUIDS/ELECTROLYTES\n W/O MCC",
                                            "KIDNEY & URINARY \nTRACT INFECTIONS\n W/O MCC",
                                            "SEPTICEMIA \nOR SEVERE SEPSIS\n W/O MV 96+ HOURS\n W MCC")


##Make plot
library(ggplot2)
library(RColorBrewer)
pdf("assign1_plot2.pdf")

cols <- brewer.pal(n=6,"Dark2")
g <- ggplot(sub2,aes(log10(Average.Covered.Charges),
                     log10(Average.Total.Payments)))
g<-g + geom_point(alpha = 1/10) + geom_smooth(method = "lm",
                                              aes(color = Provider.State),se = FALSE,lwd = 1.5)
g<- g+ facet_wrap(~DRG.Definition,nrow = 2) + scale_color_manual(values = cols,
                                                         name = "The States",
                                                         breaks = c("CA","FL","IL","NY","PA","TX"),
                                                         labels = c("California","Florida",
                                                                    "Illinois", "New York",
                                                                    "Pennsylvania","Texas"))
g<-g + labs(title = "Mean covered charges and Mean total payments \nby Medical condition and the States",
         x = "Log10 (Mean coverd charges)", y = "Log10 (Mean total payments)")
g+theme(plot.title = element_text(size=20,face = "bold",vjust=2))
dev.off()
