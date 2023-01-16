# Exploratory Data Analysis (EDA) of financial data

## Load packages

library(doParallel)
library(dplyr)
library(ggplot2)

## Load Paralellization

cl <- makePSOCKcluster(8)
registerDoParallel(cl)

## Load data

nflx_data <- read.csv("financial_data_eda/data/NFLX.csv", stringsAsFactor = FALSE)

## Prepare data

nflx_data$Date <- as.Date(nflx_data$Date)
nflx_data <- arrange(nflx_data, Date)

## Data summary

print(summary(nflx_data))


## Display the data in a basic plot

p <- ggplot(data = nflx_data, aes(x = Date, y = Adj.Close)) +
    geom_line(color = "#e35454") +
    theme(axis.title = element_text(face = "bold"))

p

ggsave("financial_data_eda/data_plot.svg")

##  Histogram with density plot

h <- ggplot(data = nflx_data, aes(x = Adj.Close)) +
    geom_histogram(aes(y = after_stat(density)),
        fill = "#9c64bf",
        binwidth = 30
    ) +
    geom_density(
        alpha = .2,
        fill = "#eb8f20",
        linetype = "dashed"
    ) +
    theme(axis.title = element_text(face = "bold")) +
    labs(
        x = "Adj.Close",
        y = "Density"
    )

h

ggsave("financial_data_eda/histogram.svg")


## Stop Paralellization

stopCluster(cl)
