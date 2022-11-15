library(dplyr)
library(readxl)
library(tidyverse)
state_divorce_rates_90_95_99_20 <- read_excel("Documents/info201/assignments/project-group-2-section-ag/source/state-divorce-rates-90-95-99-20.xlsx")

data <- read_excel("Documents/info201/assignments/project-group-2-section-ag/source/state-divorce-rates-90-95-99-20.xlsx", skip = 2)
colnames(data)[1] <- "state"
data <- data[-nrow(data), ]
data <- data %>% gather(key=year, value=rate, -state)
data <- data %>% filter(rate!="---") %>%
  mutate(rate=as.numeric(rate)) %>%
  mutate(year=as.numeric(year))
data

df <- data.frame(data$state, data$rate, data$year)
df
