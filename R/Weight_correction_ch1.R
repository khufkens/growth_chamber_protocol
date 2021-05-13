Weight_correction_ch1 <- function (x) {
  
  E2CH1 <- mutate(E2CH1,coefB_scale1=scale1-(coeff_a$a_scale1*Temp_scale1_Avg))
  E2CH1_corr <- mutate(E2CH1,scale1_corr=(coeff_a$a_scale1*22)+coefB_scale1)
  
  E2CH1 <- mutate(E2CH1,coefB_scale2=scale2-(coeff_a$a_scale2*Temp_scale2_Avg))
  E2CH1_corr <- mutate(E2CH1_corr,scale2_corr=(coeff_a$a_scale2*22)+E2CH1$coefB_scale2)
  
  E2CH1 <- mutate(E2CH1,coefB_scale3=scale3-(coeff_a$a_scale3*Temp_scale3_Avg))
  E2CH1_corr <- mutate(E2CH1_corr,scale3_corr=(coeff_a$a_scale3*22)+E2CH1$coefB_scale3)
  
  E2CH1 <- mutate(E2CH1,coefB_scale4=scale4-(coeff_a$a_scale4*Temp_scale4_Avg))
  E2CH1_corr <- mutate(E2CH1_corr,scale4_corr=(coeff_a$a_scale4*22)+E2CH1$coefB_scale4)
  
  E2CH1 <- mutate(E2CH1,coefB_scale5=scale5-(coeff_a$a_scale5*Temp_scale5_Avg))
  E2CH1_corr <- mutate(E2CH1_corr,scale5_corr=(coeff_a$a_scale5*22)+E2CH1$coefB_scale5)
  
  E2CH1 <- mutate(E2CH1,coefB_scale6=scale6-(coeff_a$a_scale6*Temp_scale6_Avg))
  E2CH1_corr <- mutate(E2CH1_corr,scale6_corr=(coeff_a$a_scale6*22)+E2CH1$coefB_scale6)
  
  E2CH1 <- mutate(E2CH1,coefB_scale7=scale7-(coeff_a$a_scale7*Temp_scale7_Avg))
  E2CH1_corr <- mutate(E2CH1_corr,scale7_corr=(coeff_a$a_scale7*22)+E2CH1$coefB_scale7)
  
  E2CH1 <- mutate(E2CH1,coefB_scale8=scale8-(coeff_a$a_scale8*Temp_scale8_Avg))
  E2CH1_corr <- mutate(E2CH1_corr,scale8_corr=(coeff_a$a_scale8*22)+E2CH1$coefB_scale8)
  

  E2CH1_corr_only <- E2CH1_corr %>% select(matches("_corr" ))
  E2CH1_corr_only$TIMESTAMP <- E2CH1_corr$TIMESTAMP
  
  y <-E2CH1_corr_only
  
  return(y)
}
