getwd()
prob<- read.csv("Practice/problem.csv", header=T, stringsAsFactors = F)
head(prob)


#---------- 1ver to normalize
for (i in 1:30) {
  #change variables to 0 to 1
  prob[i]<-prob[i]*(1/5)
}
head(prob)

#------ 2ver to normalize
#normalization function
normalize<-function(x){
  return ((x-min(x))/diff(range(x)))
}

#change the variables 'general, suicide, violence' --> 'yes, no'
prob$accident2<-with(prob, ifelse(accident=="suicide" | accident=="violence", 1,0))
head(prob)
#test  the model with 'nnet'

install.packages("nnet")
library(nnet)
prob<-prob[-31]
m1 <-nnet(accident2 ~ ., data=prob, size=10)

r1<-predict(m1, prob)
head(r1)


cbind(prob$accident2, r1>0.5)

sum(as.numeric(r1>0.5) != prob$accident2)

#diff Pack
install.packages("neuralnet")
library(neuralnet)

xnam<-paste0("ans", 1:30)
fmla<-as.formula(paste("accident2~ ", paste(xnam, collapse="+")))
m2<-neuralnet(fmla, data=prob, hidden=10)
plot(m2)
