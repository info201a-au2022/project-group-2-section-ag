library(readxl)
library(tidyverse)
library(shiny)
library(plotly)
library(maps)

divorce <- read.csv("divorce.csv")
data <- read_excel("state-divorce-rates-90-95-99-20.xlsx", range="A3:Y54")
colnames(data)[1] <- "state"
data <- data %>% gather(key=year, value=rate,-state) %>% filter(rate!="---") %>%
  mutate(rate=as.numeric(rate)) %>%
  mutate(year=as.numeric(year))


server <- function(input, output) {
  output$plot1 <- renderPlotly({
    data %>% filter(state==input$state) %>%
      ggplot(aes(x=year, y=rate)) + geom_line() + geom_point()
  })
  
  output$plot2 <- renderPlotly({
    df <- divorce[, c(input$var, "Divorce_Y_N")]  
    df[[1]] <- factor(df[, 1])
    df$Divorce_Y_N <- factor(df$Divorce_Y_N)
    ggplot(df, aes_string(x=input$var, fill="Divorce_Y_N")) + geom_bar(position = "fill")
  })
  
  output$plot3 <- renderPlotly({
    usa <-map_data("state")
    df <- data %>% filter(year==input$year) %>% mutate(state=tolower(state)) %>% rename(region=state)
    
    usa %>% left_join(df) %>%
      ggplot(aes(x=long, y=lat, group=group, fill=rate, label=region)) + geom_polygon(color="white") +
      scale_fill_gradient(low='white', high="red") +
      labs(fill="Divorce Rate")
    
    
  })
  
}

