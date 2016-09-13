cape_data <- read.csv('ie_data.csv') %>% tbl_df() %>%
  mutate(Date = as.Date(date_decimal(Fraction))) %>%
  select(Date,CAPE) %>%
  filter(!(is.na(Date)))

day(cape_data$Date) <- 1
month(cape_data$Date) <- month(cape_data$Date) + 1
day(cape_data$Date) <- day(cape_data$Date) - 1

cape.xts <- xts(cape_data[,-1], cape_data$Date)
