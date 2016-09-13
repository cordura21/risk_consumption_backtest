re_aff <- read.csv('core_asset_class_expected_returns.csv',
                   na.strings = '-', stringsAsFactors = FALSE) %>% tbl_df() %>%
  filter(!(is.na(Expected.Return..)))
re_aff$Asset.class
assets_in_my_portfolio <- c("US Large", 'REITs','LT US Treas',
                            'High Yield', 'EM (Non-Local) Debt',
                            'Commodities','EM Equity','EAFE Equity')
my_re_aff_assets <- re_aff %>%
  filter( Asset.class %in% assets_in_my_portfolio)

my_re_assets_short <- my_re_aff_assets %>%
  select(Asset.class,Expected.Return..) %>%
  mutate(Expected.Return.. = (Expected.Return.. + 2)/100)
names(my_re_assets_short) <- c('strats', 'expected_return')


beta.alloc_raff <- data.frame(strats = my_re_assets_short$strats,
                              expected_return = my_re_assets_short$expected_return)

                                
beta.alloc_raff$allocation <- c(0.2 *0.2+ 0.2 * 0.2 + 0.2  + 0.2 + 0.2, #SnP + Sit Esp
                                0.2 * 0.2, # Reits
                                0.2 * 0.2, # LT Treasury
                                0.2 * 0.2, # High Yield
                                0.2 * 0.2, # EM Debt
                                0.2 * 0.2, # Commodities
                                0.2 * 0.2, # EAFE
                                0.2 * 0.2 + 0.2 * 0.2 # EM Equity
                                )
print(sum(beta.alloc_raff$expected_return * beta.alloc_raff$allocation))

beta.expected.return <- sum(beta.alloc$allocation * beta.alloc$expected_return)
time_in_market <- sum(beta.alloc$allocated_time) / length(beta.alloc$strats)
beta.expected.return <- beta.expected.return * time_in_market + 
  beta.alloc$expected_return[1] * (1 - time_in_market)
print(paste("Retorno:",beta.expected.return * 100))
print(paste("Tiempo Invertido:",time_in_market ))

