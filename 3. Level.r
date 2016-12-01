# Plotting of the Portfolio density:: PortDensity()

Density<-function(MyAssets,date.F,rettype="logDiff"){
  # Input:
  ## MyAssets
  ## A matrix with the following structure
  ## MyAssets[i,] gives the row for ith asset
  ## MyAssets[i,]=c("Name","secu","boerse_id",weight,convert)
  ## I.e. with two Assets: DekaFonds with 14.074 shares and 21 Rockwell assets
  ## MyAssets<-rbind(c("DekaFonds_CF","2859","8",14.047,F),c("RockwellC","11210","21",7,T))
  #
  ## date.F
  ## The Start Date for the Portfolio
  #
  ## rettype
  ## "LagOperator", is defined as a backshift operator: L(X_t)=X_t-1
  ## "Delta", is defined as the time difference: Delta(X_t)=X_t-X_t-1
  ## "relDiff", is defined as the relative change in time: relDiff(X_t)=(X_t-X_t-1)/X_t-1
  ## "logDiff", is defined as the log difference in time: logDiff(X_t)=log(X_t/X_t-1)
  #
  # Output:
  ## A plot of the empirical density against the normal pdf
  port<-PortConstruct(MyAssets,date.F)
  ret<- TimeCont(port$level,mode=rettype)
  plot(density(ret))
  
  m<-mean(ret)
  std<-sd(ret)
  x<-seq(from=-0.1,0.1,by=0.001)
  curve(dnorm(x, mean=m, sd=std), 
        col="darkblue", lwd=2, add=TRUE, yaxt="n")
}


# Estimating the Value at risk:: VaR()


VaR<-function(MyAssets,date.F,p=0.99,rettype="logDiff"){
  # Input:
  ## MyAssets
  ## A matrix with the following structure
  ## MyAssets[i,] gives the row for ith asset
  ## MyAssets[i,]=c("Name","secu","boerse_id",weight,convert)
  ## I.e. with two Assets: DekaFonds with 14.074 shares and 21 Rockwell assets
  ## MyAssets<-rbind(c("DekaFonds_CF","2859","8",14.047,F),c("RockwellC","11210","21",7,T))
  #
  ## date.F
  ## The Start Date for the Portfolio
  #
  ## p
  ## gives the quantile for the VaR. i.e. p=0.99-> quantile(0.01,...) 
  #
  # Output:
  ## the VaR for the asset or portfolio
  port<-PortConstruct(MyAssets,date.F)
  ret<- TimeCont(port$level,mode=rettype)
  VaR<-quantile(ret,1-p)*port$level[length(port$level)]
  return(VaR)
}

# Hier ist geplant, dass die VaR function deutlich ausgebaut wird und mittels sampling tail risks darstellen kann. Idee: man sampled zusätzlich noch aus einer Verteilung mit long tails oder aus einer nach links verschobenen normalveteilung