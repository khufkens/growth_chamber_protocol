MergeSelect_ch1 <- function (begin, stop) {
  ### balances files
  ch.files_ch1 <- list.files(path="data/balances/", pattern='chamber1') 
  #add data/balances to all elements in the list
  ch.files_ch1 <- paste("data/balances/",ch.files_ch1, sep="")
  
  #apply the function fread to all elements in the object ch.files_ch1 and put that into a list 
  #fread read all the elements
  raw_weight_ch1 <- lapply(ch.files_ch1, fread)
  #create a dataframe from a list
  raw_weight_ch1 <- rbindlist(raw_weight_ch1,fill=TRUE)
  #convert timestamp from text to posixct that can be read as a date and not a character
  raw_weight_ch1$TIMESTAMP <-as.POSIXct(raw_weight_ch1$TIMESTAMP,format="%Y-%m-%d %H:%M:%S")
  
  ####temperature files 
  # read file and convert first colunm as a date
  temp_data <- fread ("data/thermocouples/CR3000_2chambres_Table2.dat", skip=4)
  temp_data$V1 <- as.POSIXct(temp_data$V1,format="%d/%m/%Y %H:%M")
  
  # idem with the file containing calib1 data
  temp_calib1 <- fread ("data/thermocouples/CR3000_2chambres_Table2_calib1.csv",
                                   skip = 4)
  
  temp_calib1$V1 <- as.POSIXct(temp_calib1$V1,format="%Y/%m/%d %H:%M")
  #merge both previous files into one
  all_temp <- bind_rows(temp_calib1,temp_data)
  #skip first row and read the next one
  col_headings <- c(colnames(fread("data/thermocouples/CR3000_2chambres_Table2.dat",nrows=1,skip=1)))
  #use col_headings to name colunms
  colnames(all_temp) <- col_headings
  
  print(all_temp)
  
  ###select balances and temp on specific dates
  #select ch1 temperature 
  temp_ch1 <- select(all_temp,TIMESTAMP,Temp_scale1_Avg,Temp_scale2_Avg,Temp_scale3_Avg,Temp_scale4_Avg,Temp_scale5_Avg,Temp_scale6_Avg,Temp_scale7_Avg,Temp_scale8_Avg)
  select_temp_ch1 <- selectTimeInterval(temp_ch1, Start=begin, End=stop)
  
  #select balances ch1
  select_raw_weight_ch1 <- selectTimeInterval(raw_weight_ch1,Start=begin, End=stop)
  
  # merge files temp and weight by selecting the temperature with the closest timestamp to weight timestamp
  setkey(select_raw_weight_ch1,"TIMESTAMP")
  setkey(select_temp_ch1,"TIMESTAMP")
  select_raw_weight_temp_ch1 <- select_temp_ch1[select_raw_weight_ch1,roll="nearest"]
  y <-select_raw_weight_temp_ch1
  return(y)
}