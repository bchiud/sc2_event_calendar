setwd("/Users/bradychiu/Dropbox (Uber Technologies)/R/sc2_event_calendar")

library(lubridate)
library(stringr)
library(XML)

# gets html src code for this month's calendar
get_html_src<-function(time=Sys.time()){
  tl_link<<-paste(
    "http://www.teamliquid.net/calendar/?view=month&year="
    ,format(time,"%Y")
    ,"&month="
    ,format(time,"%m")
    ,"&day="
    ,format(time,"%d")
    ,"&team=&league=&game=1"
    ,sep=""
  )
  html_src<<-htmlParse(readLines(tl_link))
}
get_html_src()

# day : div class="ev-feed" data-day="4"         <td class="evc-l">
day<-xpathSApply(
  doc=html_src
  ,path='//td[@class="evc-l"]'
  ,fun=xmlValue
)

temp_df<-data.frame(raw_string=strsplit(day[3],"\n")[[1]])
temp_df$tabs<-sapply(temp_df$raw_string,function(x) str_count(x,"\t"))
temp_df

test_vector<-c("asdf\t\tasdf","asdfasfd","asdf\t\t\tasdf")
grepl("\t",test_vector)
grep("\t",test_vector)
length(strsplit(test_vector,"\t")[[1]])
length(strsplit(test_vector,"\t")[[2]])
length(strsplit(test_vector,"\t")[[3]])
str_count(test_vector[1],"\t")
str_count(test_vector[2],"\t")
str_count(test_vector[3],"\t")


# event : <span data-event-id="29477">GSL Code S</span>
event<-xpathSApply(
  doc=html_src
  ,path='//div[@class="ev-ctrl"]'
  ,fun=xmlValue
)

# stage : <div class="ev-stage">Round of 16 - Group B</div>
stage<-xpathSApply(
  doc=html_src
  ,path='//div[@class="ev-stage"]'
  ,fun=xmlValue
)

# time : <span class="ev-timer">09:30</span>
time<-xpathSApply(
  doc=html_src
  ,path='//span[@class="ev-timer"]'
  ,fun=xmlValue
)
time<-time[time!=""]

# get blogger urls with XML:<br>library(RCurl)<br>library(XML)<br>script <- getURL("www.r-bloggers.com")<br>doc <- htmlParse(script)<br>li <- getNodeSet(doc, "//ul[@class='xoxo blogroll']//a")<br>urls <- sapply(li, xmlGetAttr, "href")<br>