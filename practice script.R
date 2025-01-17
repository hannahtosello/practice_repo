
# Library -----------------------------------------------------------------

library(tidyverse)
library(vegan)
library(patchwork)
#### Data ####
invert_data <- read.csv("data/invert_data.csv")
str(invert_data)
colnames(invert_data)

#### Make into univariate data ####
invert_data <- invert_data %>% 
  separate(site, c('site', 'sample'))
invert <- invert_data %>% select(Nemata:Unionidae)
env <- invert_data %>%  select(site:sample)  

#Vegan functions
richness <- specnumber(invert)
abundance <- rowSums(invert)

?diversity
# shannon
H <- diversity(invert, index = "shannon")

# Simpsons
D <- diversity (invert, index = "simpson")

#Pielous' evenness
J <- H/log(richness)

univariate <- env
univariate$richness <- richness
univariate$abundance <- abundance
univariate$shannon <- H
univariate$simpson <- D
univariate$evenness <- J

univariate

write.csv(univariate, "data/univariate_data.csv", row.names = FALSE)
