market_basket <- read.transactions("D:/WORKINGDATA/Desktop/intellipaat_data_science/R_tutorial/intellipaat R lesson/intellipaat  case_study for practise/market_basket.csv",
                                   sep = ",",quote = "",
                                   rm.duplicates = T,
                                   format = "basket",
                                   skip=1)
#format = "basket" will load each record in our data set as transactiom.
#rn.duplicates=T will remove all the duplicates 
library(arules)
library(arulesViz)
summary(market_basket)
# each row in  the transaction data-set represents each transactiom, hence total no of transac= total no of rows
#colums represents items 
#density represents no percentage of total cells occupied by an item
#total_item_purchased = rows*cols*density
total_transac =18440 #no of rows
total_item_inventory= 22346 #no of columns.
total_item_purchased = 18440*22346*0.0009915565
total_item_purchased
library(dplyr)
market_basket%>%head(n=5)%>%inspect()  #inspecting top5 transaction from market_basket dataset.
library(RColorBrewer) # to colour each bar of bar plot differently

itemFrequencyPlot(x=market_basket,topN=10,type="absolute",
                  horiz=T, col= brewer.pal(10,"Spectral")) #this graph gives 10 most frequently brought item from market_basket data-set
rule1 = apriori(market_basket, parameter = list(supp=0.005,conf=0.8))
sort(rule1,by="confidence")->rule1
summary(rule1)
inspect(head(rule1,n=5)) #inspecting top 5 rules.
inspect(tail(rule1,n=5)) #inspecting bottom 5 rules.

sort(rule1, by = "lift")->rule1 #sorting rules wrt lift
rule1%>%head(n=5)%>%inspect()
rule1%>%tail(n=5)%>%inspect()
#plot
plot(rule1,engine = "htmlwidget")#one way of plotting rule
plot(rule1,method = "two-key",engine = "htmlwidget")
plot(rule1,method = "graph", engine="htmlwidget")

#building 2nd apriori rules

rule2 = market_basket%>%apriori(parameter = list(supp=0.009,conf=0.3))%>%sort(by="confidence")
rule2%>%head(n=5)%>%inspect()
rule2%>%tail(n=5)%>%inspect()
#plot
plot(rule2,engine = "htmlwidget")
plot(rule2,method = "two-key",engine = "htmlwidget")
plot(rule2,method = "graph",engine = "htmlwidget")

#building 3rd A-rules using apriori algorithm

rule3 = apriori(market_basket, parameter = list(supp=0.02,conf=0.5))
sort(rule3, by='support')->rule3
rule3%>%head(n=5)%>%inspect()
inspect(tail(rule3,5))
#plot
plot(rule3,engine = "htmlwidget")
plot(rule3,method = "two-key", engine = "htmlwidget")
plot(rule3,method = "graph",engine = "htmlwidget")
