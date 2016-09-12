raw_vanguard_div_growth <- TTR::getYahooData('VDIGX', start = '19920515',
                    end = '20160909',freq = 'daily' )

raw_vanguard_snp <- TTR::getYahooData('VFINX', start = '19920515',
                                   end = '20160909',freq = 'daily' )

vanguard_div_growth <- data.frame(coredata(raw_vanguard_div_growth),
                              date = index(raw_vanguard_div_growth)) %>%
  tbl_df() %>% mutate(return = ROC(Close, n = 1,type = 'discrete')) %>%
  mutate(year_return = ROC(Close, n = 260,type = 'discrete'),
         ticker = 'dividend_growth') %>%
  slice(endpoints(date,on = 'months'))

vanguard_snp <- data.frame(coredata(raw_vanaguard_snp),
                                  date = index(raw_vanaguard_snp)) %>%
  tbl_df() %>% mutate(return = ROC(Close, n = 1,type = 'discrete')) %>%
  mutate(year_return = ROC(Close, n = 260,type = 'discrete'),
  ticker = 's&p') %>%
  slice(endpoints(date,on = 'months'))

