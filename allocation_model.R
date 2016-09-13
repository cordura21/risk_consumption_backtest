library(dplyr)

beta.alloc <- data.frame(strats = c( 'macromodel',
                                     'primas de mercado',
                                     'quality',
                                     'value relativo',
                                     'situaciones especiales'),
                         allocation = rep(.20,5),
                         allocated_time = rep(1,5))


beta.alloc$expected_return = c(.065,.065,.105,.088,.08)
beta.alloc$allocated_time <- c(1,.7,.5,.5,.20)
#beta.alloc$allocated_time <- c(1,1,1,1,1)

beta.expected.return <- sum(beta.alloc$allocation * beta.alloc$expected_return)
time_in_market <- sum(beta.alloc$allocated_time) / length(beta.alloc$strats)
beta.expected.return <- beta.expected.return * time_in_market + 
  beta.alloc$expected_return[1] * (1 - time_in_market)
print(paste("Retorno:",beta.expected.return * 100))
print(paste("Tiempo Invertido:",time_in_market ))
