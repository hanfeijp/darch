% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/minimizeAutoencoder.R
\name{minimizeAutoencoder}
\alias{minimizeAutoencoder}
\title{Conjugate gradient for a autoencoder network}
\usage{
minimizeAutoencoder(darch, trainData, targetData,
  cg.length = getParameter(".cg.length"),
  dropout = getParameter(".darch.dropout"),
  dropConnect = getParameter(".darch.dropout.dropConnect"),
  matMult = getParameter(".matMult"), debugMode = getParameter(".debug"),
  ...)
}
\arguments{
\item{darch}{A instance of the class \code{\linkS4class{DArch}}.}

\item{trainData}{The training data matrix.}

\item{targetData}{The labels for the training data.}

\item{cg.length}{Numbers of line search}

\item{dropout}{See \code{darch.dropout} parameter of \code{\link{darch}}.}

\item{dropConnect}{See \code{darch.dropout.dropConnect} parameter of
\code{\link{darch}}.}

\item{matMult}{Matrix multiplication function, internal parameter.}

\item{debugMode}{Whether debug mode is enabled, internal parameter.}

\item{...}{Further parameters.}
}
\value{
The trained \code{\linkS4class{DArch}} object.
}
\description{
This function trains a \code{\linkS4class{DArch}} autoencoder network with the 
conjugate gradient method.
}
\details{
This function is built on the basis of the code from G. Hinton et. al.
(http://www.cs.toronto.edu/~hinton/MatlabForSciencePaper.html - last visit 
2016-04-30) for the fine tuning of deep belief nets. The original code is 
located in the files 'backpropclassify.m', 'CG_MNIST.m' and 
'CG_CLASSIFY_INIT.m'. 
It implements the fine tuning for a classification net with backpropagation
using a direct translation of the \code{\link{minimize}} function from C. 
Rassmussen (available at http://www.gatsby.ucl.ac.uk/~edward/code/minimize/ 
- last visit 2016-04-30) to R.

\code{minimizeAutoencoder} supports dropout but does not use the weight
update function as defined via the \code{darch.weightUpdateFunction}
parameter of \code{\link{darch}}, so that weight decay, momentum etc. are not
supported.
}
\examples{
\dontrun{
data(iris)
model <- darch(Species ~ ., iris, c(6,10,2,10,6), darch.isClass = F,
 preProc.params = list(method=c("center", "scale")),
 darch.numEpochs = 20, darch.batchSize = 6, darch.unitFunction = tanhUnit
 darch.fineTuneFunction = "minimizeAutoencoder")
}
}
\seealso{
\code{\link{darch}}, \code{\link{fineTuneDArch}}

Other fine-tuning functions: \code{\link{backpropagation}},
  \code{\link{minimizeClassifier}},
  \code{\link{rpropagation}}
}

