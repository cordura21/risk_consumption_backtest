# Compare staples vs s&p
compare_staples <- merge(vanguard_staples,vanguard_snp, by= 'date') %>%
  select(date,year_return.x,year_return.y) %>% tbl_df() %>%
  mutate(date = as.Date(date))

names(compare_staples) <- c('date','staples','snp')
compare_staples <- compare_staples %>%
  mutate(spread = (100 * 1 + staples) - (100 * (1 + snp))) %>% 
  filter( !(is.na(spread))) 

spread_staples <- xts(compare_staples[,2:3],compare_staples$date)
day(index(spread_staples)) <- 1
index(spread_staples) <- as.Date(index(spread_staples))


###############
#### APALANCAMIENTO !>!
#### spread_staples$staples <- spread_staples$staples * (50 / 37)


spread_staples <- spread_staples['::']

charts.PerformanceSummary(spread_staples)
chart.Drawdown(spread_staples)
chart.RelativePerformance(spread_staples$staples,spread_staples$snp)

CalmarRatio(spread_staples)
SortinoRatio(spread_staples)
SharpeRatio(spread_staples)
chart.RelativePerformance(spread_staples$staples,spread_staples$snp)
chart.RollingPerformance(spread_staples,width = 12)

Return.cumulative(spread_staples)
table.CAPM(spread_staples$staples,spread_staples$snp)

chart.CumReturns(spread_staples, legend.loc = 'top')

Return.annualized(spread_staples)
SharpeRatio.annualized(spread_staples)
maxDrawdown(spread_staples)

table.Drawdowns(spread_staples)



