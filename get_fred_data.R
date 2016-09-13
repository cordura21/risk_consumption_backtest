library(gdata)
library(data.table)

Symbol <- "BAMLCC7A01015YTRIV"
FRED.URL <- "http://research.stlouisfed.org/fred2/series"

download.file(paste0(FRED.URL, "/", Symbol, "/downloaddata/", Symbol, ".csv"),
              destfile='fred.csv')

data <- as.data.table(read.csv('fred.csv'))

data$DATE <- as.Date(data$DATE)
data$VALUE <- as.numeric(as.character(data$VALUE))

monthly_data <- data[endpoints(as.xts.data.table(data),on = 'months')]
monthly_data <- monthly_data[,rets:=TTR::ROC(VALUE,type='discrete')]

xts_data <- as.xts.data.table(monthly_data[,.(DATE,rets)])
charts.PerformanceSummary(xts_data)
Return.annualized(xts_data)
