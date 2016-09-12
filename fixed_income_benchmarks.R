backest_high_yield <- read.csv('BAMLHYH0A0HYM2TRIV.csv',
                               stringsAsFactors = FALSE) %>% tbl_df() %>%
  mutate(DATE = as.Date(DATE)) %>%
  filter( BAMLHYH0A0HYM2TRIV != '.', !is.na(DATE)) %>% 
  slice( endpoints(DATE, on = 'months')) %>%
  mutate(price = BAMLHYH0A0HYM2TRIV,
         BAMLHYH0A0HYM2TRIV = NULL,
         TTR::ROC(price, n = 1, type = 'discrete')) 


backest_corporate_bonds <- read.csv('BAMLCC8A015PYTRIV-2',
                               stringsAsFactors = FALSE) %>% tbl_df() %>%
  mutate(DATE = as.Date(DATE)) %>%
  filter( BAMLHYH0A0HYM2TRIV != '.', !is.na(DATE)) %>% 
  slice( endpoints(DATE, on = 'months')) %>%
  mutate(price = BAMLCC8A015PYTRIV-2,
         BAMLHYH0A0HYM2TRIV = NULL,
         TTR::ROC(price, n = 1, type = 'discrete')) 



backest_corporate_yield <- read.csv('BAMLCC8A015PYTRIV-2.csv',
                               stringsAsFactors = FALSE) %>% tbl_df() %>%
  mutate(DATE = as.Date(DATE)) %>%
  slice( endpoints(DATE, on = 'months')) %>%
  mutate(price = BAMLCC8A015PYTRIV, BAMLCC8A015PYTRIV = NULL) %>%
  filter( price != '.')



