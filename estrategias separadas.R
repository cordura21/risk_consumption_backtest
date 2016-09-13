beta_strats <- readRDS('all_prices.RDS') %>% tbl_df() %>%
  select(date,estrategia,name,rets)

iLoop_assets <- unique(beta_strats$name)
iLoop_tables <- data.table()
xts_objects <- list()
for(iLoop in 1:length(iLoop_assets)){
  iLoop_tmp <- beta_strats %>% filter(name == iLoop_assets[iLoop])
  iLoop_xts <- xts(iLoop_tmp$rets,iLoop_tmp$date)
  xts_objects[[iLoop_assets[iLoop]]] <- iLoop_xts
  names(iLoop_xts) <- iLoop_assets[iLoop]
  iLoop_stats <- data.frame()
  iLoop_stats[1,'name'] <- iLoop_assets[iLoop]
  iLoop_stats[1,'cagr'] <- as.numeric(Return.annualized(iLoop_xts))
  iLoop_stats[1,'maxDD'] <- as.numeric(maxDrawdown(iLoop_xts))
  iLoop_stats[1,'start'] <- year(first(index(iLoop_xts)))
  iLoop_stats[1,'end'] <- year(last(index(iLoop_xts)))
  iLoop_tables <- rbind(iLoop_tables,iLoop_stats)
}
iLoop_tables$mar <- round(iLoop_tables$cagr / iLoop_tables$maxDD,2)

quality.portfolio <- merge(join = 'inner',xts_objects$`Consumer Staples (Fidelity)`,
                           xts_objects$`Consumer Discretionary (Fidelity)`)
quality.portfolio <- Return.portfolio(quality.portfolio,weights = c(.8,.2),
                                      rebalance_on = 'years')

Return.annualized(quality.portfolio)
maxDrawdown(quality.portfolio)
charts.PerformanceSummary(quality.portfolio)
xts_objects[['quality']] <- quality.portfolio

primas.portfolio <- merge(join = 'inner', xts_objects$`Bonds High Yield`,
                          xts_objects$`Bonds Emerging Markets`,
                          xts_objects$USA,
                          xts_objects$Desarrollados,
                          xts_objects$Emergentes)

primas.portfolio <- Return.portfolio(primas.portfolio, rebalance_on = 'years')

Return.annualized(primas.portfolio)
maxDrawdown(primas.portfolio)
charts.PerformanceSummary(primas.portfolio)

xts_objects[['primas']] <- primas.portfolio
xts_objects[['wesley']] <- wesley.xts
xts_objects[['macromodel']] <- our_bt

all_beta_no_sit <- Return.portfolio(merge.xts(join = 'inner',
                             xts_objects$macromodel,
                             xts_objects$primas,
                             xts_objects$wesley,
                             xts_objects$quality))

Return.annualized(all_beta_no_sit)
maxDrawdown(all_beta_no_sit)
charts.PerformanceSummary(all_beta_no_sit)
first(all_beta_no_sit)
tail(all_beta_no_sit)

