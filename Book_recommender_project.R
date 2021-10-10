#loading useful packages
#install.packages("recommenderlab")
library(recommenderlab)
library(data.table)
library(tidyr)
library(dplyr)
library(ggplot2)
library(stringr)
library(Matrix)
library(knitr)
library(methods)
#loading data set
book_tags <- read.csv("D:/WORKINGDATA/Desktop/intellipaat_data_science/R_tutorial/intellipaat R lesson/intellipaat  case_study for practise/Book_recommender_data/book_tags.csv")
books <- read.csv("D:/WORKINGDATA/Desktop/intellipaat_data_science/R_tutorial/intellipaat R lesson/intellipaat  case_study for practise/Book_recommender_data/books.csv")
ratings <- read.csv("D:/WORKINGDATA/Desktop/intellipaat_data_science/R_tutorial/intellipaat R lesson/intellipaat  case_study for practise/Book_recommender_data/ratings.csv")
tags <- read.csv("D:/WORKINGDATA/Desktop/intellipaat_data_science/R_tutorial/intellipaat R lesson/intellipaat  case_study for practise/Book_recommender_data/tags.csv")
#DATA CLEANING 
#Removing duplicates
   #1. getting count of users rated more than once 
ratings%>%group_by(book_id,user_id)%>%mutate(N=n())->ratings #here n() inside mutate will give count of user who rated particular book.
View(ratings)
table(ratings$N) # this will give instances of number of times which have been rated more than once
   #2 removing users who rated same book more than once using filter fn
ratings%>%filter(N==1)->ratings
table(ratings$N)

   #3 getting counts of How many users have rated how many book
ratings%>%group_by(user_id)%>%mutate(n_ratings_given=n())->ratings 
table(ratings$n_ratings_given)
   #4 filtering those users only who rated more than 2 books.
ratings%>%filter(n_ratings_given>2)->ratings
View(ratings)
#DATA EXPLORATION.

#1 extracting 2% data of cleaned  data.
set.seed(123)
user_fraction = 0.02
users = unique(ratings$user_id)
length(users)->total_user # to get the count of the unique users, out this many user we want 2%.
total_user
sample_users = sample(users,user_fraction*total_user) # synstax sample(data,no of sample wanted)
length(sample_users)

#2 now extracting those users from ratings which are present in sample user using filter fn.
ratings%>%filter(user_id %in% sample_users)->ratings
nrow(ratings)

#3 studying distribution of rating using bar plot.
ratings%>%ggplot(aes(rating, fill= rating))+
  geom_bar(color="skyblue")

 # studying number of times each book have been rated using bar plot.
ratings%>%group_by(book_id)%>%summarise(no_of_rating_per_book=n())%>%
   ggplot(aes(no_of_rating_per_book))+
   geom_bar(fill="orange",color="blue", width = 1)+
   coord_cartesian(c(0,20))
# findindg percentage distribution of genres
genres = str_to_lower(c("Art","Biography","Business","chick Lit","Children's",
                        "Christian","Classic","Comic","Cookbooks","Crime", "Fantasy",
                        "Gay and Lesbian","Graphic Novels","Historic Fiction","History",
                        "Horror","Humor and Comendy","Manga","Memomir","Music","Mystery",
                        "Paranormal","Philosophy","poetry","psychology","Religion","Romance",
                        "Science","Science Fiction","Self Help","Suspence","sprituality",
                        "Sports","Thriller","Travel","Young Adult"))
# we manually created list of famous book genres, so that we'll extract from tag_name
available_genres = genres[str_to_lower(genres)%in% tags$tag_name]
available_genres
available_tags = tags$tag_id[match(available_genres,tags$tag_name)] #here extracting those tag_ids which is name present in tag_name and available genres
available_tags

# plotting percentage of each genres
  #1. getting count of different genres or tag_id
book_tags%>%filter(tag_id%in%available_tags)%>%group_by(tag_id)%>%summarise(N=n())
  #2. getting percentage of each over the above code
book_tags%>%filter(tag_id%in%available_tags)%>%
   group_by(tag_id)%>%summarise(n=n())%>%
   ungroup()%>%mutate(sumN=sum(n), percentage = (n/sumN)*100)%>%
   arrange(-percentage)%>%left_join(tags, by = "tag_id")->book_info
