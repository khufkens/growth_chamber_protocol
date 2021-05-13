Weight_correction_ch2 <- function (x) {
  
  E2CH2 <- mutate(E2CH2,coefB_scale9=scale9-(coeff_a$a_scale9*Temp_scale9_Avg))
  E2CH2_corr <- mutate(E2CH2,scale9_corr=(coeff_a$a_scale9*22)+coefB_scale9)
  
  E2CH2 <- mutate(E2CH2,coefB_scale10=scale10-(coeff_a$a_scale10*Temp_scale10_Avg))
  E2CH2_corr <- mutate(E2CH2_corr,scale10_corr=(coeff_a$a_scale10*22)+E2CH2$coefB_scale10)
  
  E2CH2 <- mutate(E2CH2,coefB_scale11=scale11-(coeff_a$a_scale11*Temp_scale11_Avg))
  E2CH2_corr <- mutate(E2CH2_corr,scale11_corr=(coeff_a$a_scale11*22)+E2CH2$coefB_scale11)
  
  E2CH2 <- mutate(E2CH2,coefB_scale12=scale12-(coeff_a$a_scale12*Temp_scale12_Avg))
  E2CH2_corr <- mutate(E2CH2_corr,scale12_corr=(coeff_a$a_scale12*22)+E2CH2$coefB_scale12)
  
  E2CH2 <- mutate(E2CH2,coefB_scale13=scale13-(coeff_a$a_scale13*Temp_scale13_Avg))
  E2CH2_corr <- mutate(E2CH2_corr,scale13_corr=(coeff_a$a_scale13*22)+E2CH2$coefB_scale13)
  
  E2CH2 <- mutate(E2CH2,coefB_scale14=scale14-(coeff_a$a_scale14*Temp_scale14_Avg))
  E2CH2_corr <- mutate(E2CH2_corr,scale14_corr=(coeff_a$a_scale14*22)+E2CH2$coefB_scale14)
  
  E2CH2 <- mutate(E2CH2,coefB_scale15=scale15-(coeff_a$a_scale15*Temp_scale15_Avg))
  E2CH2_corr <- mutate(E2CH2_corr,scale15_corr=(coeff_a$a_scale15*22)+E2CH2$coefB_scale15)
  
  E2CH2 <- mutate(E2CH2,coefB_scale16=scale16-(coeff_a$a_scale16*Temp_scale16_Avg))
  E2CH2_corr <- mutate(E2CH2_corr,scale16_corr=(coeff_a$a_scale16*22)+E2CH2$coefB_scale16)
  


  E2CH2_corr_only <- E2CH2_corr %>% select(matches("_corr"))
  E2CH2_corr_only$TIMESTAMP <- E2CH2_corr$TIMESTAMP
  
  y <-E2CH2_corr_only
  
  return(y)
}
