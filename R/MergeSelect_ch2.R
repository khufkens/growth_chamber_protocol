MergeSelect_ch2 <- function (begin, stop) {
  ### balances files
  ch.files_ch2 <- list.files(path="data/balances/", pattern='chamber2') 
  #add data/balances to all elements in the list
  ch.files_ch2 <- paste("data/balances/",ch.files_ch2, sep="")
  #apply the function fread to all elements in the object ch.files_ch1 and put that into a list 
  #fread read all the elements
  raw_weight_ch2 <- lapply(ch.files_ch2, fread)
  #create a dataframe from a list
  raw_weight_ch2 <- rbindlist(raw_weight_ch2,fill=TRUE)
  #convert timestamp from text to posixct that can be read as a date and not a character
  raw_weight_ch2$TIMESTAMP <-as.POSIXct(raw_weight_ch2$TIMESTAMP,format="%Y-%m-%d %H:%M:%S")
  
  ####temperature files 
  # read file and convert first colunm as a date
  temp_data <-fread ("data/thermocouples/CR3000_2chambres_Table2.dat",skip=4)
  temp_data$V1 <- as.POSIXct(temp_data$V1,format="%d/%m/%Y %H:%M")

  #skip first row and read the next one
  col_headings <- c(colnames(fread("data/thermocouples/CR3000_2chambres_Table2.dat",nrows=1,skip=1)))
  #use col_headings to name colunms
  names(temp_data) <- col_headings
  
  ###select balances and temp on specific dates
  #select ch1 temperature 
  temp_ch2 <- select(temp_data,TIMESTAMP,Temp_scale9_Avg,Temp_scale10_Avg,Temp_scale11_Avg,Temp_scale12_Avg,Temp_scale13_Avg,Temp_scale14_Avg,Temp_scale15_Avg,Temp_scale16_Avg)
  select_temp_ch2 <- selectTimeInterval(temp_ch2,Start=begin, End=stop)
  #select balances ch1
  select_raw_weight_ch2 <- selectTimeInterval(raw_weight_ch2,Start=begin, End=stop)
  
  # merge files temp and weight by selecting the temperature with the closest timestamp to weight timestamp
  setkey(select_raw_weight_ch2,"TIMESTAMP")
  setkey(select_temp_ch2,"TIMESTAMP")
  select_raw_weight_temp_ch2 <- select_temp_ch2[select_raw_weight_ch2,roll="nearest"]
  y <-select_raw_weight_temp_ch2
  return(y)
}