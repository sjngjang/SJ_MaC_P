kimchi<-read.csv("Practice/kimchi.csv", header=T)
head(kimchi)

sale<-kimchi$marketP
plot(sale, type="l", xlab="week", ylab="sale price")


#----
install.packages("zoo")
library(zoo)
dates<-as.Date(as.character(kimchi$weekLast), format="%Y%m%d")
BIG_sales<-kimchi$marketP
DEPT_sales<-kimchi$depC
SUPER_sales<-kimchi$superC
all_sales<-as.data.frame(cbind(BIG_sales, DEPT_sales, SUPER_sales))

yang_sales<-zoo(all_sales, dates)

plot(yang_sales, screens=1, xlab="date", ylab="sales amount", col=c('red','green','blue'))

#cut and  merging
b_sales<-zoo(BIG_sales, dates)
kimchi2<-read.csv("kimchi2.csv", header=T)
