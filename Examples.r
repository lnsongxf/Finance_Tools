
# Define the Assets to be loaded

MyAssets<-rbind(
  c("DekaFonds_CF","2859","8",14.047,F),
  c("UmweltInvest_CF","100087282","8",3.683,F),
  c("ChancePlus","101597066","8",0.489,F),   
  c("DKB_ETF","122054829","8",1.4653,F),
  c("Merck","1622","6",5,F),
  c("RockwellC","11210","21",7,T),
  c("Paypal","121455745","40",13,T),
  c("Unilever","931553","44",22,F)
)

# Define the Starting
date.F="01.10.2016"

Var(MyAssets,date.F)

Density(MyAssets,date.F)