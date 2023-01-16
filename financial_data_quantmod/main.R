#  Exploring the quantmod package for real-time data

## Load packages

library(doParallel)
library(quantmod)

## Load parallelization

cl <- makePSOCKcluster(8)
registerDoParallel(cl)

## Load data

getSymbols("NFLX")

## Standard financial chart

chartSeries(NFLX,
    type = "auto"
)

## Stop Parallelization

stopCluster(cl)
