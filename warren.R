warren <- berkshire[endpoints(berkshire, on = 'months'),'Close']
day(index(warren)) <- 1
snp_for_warren <- snp
day(index(snp_for_warren)) <- 1
warren <- merge(warren,snp_for_warren, join = 'inner')
warren <- ROC(warren)
charts.PerformanceSummary(warren)
