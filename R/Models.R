library(INLA)
library(dplyr)
library(plyr)
library(sqldf)
library(rgdal)
library(spdep)
library(RColorBrewer)

# Set the working directory  

setwd("E:/Catalunya COVID/")

# Save the files "region_data.rda", "regions.rda", and "regions.W.rda" in this directory, and load them 

load("region_data.rda")
load("regions.rda")
load("regions.W.rda")

# Define models

model_list=list()
model_list[[1]]=as.formula(Cases~Temp+Prec+Sun+Wind)
model_list[[2]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind)
model_list[[3]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind+PopDensity)
model_list[[4]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind+PopDensity+
                             f(region, model="bym",graph=regions.W) + 
                             f(date_num_str, model="rw2") +
                             f(date_num_unstr, model="iid"))
model_list[[5]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind+PopDensity+
                             f(region, model="bym",graph=regions.W) + 
                             f(week_num_str, model="rw2") +
                             f(week_num_unstr, model="iid") +
                             f(region_week_num, model="iid"))
model_list[[6]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind+PopDensity+
                             f(region, model="bym",graph=regions.W) + 
                             f(week_num_str, model="rw2") +
                             f(week_num_unstr, model="iid") +
                             f(region_int, model="iid", group=week_num_str_int,
                               control.group=list(model="rw2")))
model_list[[7]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind+PopDensity+
                             f(region, model="bym",graph=regions.W) + 
                             f(week_num_str, model="rw2") +
                             f(week_num_unstr, model="iid") +
                             f(week_num_unstr_int, model="iid", group=region_int,
                               control.group=list(model="besag", graph=regions.W)))
model_list[[8]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind+PopDensity+
                             f(region, model="bym",graph=regions.W) + 
                             f(week_num_str, model="rw2") +
                             f(week_num_unstr, model="iid") +
                             f(region_int, 
                               model="besag", graph=regions.W, 
                               group=week_num_str_int,
                               control.group=list(model="rw2")))
model_list[[9]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind+PopDensity+
                             f(region, model="bym",graph=regions.W) + 
                             f(date_num_str, model="rw2") +
                             f(date_num_unstr, model="iid") +
                             f(region_date_num, model="iid"))
model_list[[10]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind+PopDensity+
                             f(region, model="bym",graph=regions.W) + 
                             f(date_num_str, model="rw2") +
                             f(date_num_unstr, model="iid") +
                             f(region_int, model="iid", group=date_num_str_int,
                               control.group=list(model="rw2")))
model_list[[11]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind+PopDensity+
                             f(region, model="bym",graph=regions.W) + 
                             f(date_num_str, model="rw2") +
                             f(date_num_unstr, model="iid") +
                             f(date_num_unstr_int, model="iid", group=region_int,
                               control.group=list(model="besag", graph=regions.W)))
model_list[[12]]=as.formula(Cases~offset(logExpected)+Temp+Prec+Sun+Wind+PopDensity+
                             f(region, model="bym",graph=regions.W) + 
                             f(date_num_str, model="rw2") +
                             f(date_num_unstr, model="iid") +
                             f(region_int, 
                               model="besag", graph=regions.W, 
                               group=date_num_str_int,
                               control.group=list(model="rw2")))
# Fit models

for (i in 1:length(model_list)){
  model_name=paste0("Model",i)
  model_formula=model_list[[i]]
  assign(model_name,inla(model_formula,
                         family="poisson",
                         control.compute = list(dic=T),
                         quantiles=c(0.025, 0.05, 0.1, 0.5, 0.9, 0.95, 0.975),
                         data=region_data))
  save(list=model_name,file=paste0("Model",i,".rda"))
}

