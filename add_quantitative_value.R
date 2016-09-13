wesley.xts <- read.csv('Sheet1-Table 1.csv') %>% tbl_df() %>%
  mutate(Date = mdy(Date)) %>%
  select(Date,QV.II.MR..disp.)
wesley.xts <- xts(wesley.xts$QV.II.MR..disp.,wesley.xts$Date)
wesley.xts <- wesley.xts * 0.55
Return.annualized(wesley.xts)
maxDrawdown(wesley.xts)

greenblatt_tail <- xts_objects$Greenblat['2014-01-01::']
relative_value <- rbind(wesley.xts,greenblatt_tail)
