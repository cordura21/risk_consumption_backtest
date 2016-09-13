cape_data <- read.csv('ie_data.csv') %>% tbl_df() %>%
  mutate(Date = as.Date(date_decimal(Fraction))) %>%
  select(Date,CAPE) %>%
  filter(!(is.na(Date))) %>%
  mutate(year = year(Date))

cape_avg <- cape_data %>%
  group_by(year) %>%
  summarise(promedio = mean(CAPE))

day(cape_data$Date) <- 1
month(cape_data$Date) <- month(cape_data$Date) + 1
day(cape_data$Date) <- day(cape_data$Date) - 1

cape.xts <- xts(cape_data[,-1], cape_data$Date)
