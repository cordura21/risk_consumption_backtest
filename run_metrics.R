chart.CumReturns(compared)

charts.RollingPerformance(compared, width = 12 )

chart.RollingRegression(compared[,1], compared[,2],width = 36,
                        attribute = 'Beta')

print(Return.annualized(compared))

print(StdDev.annualized(compared))
print(SharpeRatio.annualized(compared))
print(CalmarRatio(compared))
print(maxDrawdown(compared))

print(table.Drawdowns(compared[,1]))
print(table.CAPM(compared[,1], compared[,2]))

bmk_dd_table <- table.Drawdowns(compared[,2])

for(iCount in 1:5){
  iCount_Period <- paste(bmk_dd_table[iCount,1],bmk_dd_table[iCount,2], sep = '::')
  print(Return.cumulative(compared[iCount_Period,]))
}


