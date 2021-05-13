selectTimeInterval <- function (x, Start, End) {
  y <-subset (x, as.numeric (x$TIMESTAMP)>= as.numeric(as.POSIXct (Start)) &
            as.numeric(x$TIMESTAMP)<=as.numeric(as.POSIXct (End)))
  return(y)
}