creditcard <- read.csv("D:/WORKINGDATA/Desktop/intellipaat_data_science/R_tutorial/intellipaat R lesson/intellipaat  case_study for practise/creditcard.csv")

#Data-preprocessing.
str(creditcard)
#converting class variable into factor.
creditcard$Class<-as.factor(creditcard$Class) #here 0 means legit and 1 means fraud.
#checking for missing 
sum(is.na(creditcard))
#distribution of legit and fraud case.
table(creditcard$Class)
#our data is highly unbalanced since we have only 64 instance of fraud out of 20,000 records.
#here we'll use the synthetic minority over sampling technique(SMOTE), in this we create fraud case using the features of existing fraud cases with help of clustetering technique
prop.table(table(creditcard$Class)) # this gives us the percentage distribution of each factor.

#making pie chart for the display of unbalanced data

labels= c("legit","fraud")
labels= paste(labels,round(100*prop.table(table(creditcard$Class)),2)) 
labels =paste0(labels,"%")
labels
pie(table(creditcard$Class),labels,col = c("sky blue","red"),
    main = "creditcard legit_fraud transaction distribution")
#No model prediction
#here we are trying to predict without making any machine learning model, assuming all the data we have is of legit trasansactiom
predictions = rep.int(0,nrow(creditcard))
predictions= factor(predictions,levels=c(0,1)) #we can also use as.fator
table(predictions)
#creating confusion matrix
table(creditcard$Class,predictions)->conf_mat
conf_mat
acc1 = sum(diag(conf_mat))/sum(conf_mat)
acc1
library(ggplot2)
library(dplyr)
ggplot(data = creditcard,aes(x=V1,y=V2,col=Class))+
  geom_point()+
  theme_bw()+
  scale_color_manual(values = c("dodgerblue2","red"))#col=class means colours will be filled according to the class we have 2 class legit and fraud
#from the above plot it is clear that our data is highly unbalanced between  legit and fraud.


#we need to balance our data, and balacing will be performed only on train-set.


library(caTools)
set.seed(123)
split = sample.split(creditcard,SplitRatio = 0.80)
train_data = subset(creditcard,split==T)
test_data = subset(creditcard,split==F)
nrow(train_data)
nrow(test_data)
#Method 1 Random over sampling(ROS), in this method we simply copy paste the existing lesser data, to balance it with out numbered data.
#Note we usually use (SMOTE) it has various advantage over sample over sampling and under sampling

table(creditcard$Class)
#since we have 19936 legit data, we want similar number of fraud data to balance it out,
#hence our total number of rows will increase to 19936 x 2
n_legit_row= 19936
n_fraction_legit =0.5
new_n_total = 19936/0.5 #39872 we could have also simply did  19936 x 2 and assigned random variable name
new_n_total
#install.packages("ROSE") #for random over sampling
library(ROSE)
over_sample = ovun.sample(Class~.,data = train_data,method = "over",N=new_n_total,seed = 12)
over_sample_credit = over_sample$data
table(over_sample_credit$Class)

#again plotting scatter plot to see distribution of class

ggplot(over_sample_credit,aes(x=V1,y=V2,col=Class))+
  geom_point(position = position_jitter(width = 0.2))+
  theme_classic()+
  scale_color_manual(values = c("blue","red"))
#the problem using over sample is that we don't variance due to copying of same data.
#even after balancing our data we have feable number of fraud data, it is beacause most data are over lapped due to repeatition
#that's why we used jitter to see overlapped data

#RANDOM UNDER SAMPLING. Here we consider fraud data instead of legit one
table(train_data$Class)
#here we have 42 fraud cases we'll bring down data based on fraud data.
n_fraud_row=42
n_fraud_fraction=0.5
under_n_total = n_fraud_row/n_fraud_fraction
under_n_total

under_sample= ovun.sample(Class~.,train_data,method = "under",N=under_n_total,
                          seed = 13)
under_sample$data->under_sample
table(under_sample$Class)
ggplot(under_sample,aes(x=V1,y=V2,col=Class))+
  geom_point()+
  theme_dark()+
  scale_color_manual(values = c("blue","red"))
#the issue with under random sampling is we eliminate huge number of data, which result in loss of valuable information and results may be misleading

#performing both random under and random over

n_new= nrow(train_data) #15484
fraction_fraud_new = 0.50
n_both = n_new/fraction_fraud_new
under_over_sample = ovun.sample(Class~.,data = train_data,N=n_both,
                                method = "both",seed = 14)
under_over_sample$data->under_over_data
table(under_over_data$Class)
prop.table(table(under_over_data$Class))

under_over_data%>%ggplot(aes(x=V1,y=V2,col=Class))+
  geom_point(position = position_jitter(width = 0.2))+
  theme_classic()+
  scale_color_manual(values = c("blue","red"))
#APPLTYING SMOTE(SYNTHETIC MINORITY OVERSAMPLING TECHNIQUE)

#install.packages("smotefamily")
library(smotefamily)

table(train_data$Class)
 n0=15442 #total number of legit transac in train data.
 n1=42    # total number of fraud data in our train data.
 r0=0.6   # total percentage of legit case we want after smot.
 
