# Activate  tidyverse
library(tidyverse)

# Load data from Internet
my.data <- read_csv("https://jeroenooms.github.io/multilevel/data/chapter2/popular2.csv")

# Save data for later use
write_csv(my.data,path="hox_data_chapter2.csv")

# Loading data for future
my.data <- read_csv("hox_data_chapter2.csv")

# Creating analytic data
analytic.data <- select(my.data, class, extrav, popular, texp)

# Overview of analytic data
analytic.data

# Don't make class into a factor because we lose the ability to use  operations like greater or less than

# All the data: Single correlation
analytic.data$extrav
analytic.data$popular
cor.test(x=analytic.data$extrav,y=analytic.data$popular)

# Report r=.32, 95% CI [.28, .35], p < .001

