% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_spi.R
\name{plot_spi}
\alias{plot_spi}
\title{plot spi}
\usage{
plot_spi(grid, zoo_grid)
}
\arguments{
\item{grid}{grid obj}

\item{zoo_grid}{zoo grid obj}
}
\value{
plot of SPI
}
\description{
plot spi
}
\examples{
data(grid)
data(skink_grid)
grid$zone[1:8] <- 2
plot_spi(grid, skink_grid)
}