#cauculating the value of dupe_size parameter of smote, dupe_size means number of times our smot will repeat to get the data
n_times = ((1-r0)/r0)*(n0/n1)-1
n_times  #our smote will this many times 

smote_model = SMOTE(train_data[,-c(1,31)],target = train_data$Class,K=5,dup_size = n_times)
smote_model$data->smote_data # here k is the number of neighbour smote will look
prop.table(table(smote_data$class))
colnames(smote_data)[30]<-"Class"

#plotting distribution of class on original data-set i.e train_data
train_data%>%ggplot(aes(x=V1,y=V2,col=Class))+
  geom_point()+
  theme_dark()+
  scale_color_manual(values = c("blue","red"))
#plotting distribution of class on data-set created using smote ie smote_data
smote_data%>%ggplot(aes(x=V1,y=V2,col=Class))+
  geom_point()+
  theme_dark()+
  scale_color_manual(values = c("blue","red"))
#we can clearly spot the difference between fraud data in original data was very feable
#in comparison to the fraud data after SMOTE,we need to perform this operation
#because we have very less data of fraud, without enhancing the number of fraud data,our prediction would be difficult

#Now performing prediction 

#01. making model and performing prediction on original data set
  #************************LOGISTIC REGRESSION*****************

logistic_model = glm(Class~.,data = train_data,family = "binomial")
logistic_prediction= predict(logistic_model,newdata = test_data,type = "response")
actual_predict_value= cbind(test_data$Class,logistic_prediction)
View(actual_predict_value)
error = sqrt(mean((train_data$Class- logistic_prediction)^2))
actual_predict_error = cbind(actual_predict_value,error)
#checking accuracy
conf_mat_logis = table(test_data$Class,logistic_prediction)
conf_mat_logis
acc_logis= sum(diag(conf_mat_logis))/sum(conf_mat_logis)
acc_logis  #getting very less accuracy on original data nearly 0.02%
prediction(logistic_prediction,test_data$Class)->confmat_logis2
performance(confmat_logis2,"acc")->acc_cutoff_logis
plot(acc_cutoff_logis)
performance(confmat_logis2,"tpr","fpr")->logistic_rocr
plot(logistic_rocr)
performance(confmat_logis2,"auc")->auc_logis
auc_logis@y.values

#Now building the sane model perfrom prediction on data generated  by smot
str(smote_data)
smote_data$Class= as.factor(smote_data$Class)

smot_split = sample.split(smote_data$Class,SplitRatio = 0.80)
smot_train= subset(smote_data,smot_split==T)
smot_test = subset(smote_data,smot_split==F)

smot_glm = glm(Class~.,data = smot_train,family = "binomial")
smot_predict = predict(smot_glm,newdata = smot_test,type = "response")
smot_actual_predict_val = cbind(smot_test$Class,smot_predict)
smot_error = sqrt(mean((smot_test - smot_predict)^2))
actual_predict_error_val = cbind(smot_actual_predict_val,smot_error)
#checking accurary
range(smot_predict)
conf_mat_smot= table(smot_test$Class,smot_predict>9)
conf_mat_smot
acc_smot = sum(diag(conf_mat_smot))/sum(conf_mat_smot)
acc_smot
#plotting rocr curve
library(ROCR)
prediction(smot_predict,smot_test$Class)->conf_mat_rocr
performance(conf_mat_rocr,"acc")->acc_rocr
plot(acc_rocr) #this is accuracy v/s cutoff graph
table(smot_test$Class,smot_predict>0.55)->confmat_smot2
confmat_smot2
acc2= sum(diag(confmat_smot2))/sum(confmat_smot2)
acc2 #when we manually set cutoff accracy was 60%
#plotting rocr curve
performance(conf_mat_rocr,"tpr","fpr")->rocr_curve
plot(rocr_curve)
performance(conf_mat_rocr,"auc")->area_under_curve
area_under_curve@y.values #auc is noting but accuracy 

#checking same values using decision tree.
 library(rpart)
library(rpart.plot)

tree_model_actual = rpart(Class~.,data = smote_data)
summary(tree_model_actual)
rpart.plot(tree_model_actual,extra = 0,tweak = 1.2,type = 3)
#attribute extra will give extra info on plot,type decides shape of plot,tweak increase or decrease font 
tree_predict = predict(tree_model_actual,newdata = test_data,type = "class")
conf_mat_tree= table(test_data$Class,tree_predict)
conf_mat_tree
acc_tree= sum(diag(conf_mat_tree))/sum(conf_mat_tree)
acc_tree
tree_predict1 = predict(tree_model_actual,newdata = creditcard,type = "class")
conf_mat_actual = table(creditcard$Class,tree_predict1)#whole has been used to predict values based on data built on SMORT
conf_mat_actual
accuracy_on_actual = sum(diag(conf_mat_actual))/sum(conf_mat_actual)
accuracy_on_actual

#Note:- In fraud detection case we have very less fraud data that's why we
#synthetically create fraud data using techniques suchas random under/over sampling SMORT
#we use synthetic data to just train our model and we should predict our model only on 
#actual data which we have in hand.

