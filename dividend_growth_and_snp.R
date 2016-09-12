vanguard_div_growth <- data.frame(coredata(raw_vanguard_div_growth),
                        date = index(raw_vanguard_div_growth)) %>%
                        slice(endpoints(date,on = 'months')) %>%
                        mutate(return = ROC(Close, n = 1,type = 'discrete')) %>%
                        mutate(year_return = ROC(Close, n = 1,type = 'discrete'),
                        ticker = 'dividend_growth')

vanguard_snp <- data.frame(coredata(raw_vanaguard_snp),
                           date = index(raw_vanguard_snp)) %>%
  slice(endpoints(date,on = 'months')) %>%
  mutate(return = ROC(Close, n = 1,type = 'discrete')) %>%
  mutate(year_return = ROC(Close, n = 1,type = 'discrete'),
         ticker = 'snp')

vanguard_staples <- data.frame(coredata(raw_vanguard_staples),
                           date = index(raw_vanguard_staples)) %>%
  slice(endpoints(date,on = 'months')) %>%
  mutate(return = ROC(Close, n = 1,type = 'discrete')) %>%
  mutate(year_return = ROC(Close, n = 1,type = 'discrete'),
         ticker = 'vanguard_staples')
