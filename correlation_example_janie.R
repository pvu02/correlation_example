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

# Understanding how  R returns information
my.cor.result <- cor.test(x=analytic.data$extrav,y=analytic.data$popular)
my.cor.result

#  See structure of resulting information
str(my.cor.result)

# Get correlation
my.cor.result$estimate

# Plot single correlation
my.scatter <- qplot(x=extrav,y=popular,data=analytic.data)
print(my.scatter)

# Adding regression line (with confidence intervals; se = FALSE means no confidence intervals)
my.scatter <- qplot(x=extrav,y=popular,data=analytic.data)
my.scatter <- my.scatter + geom_smooth(method = "lm", se = TRUE, color="black")
print(my.scatter)

# See all options from geom_smooth
?geom_smooth

# Calculating several correlations - converting data set to data frame
library(apaTables)
apa.cor.table(as.data.frame(analytic.data))

# Plots of several correlations (lm = TRUE means regression line added)
psych::pairs.panels(as.data.frame(analytic.data),lm=TRUE)

# Subgroup analyses - Calculating a correlation for a single subgroup
analytic.data.class.is.5 <- filter(analytic.data, class==5)
View(analytic.data.class.is.5)
cor.test(x=analytic.data.class.is.5$extrav,y=analytic.data.class.is.5$popular)

# Calculating correlations for several subgroups
analytic.data.grouped.by.class <- group_by(analytic.data, class)
cor.by.group <- summarise(analytic.data.grouped.by.class, cor.test(x=extrav,y=popular)$estimate)
print(cor.by.group)

# Print all rows
print(as.data.frame(cor.by.group))

# Plotting correlations for several groups
analytic.data.groups.15.to.30 <- filter(analytic.data.grouped.by.class, class>=15 & class<=30)
my.scatter <- qplot(x=extrav,y=popular,data=analytic.data.groups.15.to.30)
my.scatter <- my.scatter + facet_wrap(~class)
print(my.scatter)

# Add regression line to groups
my.scatter <- qplot(x=extrav,y=popular,data=analytic.data.groups.15.to.30)
my.scatter <- my.scatter + geom_smooth(method = "lm", se = TRUE, color="black")
my.scatter <- my.scatter + facet_wrap(~class)
print(my.scatter)
