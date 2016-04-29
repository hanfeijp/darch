bootstrapDataSet <- function(dataSet, unique, num = 0)
{
  numRows <- nrow(dataSet@data)
  bootstrapTrainingSamples <- sample(1:numRows,
    if (num > 0) num else numRows,
    replace = if (num > 0) F else T)
  
  if (unique && num == 0)
  {
    bootstrapTrainingSamples <- unique(bootstrapTrainingSamples)
  }
  
  numTrain <- length(bootstrapTrainingSamples)
  bootstrapValidationSamples <-
    which(!(1:numRows %in% bootstrapTrainingSamples))
  numValid <- length(bootstrapValidationSamples)
  
  # TODO validate sizes?
  dataSetValid <- dataSet
  dataSet@data <- dataSet@data[bootstrapTrainingSamples,, drop = F]
  dataSet@targets <- dataSet@targets[bootstrapTrainingSamples,, drop = F]
  dataSetValid@data <- dataSetValid@data[bootstrapValidationSamples,, drop = F]
  dataSetValid@targets <-
    dataSetValid@targets[bootstrapValidationSamples,, drop = F]
  
  futile.logger::flog.info(paste(
    "Bootstrapping is started with %s samples, bootstrapping results in",
    "%s training (%s unique) and %s validation samples for this run."),
    numRows, numTrain, numRows - numValid, numValid)
  
  return(list(dataSet, dataSetValid))
}