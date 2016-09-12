wesley <- read.csv('backtest_de_wesley')[,c(1,4)]
wesley.xts <- xts(wesley[,-1],mdy(wesley[,1]))['1991::2011']
day(index(wesley.xts)) <- 1
snp_for_wesley <- ROC(snp,1,type = 'discrete')
day(index(snp_for_wesley)) <- 1
wesley.xts <- merge(wesley.xts,snp_for_wesley,join = 'inner')

Return.annualized(wesley.xts)
charts.PerformanceSummary(wesley.xts)
maxDrawdown(wesley.xts)
