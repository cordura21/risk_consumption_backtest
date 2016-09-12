period <- "1984::1987-08-01"

div_growth <- raw_vanguard_div_growth[
  endpoints(raw_vanguard_div_growth, on = 'months'), 'Close'
]
names(div_growth) <- 'dividend_growth'

staples <- raw_vanguard_staples[
  endpoints(raw_vanguard_staples, on = 'months'), 'Close'
  ]
names(staples) <- 'staples'

snp <- raw_vanguard_snp[
  endpoints(raw_vanguard_snp, on = 'months'), 'Close'
  ]
names(snp) <- 'snp'


# Compare Staples Against S&P ---------------------------------------------

compared <- merge(staples,snp, join = 'inner')
compared <- ROC(compared)

chart.CumReturns(compared[period,])

charts.RollingPerformance(compared, width = 5 * 12 )

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
bmk_dd_table$compared_depth <- NA
bmk_dd_table$compared_recovery <- NA
bmk_dd_table$compared_bmk_return <- NA


for(iCount in 1:5){
  iCount_Period <- paste(bmk_dd_table[iCount,1],bmk_dd_table[iCount,2], sep = '::')
  bmk_dd_table$compared_depth[iCount] <- Return.cumulative(compared[iCount_Period,1])
}

for(iCount in 1:5){
  start_month <- bmk_dd_table[iCount,2]
  start_month <- index(compared)[which(index(compared) == start_month)+1]
  iCount_Period <- paste(start_month,bmk_dd_table[iCount,3], sep = '::')
  bmk_dd_table$compared_recovery[iCount] <- Return.cumulative(compared[iCount_Period,1])
  bmk_dd_table$compared_bmk_return[iCount] <- Return.cumulative(compared[iCount_Period,2])
}
bmk_dd_table
charts.PerformanceSummary(compared[period,])




