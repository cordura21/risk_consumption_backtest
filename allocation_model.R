library(dplyr)

beta.alloc <- data.frame(strats = c( 'macromodel',
                                     'primas de mercado',
                                     'quality',
                                     'value relativo',
                                     'situaciones especiales'),
                         allocation = rep(.20,5),
                         expected_return = c(.065,.07,.10,.085,.10),
                         allocated_time = rep(1,5))

xxx <- read.csv('ML Corporate Index.csv', stringsAsFactors = FALSE) %>% tbl_df() %>%
  filter(BAMLCC7A01015YTRIV !=0) %>%
  mutate(observation_date = as.Date(observation_date)) %>%
  mutate(ML_Corporate = ROC(BAMLCC7A01015YTRIV,1)) %>%
  filter(ML_Corporate != 0)
