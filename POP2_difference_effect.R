# compute difference effect

pop2_B10_semMM_cons <- subset(pop2_B10, MM_RAW %in% c(“consistent”, “semMM_RAW”))

pop2_B10_semMM_cons$TW <- ifelse(pop2_B10_semMM_cons$Time>200 & pop2_B10_semMM_cons$Time <400,"250-400" ,ifelse(pop2_B10_semMM_cons$Time>400 & pop2_B10_semMM_cons$Time <600,"400-600" ,ifelse(pop2_B10_semMM_cons$Time>600 & pop2_B10_semMM_cons$Time <750,"600-750" ,ifelse(pop2_B10_semMM_cons$Time>750 & pop2_B10_semMM_cons$Time <850,"750-850",NA ) ) ) )

# add info from excel file about relational distance, grammatical category, prime relative frequency, source quality (LSA?) 


# mean response time for each electrode, each ppt, each time window each trigger_code) pop2_B10_cons_means  
pop2_B10_cons_means <- subset(pop2_B10_semMM_cons, MM_RAW %in% c("consistent") )
pop2_B10_cons_means <-  pop2_B10_cons_means %>% group_by(Subject,Trigger_code,Electrode,TW) %>% summarise(mean_cons_Voltage = mean(Voltage))
pop2_B10_cons_means$Cons_tc <- pop2_B10_cons_means$Trigger_code

# mean SEMM response time for each electrode, each ppt, each time, each trigger_code)
pop2_B10_semMM_means <- subset(pop2_B10_semMM_cons, MM_RAW %in% c("semMM_RAW") )
pop2_B10_semMM_means <-  pop2_B10_semMM_means %>% group_by(Subject,Trigger_code,Electrode,TW) %>% summarise(Voltage = mean(Voltage))


# add cons_equivalent_Trigger_code
pop2_B10_semMM_means$Cons_tc <- 100 + (pop2_B10_semMM_means$Trigger_code%%10)*10 + pop2_B10_semMM_means$Trigger_code%%10


# merge
pop2_B10_semMM_means <- left_join(pop2_B10_semMM_means, pop2_B10_cons_means, by="Cons_tc")


# substract
pop2_B10_semMM_means$difference <- pop2_B10_semMM_means$Voltage - pop2_B10_semMM_means$mean_cons_Voltage
