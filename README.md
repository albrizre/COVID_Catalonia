# The effect of the environment on COVID-19: a spatio-temporal study in Catalonia (Spain)

The files in this repository allow fitting the spatio-temporal models discussed in the paper "The impact of modelling choices on modelling outcomes: a spatio-temporal study of the association between COVID-19 spread and environmental conditions in Catalonia (Spain)".

The following files are included in the R folder:

- Models.R: R code to fit the 12 spatio-temporal models compared in the paper. The models are implemented with the `INLA` package.
- region_data.rda: `data.frame` including all the variables involved in the models (response variable, covariates, and spatio-temporal auxiliary variables). 
- regions.rda: `SpatialPolygonsDataFrame` object representing the regions of Catalonia.
- regions.W.rda: `matrix` representing the neighbourhood matrix for the regions of Catalonia.