View(book_info)   
#plotting the above data we got 
book_info%>%ggplot(aes(reorder(tag_name,percentage),percentage ,fill=percentage))+
   geom_bar(stat = "identity")+coord_flip()+scale_fill_distiller(palette = "ylorRd")+
   labs(x="Genre", y="percentage")
# reorder inside aes order graph in decending order, will reorder tagname according to percentage
table(ratings$book_id)

#finding top-10 books with highest rating

books%>%arrange(-average_rating)%>%
   top_n(10, wt= average_rating)%>%
   select(title,authors,average_rating)->top_10
View(top_10) # to shortlist top 10 books we arranged data according to their average rating and, and filtered out top10 books using top_n fn

#finding top most popular book
#popular books are those which has been rated by maximum number of people. Here we'll shortlist famous book as per ratings_count.

books%>%arrange(-ratings_count)%>%
   top_n(10,wt=ratings_count)%>%
   select(title,authors,average_rating,ratings_count)->popular_books
View(popular_books)


#RECOMMENDING BOOKS.

  #1. user based collaborative filtering.

   #A. re-structuring data for collaborative filtering.
         #(for that data should be in the form of matrix, where all the rows coresponds to the users and columns to books)

dimension_names = list(user_id= sort(unique(ratings$user_id)),book_id=sort(unique(ratings$book_id)))
dimension_names
#currently our data is in long format, we'll convert them to wide format. That means user_id & book_id will represent each each row and col resp.
ratingmat = spread(select(ratings,book_id,user_id,rating),book_id,rating)%>%
   select(-user_id)# in this code we selected book_id & rating to form matrix
#
#we can make user based collaborative filtering only on top of rating matrix only
class(ratingmat) #it is still in the form of data.frame so we'll convert them into matrix
ratingmat=as.matrix(ratingmat)
class(ratingmat)
ratingmat[1:5,1:5] #checking first 5 rows and column of ratingmat.
#since each row number represents user id we don't need separate userid col
ratingmat[,-1]->ratingmat
ratingmat[1:5,1:5]
View(ratingmat) #each row here representing each user_id and each column represents each book_id and each cell represents rating given by particular user to particular book.
dimnames(ratingmat)<-dimension_names
#here using dimnames fn we assigned names to the ratingmat which we extracted using list fn above.
dimnames(ratingmat)
dim(ratingmat)
#till we formed the rating matrix where each row represents user_id and each column represents book_id.


#Now we'll convert rating-matrix into real rating matirx.

ratingmat0= ratingmat  #so that we have both rating and real rating matrix distinctly.

dim(ratingmat0)
ratingmat0[is.na(ratingmat0)]<- 0 #replaing NA values with 0.
ratingmat0[1:5,1:5]

sparse_ratings = as(ratingmat0,"sparseMatrix")
sparse_ratings[1:5,1:5] # we save space using sparse matrix
real_ratings = new("realRatingMatrix", data=sparse_ratings)
real_ratings
#MODEL-BUILDING.
#splitting data into train and test., we cannot split usnig catools.
sample(x=c(T,F),size = nrow(real_ratings),replace = T,prob = c(0.9,0.2))->split #divided data into 90:20
recc_train = real_ratings[split,]
recc_test= real_ratings[!split,]
#building user based collaborative filtering model
Recommender(data = recc_train,method="IBCF")->recc_model_ibcf
n_recommended_books=6 #since we have to recommend 6 books thats why we are storing 6 in a variable, we can directly give its value while predicting

#Recommending books
predict(object = recc_model_ibcf,newdata=recc_test,n=n_recommended_books)->recc_predicted_ibcf
#recommending books for user no 1.
recc_predicted_ibcf@items[[1]]->user1_book_number #this will give us col number 
recc_predicted_ibcf@itemLabels[user1_book_number]

books%>%filter(id==680)%>%select(title,authors)
books%>%filter(id==797)%>%select(title,authors)
books%>%filter(id==932)%>%select(title,authors)
books%>%filter(id==1078)%>%select(title,authors)
books%>%filter(id==1188)%>%select(title,authors)
books%>%filter(id==1438)%>%select(title,authors)

#recommending books for user no 110
recc_predicted_ibcf@items[[110]]->user110_book_number
recc_predicted_ibcf@itemLabels[user110_book_number] #book-id

books%>%filter(id==4785 )%>%select(title,authors)
books%>%filter(id==6501 )%>%select(title,authors)
books%>%filter(id==6992)%>%select(title,authors)
books%>%filter(id==7297 )%>%select(title,authors)



