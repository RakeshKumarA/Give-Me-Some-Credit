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
ggplot(credit.train,aes(SeriousDlqin2yrs)) + geom_histogram()
ggplot(credit.train,aes(RevolvingUtilizationOfUnsecuredLines)) + geom_histogram()
ggplot(credit.train,aes(credit.train$age)) + geom_histogram()
ggplot(credit.train,aes(credit.train$DebtRatio)) + geom_histogram()
ggplot(credit.train,aes(credit.train$NumberOfDependents)) + geom_histogram()
ggplot(credit.test,aes(credit.test$NumberOfDependents)) + geom_histogram()

dim(credit.train[credit.train$RevolvingUtilizationOfUnsecuredLines>10,])
tail(sort(credit.train$DebtRatio),100)

##DAta manipulation for train
credit.train[is.na(credit.train$MonthlyIncome),]$MonthlyIncome <- mean(credit.train$MonthlyIncome,na.rm = TRUE)
credit.train[is.na(credit.train$NumberOfDependents),]$NumberOfDependents <- 0
credit.test[is.na(credit.test$NumberOfDependents),]$NumberOfDependents <- 0

credit.test[is.na(credit.test$MonthlyIncome),]$MonthlyIncome <- mean(credit.test$MonthlyIncome,na.rm = TRUE)

##Logistic Regression Model
model <- glm(SeriousDlqin2yrs ~.,family=binomial(link='logit'),data=credit.train)

##Prediction
credit.test <- select(credit.test,-SeriousDlqin2yrs)
predict.credit <- predict(model,credit.test,type='response')
predict.credit
predict.credit <- ifelse(predict.credit > 0.5,1,0)
final.csv <- cbind(credit.test$X,predict.credit)
write.csv(final.csv,"submission_1.csv")


##Decision Tree model
require(rpart)
model.dT <- rpart(formula = SeriousDlqin2yrs ~.,data = credit.train,method = 'class')

##Prediction Tree model
predict.credit.dT <- predict(model,credit.test,type='response')
predict.credit.dT
write.csv(predict.credit.dT,"submission_2.csv")

##prediction Random forest
require(randomForest)
model.RF <- randomForest(formula = SeriousDlqin2yrs ~.,data = credit.train) 
