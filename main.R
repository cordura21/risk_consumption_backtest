
# Consumo Máximo de Riesgo Por Drawdown -----------------------------------

beta_strats <- list(names = c('Macromodel',
                              'Primas de Mercado',
                              'Value Relativo',
                              'Quality',
                              'Oportunidades'),
                    allocation = rep(.20,5),
                    retornos = rep(.07,5),
                    drawdowns = c(.15,
                                  .5,
                                  .35,
                                  .35,
                                  .50))

drawdown_total<- sum(beta_strats$drawdowns * beta_strats$allocation)
retorno_total <- sum(beta_strats$retornos * beta_strats$allocation)
mar_total <- round(retorno_total / drawdown_total,2)

# suponiendo 40/60 contra Alfa
mar_portafolio <- mar_total * .4 + 1 * 0.6
mar_hipotesis <- (mar_total *.4 + 0.6 * seq(0,1.5,0.1)) - (.08 / .5)
