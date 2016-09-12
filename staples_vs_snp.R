# Compare dividend vs s&p
compare_staples <- merge(vanguard_staples,vanguard_snp, by= 'date') %>%
  select(date,year_return.x,year_return.y) %>% tbl_df()

names(compare_staples) <- c('date','staples','snp')
compare_staples <- compare_staples %>%
  mutate(spread = (100 * 1 + staples) - (100 * (1 + snp))) %>% 
  filter( !(is.na(spread))) 

spread_staples <- xts(compare_staples[,2:3],compare_staples$date)
spread_staples <- spread_staples['1997::']


chart.RelativePerformance(spread_staples$staples,spread_staples$snp)

CalmarRatio(spread_staples)
SortinoRatio(spread_staples)
SharpeRatio(spread_staples)
chart.RelativePerformance(spread_staples$staples,spread_staples$snp)

Return.cumulative(spread_staples)
table.CAPM(spread_staples$staples,spread_staples$snp)


maxDrawdown(spread_staples)

