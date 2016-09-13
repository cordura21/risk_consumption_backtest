faber_bt <- read.csv('faber_bt.csv') %>% tbl_df() %>%
  mutate(year = year(mdy(date)))

faber_vs_cape <- merge(faber_bt,cape_avg,by = 'year', all = FALSE)


ggplot(faber_vs_cape,aes(x=  promedio, y= faber_mm)) +
  geom_point() + geom_smooth()
