warren <- berkshire[endpoints(berkshire, on = 'months'),'Close']
day(index(warren)) <- 1


snp_for_warren <- snp
day(index(snp_for_warren)) <- 1

staples_for_warren <- staples
day(index(staples_for_warren)) <- 1


warren <- merge(warren,snp_for_warren, join = 'inner')
warren <- merge(warren,staples_for_warren, join = 'inner')
names(warren) <- c('Warren','S&P','Staples')
warren <- ROC(warren)

charts.PerformanceSummary(warren)
chart.RelativePerformance(warren[,1],warren[,2])
# =======
snp_for_warren <- snp
day(index(snp_for_warren)) <- 1
warren <- merge(warren,snp_for_warren, join = 'inner')
warren <- ROC(warren)
charts.PerformanceSummary(warren)

