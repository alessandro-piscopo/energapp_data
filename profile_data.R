library(reshape2)

getwd()
setwd('~/Desktop/energapp/')
  
#households profiles gemeenten
dwelling_gemeente <- read.csv2("Energieverbruik_gemeente.csv")
dwelling_gemeente <- dwelling_gemeente[,-(3:10)]

names(dwelling_gemeente)[names(dwelling_gemeente)=="kWh.1"] <- "Appartement"
names(dwelling_gemeente)[names(dwelling_gemeente)=="kWh.2"] <- "Tussenwoning"
names(dwelling_gemeente)[names(dwelling_gemeente)=="kWh.3"] <- "Hoekwoning"
names(dwelling_gemeente)[names(dwelling_gemeente)=="kWh.4"] <- "Twee_onder_een_kap_woning"
names(dwelling_gemeente)[names(dwelling_gemeente)=="kWh.5"] <- "Vrijstaande_woning"

#keep only 2012 data
dwelling_gemeente$Perioden <- as.character(dwelling_gemeente$Perioden)
dwelling_gemeente$Perioden <- lapply(dwelling_gemeente$Perioden, function(x){replace(x, x == '2012*', 2012)})
dwelling_gemeente$Perioden <- as.factor(dwelling_gemeente$Perioden)
dwelling_gemeente_2012 <- dwelling_gemeente[dwelling_gemeente$Perioden == 2012, ]
dwelling_gemeente_2012 <- dwelling_gemeente_2012[,-416]

#reshape the data
names(dwelling_gemeente_2012) <- tolower(names(dwelling_gemeente_2012))
dwelling_gemeente_2012 <- dwelling_gemeente_2012[,-2]
#dwelling_2012[] <- lapply(dwelling_2012, function(x){replace(x, x == 'x', NA)})
dwelling_gemeente_2012$appartement <- as.numeric(as.character(dwelling_gemeente_2012$appartement))
dwelling_gemeente_2012$tussenwoning <- as.numeric(as.character(dwelling_gemeente_2012$tussenwoning))
dwelling_gemeente_2012$hoekwoning <- as.numeric(as.character(dwelling_gemeente_2012$hoekwoning))
dwelling_gemeente_2012$twee_onder_een_kap_woning <- as.numeric(as.character(dwelling_gemeente_2012$twee_onder_een_kap_woning))
dwelling_gemeente_2012$vrijstaande_woning <- as.numeric(as.character(dwelling_gemeente_2012$vrijstaande_woning))
dwelling_gemeente_2012$woningtype_onbekend <- as.numeric(as.character(dwelling_gemeente_2012$woningtype_onbekend))

dwelling_2012 <- dwelling_2012[,-7]

dwelling_gemeente_long <- melt(dwelling_gemeente_2012) 
names(dwelling_gemeente_long)[names(dwelling_gemeente_long)=="variable"] <- "dwel_type"
dwelling_gemeente_long$class_1 <- dwelling_gemeente_long$value*0.80
dwelling_gemeente_long$class_3 <- dwelling_gemeente_long$value*1.20
names(dwelling_gemeente_long)[names(dwelling_gemeente_long)=="value"] <- "class_2"

names(dwelling_gemeente_long)[names(dwelling_gemeente_long)=="regio.s"] <- "gemeente"

#month ratios
months <- c(0.098708012, 0.088233745, 0.088320883, 0.076185035, 0.077002078, 0.072956267, 0.0729658, 0.071290619, 0.078958574, 0.085901746, 0.090042709, 0.099434531)
month_names <- c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')
month_ratios <- data.frame(month_names, months)
