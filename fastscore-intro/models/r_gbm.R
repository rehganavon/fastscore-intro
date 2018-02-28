# fastscore.input: gbm_input
# fastscore.output: gbm_output

library(jsonlite)
library(caret)
library(gbm)

# GBM model

begin <- function(){
  # load model
  load("r_attachment/gbmFit.RData", envir = globalenv())
}

action <- function(datum){
  # score data
  predictorsNames <- c("make",
                       "fuelType",
                       "aspiration",
                       "numDoors",
                       "bodyStyle",
                       "driveWheels",
                       "engineLocation",
                       "wheelBase",
                       "length",
                       "width",
                       "height",
                       "curbWeight",
                       "engineType",
                       "numCylinders",
                       "engineSize",
                       "fuelSystem",
                       "bore",
                       "stroke",
                       "compressionRatio",
                       "horsepower",
                       "peakRPM",
                       "cityMPG",
                       "highwayMPG",
                       "price")
  score <- predict(object = gbmFit, as.data.frame(unclass(datum))[,predictorsNames])
  emit(score)
}
