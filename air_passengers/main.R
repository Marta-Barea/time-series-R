#  Time Series Analysis and Modeling with the Air Passengers Dataset

## Load packages

library(doParallel)
library(forecast)
library(fpp2)
library(TSstudio)

## Load Parallelization

cl <- makePSOCKcluster(8)
registerDoParallel(cl)

## Load data

data(AirPassengers)
ap_data <- AirPassengers

## Inspect data

ts_info(AirPassengers)
ap_data
anyNA(ap_data)

## Descriptive statistics

summary(ap_data)

##  Time plot

p1 <- autoplot(ap_data) +
    labs(
        x = "Year",
        y = "Passengers (1000s)",
        title = "Number of Passengers from 1949 to 1960"
    ) +
    theme(
        axis.title = element_text(
            face = "bold"
        ),
        title = element_text(
            face = "bold"
        )
    ) +
    geom_point(color = "purple")

p1

# ggsave("air_passengers/ts_plot.svg")

## Time serie decomposition: multiplicative classical decompostion

ap_decompose <- decompose(ap_data, type = "multiplicative")

p2 <- autoplot(ap_decompose) +
    theme(
        axis.title = element_text(
            face = "bold"
        ),
        title = element_text(
            face = "bold"
        ),
        strip.background = element_rect(
            fill = "purple"
        ),
        strip.text = element_text(
            color = "white"
        )
    ) +
    labs(
        x = "Year",
        y = "Passengers (1000s)"
    )

p2

# ggsave("air_passengers/ts_decomposition.svg")

## Seasonality analysis

## Boxplot

boxplot(ap_data ~ cycle(ap_data),
    xlab = "",
    ylab = ""
)

rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4],
    col = "#ebebeb"
)

grid(
    nx = NULL, ny = NULL, col = "white", lty = 1,
    lwd = par("lwd"), equilogs = TRUE
)

par(new = TRUE)

# svg("air_passengers/boxplot.svg")

p3 <- boxplot(ap_data ~ cycle(ap_data),
    xlab = expression(bold("Months")),
    ylab = expression(bold("Passengers (1000s)")),
    main = "Monthly Air Passengers Boxplot from 1949 to 1960",
    col = "purple",
    whislty = 2,
)

p3

# dev.off()

## Correlation analysis



## Stop Parallelization

stopCluster(cl)
