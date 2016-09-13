##Read Training and Test data
credit.train <- read.csv("cs-training.csv")
credit.test <- read.csv("cs-test.csv")
require(dplyr)


##Checking dimension of training and test data
dim(credit.train)
dim(credit.test)

##Checking Structure of train and test data
str(credit.train)
summary(credit.train)
str(credit.test)
summary(credit.test)


##Visualizing Train data
require(ggplot2)
