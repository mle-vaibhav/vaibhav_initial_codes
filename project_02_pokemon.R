Pokemon <- read.csv("D:/WORKINGDATA/Desktop/intellipaat_data_science/R_tutorial/intellipaat R lesson/intellipaat  case_study for practise/Pokemon.csv", stringsAsFactors = T)
#SELECTING POKEMON

a1 = Pokemon$Type.1=="Grass" & Pokemon$Type.2=="Poison"
pokemon_grass_poison = subset(Pokemon, a1==T)
pokemon_grass_poison
View(pokemon_grass_poison)
a2 = Pokemon$Type.1=="Water" & Pokemon$Type.2=="Flying"
pokemon_water_flying= subset(Pokemon,a2==T)
View(pokemon_water_flying)
a3 = Pokemon$Type.1=="Fire" & Pokemon$Type.2=="Psychic"
pokemon_fire_psychic = subset(Pokemon, a3==T)
View(pokemon_fire_psychic)

#ATTACK VS DEFENCE

library(caTools)
nrow(Pokemon)
poke_def_att_split = sample.split(Pokemon$Defense, SplitRatio = 0.60)
poke_def_att_train = subset(Pokemon, poke_def_att_split==T)
nrow(poke_def_att_train)
poke_def_att_test = subset(Pokemon,poke_def_att_split==F)
nrow(poke_def_att_test)

poke_def_att_lm = lm(Defense~Attack, data = poke_def_att_train)
summary(poke_def_att_lm)

poke_def_att_predict = predict(poke_def_att_lm, newdata = poke_def_att_test)
poke_def_att_predict

actual_predicted=cbind(actual_defense= poke_def_att_test$Defense, predicted_defense= poke_def_att_predict)
View(actual_predicted)

error= poke_def_att_test$Defense- poke_def_att_predict
actual_predicted_error = cbind(actual_defense= poke_def_att_test$Defense, predicted_defense= poke_def_att_predict, err = error)
View(actual_predicted_error)

Rmse_def_att = sqrt(mean((error)^2))
Rmse_def_att

#Legendary or not 

Pokemon$Legendary = as.factor(Pokemon$Legendary)
#splitting data into train and test

poke_split_lege = sample.split(Pokemon$Legendary, SplitRatio = 0.60)
poke_lege_train = subset(Pokemon, poke_split_lege==T)
nrow(poke_lege_train)
poke_lege_test = subset(Pokemon, poke_split_lege==F)
nrow(poke_lege_test)
#Model fitting

poke_lege_glm = glm(Legendary~Type.1+Type.2+
                      HP+Attack+Defense+Sp..Atk+Sp..Def+Speed
                    +Generation+Legendary, data = poke_lege_train, family = "binomial", maxit=100)

#predicting model using predict() 

poke_lege_predict = predict(poke_lege_glm, newdata = poke_lege_test)
range(poke_lege_predict)
#creating confusion matrix using table() fn

poke_conf_mat = table(poke_lege_test$Legendary,poke_lege_predict>1.5)
poke_conf_mat
#calculating accuracy

poke_lege_accuray = sum(diag(poke_conf_mat))/sum(poke_conf_mat)
poke_lege_accuray
