# Displaying time series data

## Load packages

library(doParallel)
library(dplyr)
library(ggplot2)

## Load Parallelization

cl <- makePSOCKcluster(8)
registerDoParallel(cl)

## Load data

apple_data <- read.csv("financial_data/data/AAPL.csv", stringsAsFactors = FALSE)
tesla_data <- read.csv("financial_data/data/TSLA.csv", stringsAsFactors = FALSE)
amzn_data <- read.csv("financial_data/data/AMZN.csv", stringsAsFactors = FALSE)
google_data <- read.csv("financial_data/data/GOOGL.csv", stringsAsFactors = FALSE)

## Prepare data

apple_data$Date <- as.Date(apple_data$Date)
apple_data <- arrange(apple_data, Date)

tesla_data$Date <- as.Date(tesla_data$Date)
tesla_data <- arrange(tesla_data, Date)

amzn_data$Date <- as.Date(amzn_data$Date)
amzn_data <- arrange(amzn_data, Date)

google_data$Date <- as.Date(google_data$Date)
google_data <- arrange(google_data, Date)

## Display plot

p <- ggplot(data = apple_data, aes(x = Date, y = Close)) +
    geom_line(aes(color = "Apple")) +
    geom_line(data = tesla_data, aes(color = "Tesla")) +
    geom_line(data = amzn_data, aes(color = "Amazon")) +
    geom_line(data = google_data, aes(color = "Google")) +
    labs(color = "Legend") +
    scale_color_manual("",
        breaks = c("Apple", "Tesla", "Amazon", "Google"),
        values = c("grey", "red", "orange", "blue")
    ) +
    scale_x_date(breaks = "1 year") +
    theme(axis.title = element_text(face = "bold"))

p

ggsave("plot.svg")

## Stop Parallelization

stopCluster(cl)
