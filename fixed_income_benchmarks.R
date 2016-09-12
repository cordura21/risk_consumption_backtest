backest_high_yield <- read.csv('BAMLHYH0A0HYM2TRIV.csv',
                               stringsAsFactors = FALSE) %>% tbl_df() %>%
  mutate(DATE = as.Date(DATE)) %>%
  filter( BAMLHYH0A0HYM2TRIV != '.', !is.na(DATE)) %>% 
  slice( endpoints(DATE, on = 'months')) %>%
  mutate(price = BAMLHYH0A0HYM2TRIV,
         BAMLHYH0A0HYM2TRIV = NULL,
         return = TTR::ROC(price, n = 1, type = 'discrete')) 

backest_corporate_bonds <- read.csv('BAMLCC8A015PYTRIV-2.csv',
                                    stringsAsFactors = FALSE) %>% tbl_df() %>%
  mutate(DATE = as.Date(DATE)) %>%
  filter( BAMLCC8A015PYTRIV != '.', !is.na(DATE)) %>% 
  slice( endpoints(DATE, on = 'months')) %>%
  mutate(price = BAMLCC8A015PYTRIV,
         BAMLCC8A015PYTRIV = NULL,
         return = TTR::ROC(price, n = 1, type = 'discrete')) 

backest_corporate_emerging_markets <- read.csv('BAMLEMCBPITRIV.csv',
                                               stringsAsFactors = FALSE) %>%
  tbl_df() %>%
  mutate(DATE = as.Date(DATE)) %>%
  filter( BAMLEMCBPITRIV != '.', !is.na(DATE)) %>% 
  slice( endpoints(DATE, on = 'months')) %>%
  mutate(price = BAMLEMCBPITRIV,
         BAMLEMCBPITRIV = NULL,
         TTR::ROC(price, n = 1, type = 'discrete')) 



