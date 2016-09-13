faber_prices <- read.csv('prices_macromodel.csv', stringsAsFactors = FALSE) %>% tbl_df

rfr <- faber_prices %>%  filter(ticker == 'usgg3m index') %>%
  mutate(PX_LAST = PX_LAST / 1200) %>%
  mutate(factor = cumprod(1 + PX_LAST), return = ROC(factor),
         date = ymd(date)) %>%
  select(date,return)


faber_prices_2 <- faber_prices %>% 
  group_by(name) %>%
  mutate(return = rets, ma = SMA(PX_LAST,10))  %>%
  mutate(above_ma = PX_LAST >= ma) %>%
  mutate(check = ifelse(lag(above_ma),return,NA)) %>%
filter( !(is.na(ma)))

first_common_date <- faber_prices_2 %>% select(name,date) %>%
  group_by(name) %>% summarize(first = first(date)) %>% 
  summarise(max(first)) %>% as.character.Date() 

faber_prices_2 <- faber_prices_2 %>%
  filter(date >= first_common_date$`max(first)`) %>%
  filter( ticker != 'usgg3m index')  %>%
  mutate(date = ymd(date))

names(rfr) <- c('date', 'rfr')

faber_3 <- merge(faber_prices_2,rfr,by = 'date')  %>% tbl_df() %>%
  mutate(final_return = ifelse(is.na(check),rets,rfr)) %>%
  mutate(date = ymd(date)) %>%
  select(date,name,return)

faber_casted <- tidyr::spread(faber_3,name,return)
faber_casted.xts <- xts(faber_casted[,-1], faber_casted$date)
portfolio_faber <- Return.portfolio(faber_casted.xts, rebalance_on = 'years')

