stap_opp <- merge(spread_staples[,1],cape_xts,join = 'inner')

chart.CumReturns(stap_opp[which(stap_opp$cape_xts <= 16),1])
