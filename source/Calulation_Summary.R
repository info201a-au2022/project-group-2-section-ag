library(dplyr)
library(ggplot2)
library(readxl)

state_divorce_rates <- read_excel("Documents/info201/assignments/project-group-2-section-ag/source/state-divorce-rates-90-95-99-20.xlsx")

colnames(data)[1] <- "state"
data <- data[-nrow(data), ]
data <- data %>% gather(key=year, value=rate, -state)
data <- data %>% filter(rate!="---") %>%
  mutate(rate=as.numeric(rate)) %>%
  mutate(year=as.numeric(year))
data

num_state <- nrow(data)
num_year <- ncol(data)
min_year <- min(data$year)
max_year <- max(data$year)
n_state <- length(unique(data$state))
min_rate <- min(data$rate)
max_rate <- max(data$rate)
mean_rate <- mean(data$rate)
max_rate_record <- data %>% filter(rate==max(rate))
sd_divorce_rate <- sd(data$rate)
