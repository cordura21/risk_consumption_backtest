  # Compare dividend vs s&p
  compare_quality <- merge(vanguard_div_growth,vanguard_snp, by= 'date') %>%
    select(date,year_return.x,year_return.y) %>% tbl_df()
  
  names(compare_quality) <- c('date','quality','snp')
  compare_quality <- compare_quality %>%
    mutate(spread = (100 * 1 + quality) - (100 * (1 + snp))) %>% 
  filter( !(is.na(spread))) 

spread_quality <- xts(compare_quality[,2:3],compare_quality$date)
spread_quality <- spread_quality['1997::']


chart.RelativePerformance(spread_quality$quality,spread_quality$snp)

CalmarRatio(spread_quality)
SortinoRatio(spread_quality)
SharpeRatio(spread_quality)
chart.RelativePerformance(spread_quality$quality,spread_quality$snp)

Return.cumulative(spread_quality)
table.CAPM(spread_quality$quality,spread_quality$snp)


maxDrawdown(spread_quality)
