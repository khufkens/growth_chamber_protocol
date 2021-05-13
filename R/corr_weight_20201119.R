library ("data.table")
library("plyr")
library("dplyr")
library("ggplot2")
library("tidyr")
source("R/selectTimeInterval.R")
source("R/MergeSelect_ch1.R")
source("R/MergeSelect_ch2.R")
source("R/Weight_correction_ch1.R")
source("R/Weight_correction_ch2.R")

############ CALIBRATION
### tidy data
# Merge weight and temperature files and select dates
calib1 <- MergeSelect_ch1(begin = "2020-01-20 15:45:00",stop = "2020-01-26 23:59:59")
#idem for chamber 2
calib2 <- MergeSelect_ch2(begin = "2020-01-31 13:30:00",stop = "2020-02-04 12:00:00")

# Extract the correction factor of each balance

nb_balances=16
coeff_a <- data.frame(matrix(nrow = 1, ncol=nb_balances)) 
colnames(coeff_a) <- c("a_scale1", "a_scale2", "a_scale3", "a_scale4", "a_scale5", "a_scale6", "a_scale7", "a_scale8", "a_scale9", "a_scale10", "a_scale11", "a_scale12", "a_scale13", "a_scale14", "a_scale15", "a_scale16")

for(i in 1:8){
  scale <- lm(paste("calib1$scale",i,"~calib1$Temp_scale",i,"_Avg",sep = ""))
  coeff_a[1,i] <-scale$coefficients[2]
}

for(i in 9:nb_balances){
  scale <- lm(paste("calib2$scale",i,"~calib2$Temp_scale",i,"_Avg",sep = ""))
  coeff_a[1,i] <-scale$coefficients[2]
}


# Merge weight and temperature files and select dates
E2CH1 <- MergeSelect_ch1(begin = "2020-01-29 16:30:00",stop = "2020-03-09 14:30:00")
#idem for chamber 2
E2CH2 <- MergeSelect_ch2(begin = "2020-02-05 10:30:00",stop = "2020-03-16 07:00:00")

# Correct raw weight using calibration data and create a new dataframe with corrected weight

E2CH1_corrW <- Weight_correction_ch1(E2CH1)
E2CH2_corrW <- Weight_correction_ch2(E2CH2)

# Replace fake data (when pots were out for WALZ measurement for example/ criteria is weight below 1kg) by NA
E2CH1_corrW[E2CH1_corrW < 1] <- NA
E2CH2_corrW[E2CH2_corrW < 1] <- NA

# Créer un nouvel objet dans lequel les colonnes sont basculées en lignes avec TIMESTAMP, poids (=corrW) et nom balances(=var)
E2CH1_corrW_plot <- gather(E2CH1_corrW,"scale","corrW",1:8)
E2CH2_corrW_plot <- gather(E2CH2_corrW,"scale","corrW",1:8)
E2_BALANCE <- bind_rows(E2CH1_corrW_plot,E2CH2_corrW_plot)

ggplot(E2_BALANCE,aes(TIMESTAMP,corrW))+ 
  geom_point(aes(color = scale))+
 xlim(as.POSIXct("2020-02-29"),as.POSIXct("2020-03-01"))

#write.csv(E2CH1_corrW,file="C:/Users/Camille/Dropbox/CR-FNRS/ChamberExp/R_repo_climchamber/output/corrected_weight_ch1_E2CH1.csv")

#write.csv(E2CH2_corrW,file="C:/Users/Camille/Dropbox/CR-FNRS/ChamberExp/R_repo_climchamber/output/corrected_weight_ch1_E2CH2.csv")

E2_BALANCE <-E2_BALANCE %>% 
  group_by(scale) %>%
  mutate(transpiredweight = corrW - lag(corrW))

#remove data when manipulations are ongoing, chmabers are open, etc /script in progress

selection_threshold1 = 0.01   ## value 
selection_threshold2 = -0.1
E2_corr_plot <-E2_corr_plot %>% 
  mutate(transpiredflag_boolean = if_else(transpiredweight >selection_threshold1 ,0,1,missing=NULL)) %>%
  mutate(fauxtranspiredflag_boolean = if_else(transpiredweight <selection_threshold2 , 0,1,missing=NULL)) %>%
  mutate(realtrans = fauxtranspiredflag_boolean * transpiredflag_boolean * transpiredweight)
  

