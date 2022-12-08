library(readxl)
library(tidyverse)
library(shiny)
library(plotly)

divorce <- read.csv("divorce.csv")
data <- read_excel("state-divorce-rates-90-95-99-20.xlsx", range="A3:Y54")
colnames(data)[1] <- "state"
data <- data %>% gather(key=year, value=rate,-state) %>% filter(rate!="---") %>%
  mutate(rate=as.numeric(rate)) %>%
  mutate(year=as.numeric(year))


ui <- navbarPage("Divorce 1",
                 tabPanel("Introduction",
                          h1("Introduction"),
                          p("The primary purpose of this project is to determine the reason for constantly improving the divorce rate and how to help people in today’s society build long-lasting relationships."),
                          h2("Problem Domain"),
                          p("We are focusing on divorce and the divorce rate in our nation is the third highest in the world. Reducing divorce and building a long-lasting marriage is our goal.
When a marriage fails that will cause a lot of problems. 
"),
                          h2("Research Questions"),
                          p("As social media becomes more and more popular in modern society, activity organizers and social applications enable our interpersonal communication to expand, and we are more likely to associate with people who share similar interests and values or are attracted to us. Do people still tend to have long-lasting relationships when they notice their differences from their spouses and have more chances to meet people that they think are more appropriate in terms of forming relationships?

Maintaining a long-lasting relationship requires patience and effort. A trifle between a couple could become fierce wrangling or even divorce when handled improperly. Sometimes people overthink and make exaggerated judgments. Sometimes people blurt out hurtful words. These make people reconsider if they share the same values with their partners or if the marriage is not ideal as they anticipate. What is the correlation between divorce and the ways couples deal with deteriorative conversation?

Companionship is also a key factor in a satisfactory marriage. Couples who travel together and spend time at home may feel happier and be less likely to divorce than those who don’t.  How significant is the role of companionship in a marriage?

People from different places or cultures may conduct differently in relationships. Some places are believed to have a lower divorce rate than others. Factors such as finance, crime, culture, and religion may be included. What place has a relatively low or high divorce rate? 
"),
                          h2("About Data"),
                          p("The provenance of our dataset is UCI ML Repository. The data was collected by Dr. Mustafa Kemal Yöntem, Dr. Kemal ADEM, Prof. Dr. Tahsin İlhan, and lecturer Serhat Kılıçarslan, on July 24th, 2019 for the purpose of predicting divorce using correlation.
The data collection was funded by the National Science Foundation.
"),
                          h2("Key Findings"),
                          p("Couples that lived together may still have different answers for different statements, and those differences played as the determinant factor in terms of keeping or having a deep relationship.
                          
                          Couples who answered a high scale in the statement, “if one of us apologizes when our discussion deteriorates, the discussion ends,” were more likely to keep relationships.

Companionship was the key factor in a marriage.

Some states had a significantly higher or significantly lower divorce rate than others.
")
                 ),
                 tabPanel(
                   "Interactive1",
                   # Sidebar layout with input and output definitions ----
                   sidebarLayout(
                     
                     # Sidebar panel for inputs ----
                     sidebarPanel(
                       
                       selectInput("state", "State:",
                                   choices = unique(data$state),
                                   selected = unique(data$state)[1])
                       
                     ),
                     
                     # Main panel for displaying outputs ----
                     mainPanel(
                       
                       # Output: Histogram ----
                       plotlyOutput(outputId = "plot1")
                       
                     )
                   )
                 ),
                 tabPanel(
                   "Interactive2",
                   # Sidebar layout with input and output definitions ----
                   sidebarLayout(
                     
                     # Sidebar panel for inputs ----
                     sidebarPanel(
                       
                       selectInput("var", "Variable:",
                                   choices = colnames(divorce)[-ncol(divorce)],
                                   selected = colnames(divorce)[1]),
                       p("Questions are ranked on a scale of 1-5 with 1 being the lowest and 5 being the highest. The last category states if the couple has divorced."),
                       
                       
p("1.	If one of us apologizes when our discussion deteriorates, the discussion ends."),
p("2.	I know we can ignore our differences, even if things get hard sometimes."),
p("3.	When we need it, we can take our discussions with my spouse from the beginning and correct it."),
p("4.	When I discuss with my spouse, to contact him will eventually work."),
p("5.	The time I spent with my wife is special for us."),
p("6.	We don't have time at home as partners."),
p("7.	We are like two strangers who share the same environment at home rather than family."),
p("8.	I enjoy our holidays with my wife."),
p("9.	I enjoy traveling with my wife."),
p("10.	Most of our goals are common to my spouse."),
p("11.	I think that one day in the future, when I look back, I see that my spouse and I have been in harmony with each other."),
p("12.	My spouse and I have similar values in terms of personal freedom."),
p("13.	My spouse and I have similar sense of entertainment."),
p("14.	Most of our goals for people (children, friends, etc.) are the same."),
p("15.	Our dreams with my spouse are similar and harmonious."),
p("16.	We're compatible with my spouse about what love should be."),
p("17.	We share the same views about being happy in our life with my spouse"),
p("18.	My spouse and I have similar ideas about how marriage should be"),
p("19.	My spouse and I have similar ideas about how roles should be in marriage"),
p("20.	My spouse and I have similar values in trust."),
p("21.	I know exactly what my wife likes."),
p("22.	I know how my spouse wants to be taken care of when she/he sick."),
p("23.	I know my spouse's favorite food."),
p("24.	I can tell you what kind of stress my spouse is facing in her/his life."),
p("25.	I have knowledge of my spouse's inner world."),
p("26.	I know my spouse's basic anxieties."),
p("27.	I know what my spouse's current sources of stress are."),
p("28.	I know my spouse's hopes and wishes."),
p("29.	I know my spouse very well."),
p("30.	I know my spouse's friends and their social relationships."),
p("31.	I feel aggressive when I argue with my spouse."),
p("32.	When discussing with my spouse, I usually use expressions such as ‘you always’ or ‘you never’ ."),
p("33.	I can use negative statements about my spouse's personality during our discussions."),
p("34.	I can use offensive expressions during our discussions."),
p("35.	I can insult my spouse during our discussions."),
p("36.	I can be humiliating when we discussions."),
p("37.	My discussion with my spouse is not calm."),
p("38.	I hate my spouse's way of open a subject."),
p("39.	Our discussions often occur suddenly."),
p("40.	We're just starting a discussion before I know what's going on."),
p("41.	When I talk to my spouse about something, my calm suddenly breaks."),
p("42.	When I argue with my spouse, ı only go out and I don't say a word."),
p("43.	I mostly stay silent to calm the environment a little bit."),
p("44.	Sometimes I think it's good for me to leave home for a while."),
p("45.	I'd rather stay silent than discuss with my spouse."),
p("46.	Even if I'm right in the discussion, I stay silent to hurt my spouse."),
p("47.	When I discuss with my spouse, I stay silent because I am afraid of not being able to control my anger."),
p("48.	I feel right in our discussions."),
p("49.	I have nothing to do with what I've been accused of."),
p("50.	I'm not actually the one who's guilty about what I'm accused of."),
p("51.	I'm not the one who's wrong about problems at home."),
p("52.	I wouldn't hesitate to tell my spouse about her/his inadequacy."),
p("53.	When I discuss, I remind my spouse of her/his inadequacy."),
p("54.	I'm not afraid to tell my spouse about her/his incompetence."),

p("55. 	Divorce Y/N
")
                       
                     ),
                     
                     # Main panel for displaying outputs ----
                     mainPanel(
                       
                       # Output: Histogram ----
                       plotlyOutput(outputId = "plot2")
                       
                     )
                   )
                 ),
                 tabPanel(
                   "Map",
                   # Sidebar layout with input and output definitions ----
                   sidebarLayout(
                     
                     # Sidebar panel for inputs ----
                     sidebarPanel(
                       
                       # Input: Slider for the number of bins ----
                       sliderInput(inputId = "year",
                                   label = "Year:",
                                   min = min(data$year),
                                   max = max(data$year),
                                   step=1,
                                   sep="",
                                   value = 2020)
                       
                     ),
                     
                     # Main panel for displaying outputs ----
                     mainPanel(
                       
                       # Output: Histogram ----
                       plotlyOutput(outputId = "plot3")
                       
                     )
                   )
                 ),
                 tabPanel("Summary",
                          h2("Summary"),
                          p("Divorce rates in all states showed a gradual decreasing trend from 1990 to 2020."),

                          p("Divorce has an indispensable connection with values, goals, companionship, likes, and ways of handling deteriorative conversations between couples."),

p("Areas also played an important role in divorce rates, which might include geography, local policies, culture, economy, etc.
")),
                 tabPanel("Report",
                          h2("Code Name"),
                          p("Divorce 1"),
                          h2("Project Title"),
                          p("Reasons for Divorce"),
                          h2("Authors"),
                          p("Sena Aberra (Seenaa@uw.edu)
 Xiang Cheng (xiangc7@uw.edu )
 Xiaobin Chen (Xiaobc2@uw.edu)
"),
                          h2("Affiliation"),
                          p("INFO-201: Technical Foundations of Informatics - The Information School - University of Washington"),
                          h2("Date"),
                          p("Autumn 2022"),
                          h2("Abstract"),
                          p("We are concerned with the increasing rate of divorce because it affects societies To address this concern, we plan to use the dataset to understand the cause of divorce and use that to improve a long-lasting relationship."),
                          h2("Keywords"),
                          p("divorce rate, relationship, marriage"),
                          h2("Introduction"),
                          p("The primary purpose of this project is to determine the reason for constantly improving the divorce rate and how to help people in today’s society build long-lasting relationships. Several problems that might cause divorce could be classified as lack of companionship, not enough common goals or life passions, domestic violence or cheating, etc. In this project, we will analyze the dataset about the divorce rate of the nation and the cause of divorce survey to form a complete data visualization that could provide audiences with a comprehensive understanding of what behaviors or practices might directly weaken the relationship with each other during marriage and what behaviors should be avoided in order to build a long-lasting relationship. Also, the project will compare and contrast the devoice rate in different areas to determine if the geographical locations and local environment have significant affection on marriage. Finally, the project will combine those two factors to show the audience what could be the leading cause of divorcing in a specific area. "),
                          h2("Problem domain"),
                          p("We are focusing on divorce and the divorce rate in our nation is the third highest in the world. Reducing divorce and building a long-lasting marriage is our goal.
When a marriage fails that will cause a lot of problems. First, the couple who are getting a divorce is affected. Those problems could be the happiness of the two couples, their mental health, and According to Bloomberg news “ recently separated or divorced adults have higher resting blood pressure.” which is affecting their health and the way of their life. Their divorce will also change their finances which will lead to lower household income, which will change their lives and leads to stress, depression, and anxiety. The people who are affected by the divorce are not only the couple. The divorce will affect their children too. There are many ways children are affected by divorce. For example, they may withdraw socially, their grades might suffer, they feel separation anxiety, their eating and sleeping patterns change, and they go through depression. These are some of the problems caused by divorce in a lot of children across the nation. Those children growing up in single-parent will affect the way they live their lives in the future. Past that divorce has had an economic impact on the nation. The government has been funding for more than two decades to research to find a way to predict with about 90 % accuracy which engaged couples will divorce. For example according to the National Bureau of Economic Research the Bush Administration's recent proposal to Congress for $300 million a year for counseling and other efforts to encourage and support marriage. And  Some states, including Arizona, Arkansas, and Louisiana, created optional covenant marriages that make it harder for couples to divorce. Solving this divorce problem and keeping families together will solve any problem that societies face. Including the problem that we have mentioned above, like the mental health of the couples and their children."),
                          h2("Research questions"),
                          p("As social media becomes more and more popular in modern society, activity organizers and social applications enable our interpersonal communication to expand, and we are more likely to associate with people who share similar interests and values or are attracted to us. Do people still tend to have long-lasting relationships when they notice their differences from their spouses and have more chances to meet people that they think are more appropriate in terms of forming relationships?

Maintaining a long-lasting relationship requires patience and effort. A trifle between a couple could become fierce wrangling or even divorce when handled improperly. Sometimes people overthink and make exaggerated judgments. Sometimes people blurt out hurtful words. These make people reconsider if they share the same values with their partners or if the marriage is not ideal as they anticipate. What is the correlation between divorce and the ways couples deal with deteriorative conversation?

Companionship is also a key factor in a satisfactory marriage. Couples who travel together and spend time at home may feel happier and be less likely to divorce than those who don’t.  How significant is the role of companionship in a marriage?

People from different places or cultures may conduct differently in relationships. Some places are believed to have a lower divorce rate than others. Factors such as finance, crime, culture, and religion may be included. What place has a relatively low or high divorce rate? 
"),
                          h2("The dataset"),
                          p("Based on our dataset, to address the first problem, by collecting results of relationship and value-related questions from the couples and whether they have divorced, we could arrive at the answer by offering the statement, “I know we can ignore our differences, even if things get hard sometimes”, and asking their scale of coincidence. If the data shows there are more divorced couples who don’t believe they can neglect their differences than those who are still married. Then we can conclude that people are less likely to have long-lasting relationships because more than half of people can’t overcome the differences they have, and they may find someone appropriate and compatible. The second question can be answered by investigating how many married and divorced people evaluate, “if one of us apologizes when our discussion deteriorates, the discussion ends.” If the result shows there are more divorced couples who do not coincide when one apologizes, and the discussion ends, than married ones, we could know that clinging to a deteriorative conversation is another major cause to divorce. Third, companionship can be tested through statements such as, “the time I spent with my wife is special for us”, “we don’t have time at home as partners”, “we are like two strangers who share the same environment at home rather than family”, etc. If both have and value the time spent together in a relationship, and the married ones rank higher on these questions than those who have divorced, we could know companionship is essential to a marriage. Finally, our dataset displays divorce rates in different countries, which implicitly illustrates the impact of finance, crime, culture, and religion on marriages. By comparing and arranging the divorce rates in different places, we could realize the places with relatively low and high divorce rates.The provenance of our dataset is UCI ML Repository. The data was collected by Dr. Mustafa Kemal Yöntem, Dr. Kemal ADEM, Prof. Dr. Tahsin İlhan, and lecturer Serhat Kılıçarslan, on July 24th, 2019 for the purpose of predicting divorce using correlation.
The data collection was funded by the National Science Foundation, and marriage and family therapists are likely to profit from the data. Others can use the dataset as a reference. The data was collected and tested by senior scholars and stored in the UCI Machine Learning Repository, which was one of the oldest and most credible archives for data storage. The data was obtained in Kaggle searching by the keyword, “divorce”, and was credited in this project under Acknowledge.
"),
                          h2("Findings"),
                          p("Through data analysis, we found that couples that lived together may still have different answers for different statements, and those differences played as the determinant factor in terms of keeping or having a deep relationship. For example, some of the statements may reveal their different views or values on things they do together. They could have different thoughts or feelings about the statement, “my spouse and I have similar sense of entertainment”, in which one of them may give a scale of 1, and the other gives a 5. They are more likely to answer “yes” in the last question which asks whether they divorced or not. Especially in statements like “my spouse and I have similar ideas about how roles should be in marriage”, and “my spouse and I have similar ideas about how roles should be in marriage”, couples who had significant disparity in their answers are more likely to answer “yes” for their divorce situations.

We found couples who answered a high scale in the statement, “if one of us apologizes when our discussion deteriorates, the discussion ends,” were more likely to answer “no” in the last question that asked about their divorce situation. Those couples were also more likely to answer a high scale of numbers in other relative statements like, “when we need it, we can take our discussions with my spouse from the beginning and correct it,” and, “when I discuss with my spouse, to contact him will eventually work.” Divorce may have a negative correlation with ending deteriorative conversation properly between couples.

We found companionship was a key factor in a marriage. In the statement, “we don't have time at home as partners, “I enjoy our holidays with my wife,” and “I enjoy traveling with my wife,” the couples who answered a high scale of numbers were more likely to keep the relationship compared to those who put lower numbers.

From the data, we could notice the gradual changes in divorce rates in different states in the last 3 decades. Some states had a significantly higher or significantly lower divorce rate than others. In the latest year 2020, Massachusetts had only 1 percent in divorce rate, which was the lowest; whereas Wyoming had the highest divorce rate, 3.8 percent. The nearly fourfold difference between the lowest and the highest may reflect the differences of living environment and culture in their respective residences.
"),
                          h2("Discussion"),
                          p("This project was created with the purpose of letting the audiences have a comprehensive understanding of how the divorce rates in different areas got changed over the past decades. For those data visualizations we provided, it is not hard for the audiences to find out each state's divorce rates increase or decrease trend for the past decades. In addition, the audiences might be able to combine the data shown in the data visualizations with the historical background and significant social events that happen in each year to analyze further the major reasons that cause the divorce rate to increase or decrease. States that contain extremely high or low divorce rates might also need to further explore the reasons behind those unusual numbers. For example, the local policy about divorce might have a significant effect on the local divorce rate. Also, in recent years, divorce in most areas has had a slight trend of decrease; the reason behind that might be directly or indirectly related to the Global Economy, major social policy adjustments, and social events. These are to analyze the changes in the divorce rate in different regions in different periods from a macro perspective. Besides that, there are a significant number of reasons that might cause a couple to end their relationship, even divorce. The personalities of the couple, their lifestyle habits, and the amount of time they spend with each other can all contribute to a relationship becoming more intense or problematic, which also directly causes the divorce to happen in the long run. By reviewing the survey data visualization, The audience could find out that there are several actions and behaviors that will increase the possibility of divorce, and the audience could take this chance to self-check and figure out if they have some behaviors that are mentioned in the data visualization that will harm for a relationship with their partner. These data visualizations provide macro and micro reasons for the increase in the divorce rate. The purpose is to let the audience understand the growing trend of the divorce rate in different regions and some personal behaviors that may affect the relationship. Let the audience better maintain their marriage relationship."),
                          h2("Conclusion"),
                          p("A long-lasting relationship possesses similar values and goals, companionship, knowing, understanding, and avoiding deteriorative conversations. An ideal couple understands each other’s difficulties. For example, they stop arguing when the other apologizes. They know each other’s likes and dislikes, inner world, social relationships, goals, hopes, and wishes. They enjoyed each other’s company, traveling, and having holidays together. They share similar interests, values, ideas, and dreams. The original intention of this project is to analyze the divorce rate and the reasons for public divorce and guide the audience to learn how to maintain the relationship with their partners correctly. After analyzing these data visualizations, viewers can examine their own behaviors that may damage the relationship between the two or that are not conducive to building a stable long-term relationship. Focus on those small details will definitely provide positive contributions to the marriage. On the opposite side, people who already lack experience in maintaining their relationship with their partners and have ignored the above details about strengthening the relationship between the two partners might have a higher possibility of divorce in the long run. On a macro level, differences in regions may also lead to differences in divorce rates because of the differences in living habits of people in various regions and local policies on divorce. As a simple example, some states may have different requirements on the distribution of divorce property, which may cause some couples who would otherwise want to divorce to encounter restrictions and reduce the local divorce rate."),
                          h2("Acknowledgements"),
                          p("Special thanks to Kaggle and UCI ML Repository, which provide valuable data that is essential to the completion of this project.
Thanks should also go to Thomas Winegarden and Rona Guo, who was instrumental in lecturing and educating us about knowledge and management of information.
"),
                          h2("References"),
                          p("	Bloomberg - Are you a robot? (n.d.). Retrieved October 31, 2022, from https://www.bloomberg.com/tosv2.html?vid=&uuid=f7506d3d-597f-11ed-9098-777469444d73&url=L25ld3MvYXJ0aWNsZXMvMjAxOS0wNy0xOS9kaXZvcmNlLWRlc3Ryb3lzLWZpbmFuY2VzLW9mLWFtZXJpY2Fucy1vdmVyLTUwLXN0dWRpZXMtc2hvdw==


Income Declines after Divorce. (n.d.-b). NBER. Retrieved October 31, 2022, from https://www.nber.org/digest/jul02/income-declines-after-divorce

Marcin, A. (2020, May 7). 10 Effects of Divorce on Children — and Helping Them Cope. Healthline. https://www.healthline.com/health/parenting/effects-of-divorce-on-children
Makena Shultz, M. S. U. E. (2021, January 14). Why is social media a beneficial relationship-building tool? MSU Extension. Retrieved October 31, 2022, from https://www.canr.msu.edu/news/why_is_social_media_a_beneficial_relationship_building_tool 

Yöntem, M. K., ADEM, K., İlhan, T., & Kılıçarslan, S. (2021, December 22). Predicting divorce. Kaggle. Retrieved October 31, 2022, from https://www.kaggle.com/datasets/csafrit2/predicting-divorce
")),
)
