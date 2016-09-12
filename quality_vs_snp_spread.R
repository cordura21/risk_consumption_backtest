  # Compare dividend vs s&p
  compare_quality <- merge(vanguard_div_growth,vanguard_snp, by= 'date') %>%
    select(date,year_return.x,year_return.y) %>% tbl_df()
  names(compare_quality) <- c('date','quality','snp')
  compare_quality <- compare_quality %>%
    filter( !(is.na(spread))) %>% 
    mutate(spread = quality - snp) %>% 
  filter( !(is.na(spread))) 
    
  
  # compare_quality <- gather(compare_quality,stock,yearly.return,-date)
  
  ggplot(compare_quality,aes(x = date, y = spread)) + geom_line() +
    geom_smooth() + 
    scale_x_date(date_breaks = "2 years") +
    scale_y_continuous(labels = scales::percent)
