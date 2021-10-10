data("iris") #this is inbuilt data set of r-studio
View(iris)
str(iris) #we have 5 varibales total 4 numeric and one factor 
summary(iris) #from here we find that each variable are differently scaled that 

#means range of each data highly varies with other data
# when we have variables with different scale, we need to normalize them
#because data with higher scale may over shadow other variable and our prediction 
#may get influenced by a data which has 
#high range

#splitting data
set.seed(111)
split_tag = sample(2,nrow(iris),replace=T, prob=c(0.8,0.2))
training = iris[split_tag==1,]
test = iris[split_tag==2,]
#install.packages("psych")
library(psych) # this helps us visually check the co-relation among the variables
pairs.panels(training[,-5], gap=0, bg= c("red","yellow","blue")[training$Species])
 # here we excluded species col since it is a factor type
# attribute bg assigns color, here we choose to assign colors acc to species in traing data set

#co-relation  varies between -1 to 1, from the plot we find that the cor is highest between 
#petal length and petal-width, we can find respective corr and plot at the intersection point


# The corelation between independet variables should be less, 
#high corr relation between independent variables give rise to multi-colinearity
# which affect our predictive model

#To handle the problem of multi-colinearity we can use PCA.

#**************principal component analysis********************

pc=prcomp(training[,-5],
             center = T,
             scale. = T) # for pca we used fn "prcomp", center=T will ensure that 
                         # prcomp will calculate mean of each variabl scale.=T will normalize or scale data,
                         #it is other way of telling prcomp to calculate SD of each varialbe..
attributes(pc)
pc$center # this will give the average of each variable passed.
mean(training$Sepal.Length) # used training data to that because we used training 
mean(training$Sepal.Width)  # data inside prcomp
pc$scale # this gives the sd of data passed.
sd(training$Sepal.Length)

print(pc) # here we see that we got 4PCs since we passed 4 variables,
#PC are nothing but normalised linear combination of  variables passed 
# values of each PC varies from -1 to +1, 

summary(pc) # here we can see that pc1 accouts for 73% of data and pc2 for 22% of data

# now again checking the corr amongst the pc which is nothing but, transformed variables

pairs.panels(pc$x,
             gap = 0,
             bg= c("red","yellow","blue")[training$Species])
 #we find that the corr between each PC is zero, is it because they are orthogonal to each other
#hence we gpt rid of multi-colinearity
library(ggplot2)
#install.packages("devtools") this installed to install package outside of R-documents
library(devtools)
#install_github('vqv/ggbiplot') #here installed ggbiplot using devtools package
1
writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")
Sys.which("make")
library(jsonlite)

library(ggbiplot)
g<-ggbiplot(pc, obs.scale = 1,var.scale = 1, groups = training$Species,
            ellipse = T,
            circle = T,
            ellipse.prob = 0.90)
g<-g+ scale_color_discrete(name= '')+theme(legend.direction = "horizontal",
                                           legend.position = "top")

g #biplot hepls us to check the corr relation between variables and PC, 
#lines of variables which are closer to each other denotes have higher corr

biplot(pc, scale = 0,var.axes=T, col=c("red","yellow","blue")[training$Species])
#biplot fn is default fn of R-studio
#prediction  with Principal component
trn<- predict(pc,training) # here we predicted pc using training data
# the objetive behind above code is to convert all data in the from of PC
trn<- data.frame(trn,training[5]) #converted our PC data into data frame and also added col species which we have removed
tst<- predict(pc,test)
tst<- data.frame(tst, test[5])
#Now we have our data ready in the from of PC and we are to build model.

#Applying logistic regression
my_model<- glm(Species~PC1+PC2,data = trn) #we used pc1 and pc2 because, they contribute for 95% of variance in data

#we are getting this error beacue our dependent variable has 3 levels, so we need to apply 
#Multinomial Logistic regression

library(nnet)
trn$Species<-relevel(trn$Species, ref = "setosa") # here out of 3 species we are telling that by species we refer to setosa
my_model<- multinom(Species~PC1+PC2, data = trn)
p<- predict(my_model, newdata = tst)
conf_mat <- table(p, tst$Species)
conf_mat
acc= sum(diag(conf_mat))/sum(conf_mat)
acc

#**************using Naive bayes for prediction*****************

library(e1071)

model_2 = naiveBayes(Species~PC1+PC2, data = trn)
predict_2 = predict(model_2, newdata = tst)
conf_mat2 = table(predict_2, tst$Species)
conf_mat2
acc2= sum(diag(conf_mat2))/sum(conf_mat2)
acc2
