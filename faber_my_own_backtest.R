our_bt <- readRDS('macromodel_backtest.RDS')
charts.RollingPerformance(our_bt,width = 36)

Return.annualized(our_bt)
maxDrawdown(our_bt)
first(index(our_bt))
