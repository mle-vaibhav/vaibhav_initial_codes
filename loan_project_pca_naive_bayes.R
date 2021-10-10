loan <- read.csv("D:/WORKINGDATA/Desktop/intellipaat_data_science/R_tutorial/intellipaat R lesson/intellipaat  case_study for practise/Loan_approval_data/cutomer_loan.csv")
library(dplyr)
mutate(loan,dti=loan$debts/loan$income)->loan
mutate(loan,loan_decision_status= ifelse(loan$loan_decision_type=="Approved",1,0))->loan
View(loan)
loan$loan_decision_status= as.factor(loan$loan_decision_status)
cust_loan_redef = data.frame(loan[,c(3,4,6,7,8,11,13,14)])
cust_loan_redef$gender = as.factor(cust_loan_redef$gender)
cust_loan_redef$gender = as.numeric(cust_loan_redef$gender)
cust_loan_redef$marital_status = as.factor(cust_loan_redef$marital_status)
cust_loan_redef$marital_status = as.numeric(cust_loan_redef$marital_status)
cust_loan_redef$occupation = as.factor(cust_loan_redef$occupation)
cust_loan_redef$occupation = as.numeric(cust_loan_redef$occupation)
cust_loan_redef$loan_type = as.factor(cust_loan_redef$loan_type)
cust_loan_redef$loan_type = as.numeric(cust_loan_redef$loan_type)
View(cust_loan_redef)
#MODEL BUILDING
library(caTools)
set.seed(123)
split_t = sample.split(cust_loan_redef$loan_decision_status, SplitRatio = 0.70)
cust_loan_train = subset(cust_loan_redef,split_t==T)
nrow(cust_loan_train)
cust_loan_test=subset(cust_loan_redef,split_t==F)
nrow(cust_loan_test)
#PRINCIPAL COMPONENT ANALYSIS
combined_traintest= rbind(cust_loan_train,cust_loan_test)
pca = prcomp(combined_traintest[,-8],scale. = T)#prcomp is function to perfrom pca, attribute "scale." is used T to scale the given data
summary(pca)
plot(pca)
names(pca)
pca$center
View(pca$x)
pca$rotation
biplot(pca,scale = 0)
data.frame(loan_decision_status=combined_traintest$loan_decision_status,pca$x)->pc # here we just merged loan_decisio_type with all PC since loan_decision_type was not included in PCA
ggplot(pc,aes(x=PC1,y= loan_decision_status))+geom_point()
pc= pc[,1:3] #here we extracted loan_decision_type and pc1 and pc2
View(pc)
View(pca$x) #x is the value of all data in terms of PC
#Naive Bayes 
set.seed(111)
pc_split = sample.split(pc$loan_decision_status,SplitRatio = 0.70)
pc_train = subset(pc,pc_split==T)
nrow(pc_train)
pc_test=subset(pc,pc_split==F)
nrow(pc_test)
library(e1071) # for naive bayes
naive_model = naiveBayes(loan_decision_status~PC1,PC2,data = pc_train)
naive_predict = predict(naive_model,newdata = pc_test)
#install.packages("caret") #this pacakage is for confusion matrix
conf_mat= table(pc_test$loan_decision_status,naive_predict)
acc= sum(diag(conf_mat))/sum(conf_mat)
acc
