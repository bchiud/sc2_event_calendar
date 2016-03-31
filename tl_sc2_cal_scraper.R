setwd("/Users/bradychiu/Dropbox (Uber Technologies)/R/sc2_event_calendar")

library(lubridate)

# gets html src code for today and tomorrow's calendar
get_html_src<-function(time=Sys.time()){
  tl_link<-paste(
    "http://www.teamliquid.net/calendar/?view=week&year="
    ,format(time,"%Y")
    ,"&month="
    ,format(time,"%m")
    ,"&day="
    ,format(time,"%d")
    ,sep=""
    )
  html_src<<-htmlParse(readLines(tl_link))
}
get_html_src()



# event : <span data-event-id="29477">GSL Code S</span>
xpathSApply(html_src, path='//span[@data-event-id="29477"]', fun=xmlValue)

# stage : <div class="ev-stage">Round of 16 - Group B</div>
stage <- xpathSApply(html_src, path='//span[@class="ev-stage"]', fun=xmlValue)

# time : <span class="ev-timer">09:30</span>
time <- xpathSApply(html_src, path='//span[@class="ev-timer"]', fun=xmlValue)
getNodeSet




xpathApply(htmlParse(tl_link_tomorrow),'//span[@class="ev-timer"]',xmlValue)