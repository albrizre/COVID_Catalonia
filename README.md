# Model COVID-19 data with INLA

The files in this repository allow fitting the spatio-temporal models discussed in the paper "The impact of modelling choices on modelling outcomes: a spatio-temporal study of the association between COVID-19 spread and environmental conditions in Catalonia (Spain)".

The following files are included in the R folder:

- Models.R: R code to fit the 12 spatio-temporal modelling structures proposed in the paper.
- region_data.rda: `data.frame` including all the variable involved in the models (response variable, covariates, and spatio-temporal auxiliary variables). 
- regions.rda: `SpatialPolygonsDataFrame` object representing the regions of Catalonia.
- regions.W.rda: `matrix` representing the neighbourhood matrix for the regions.
