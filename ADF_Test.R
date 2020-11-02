#===================================================================
# Data Manipulation
# Author: Jingyi Wu
# Date Modified: Apr 1 2020
#===================================================================

rm(list=ls())

library(dynamac)
library(urca)

#===================================================================
# import data
data_bi = read.csv("~/Desktop/DUKE/COURSES/SPRING2020/ECON656/econ656\ paper/Data/bi_integ.csv")
data_agg = read.csv("~/Desktop/DUKE/COURSES/SPRING2020/ECON656/econ656\ paper/Data/agg_integ.csv")

#===================================================================
# ADF TESTS
#===================================================================


# Aggregate Level
#===================================================================
# plotting - level
ts.plot(log(data_agg$ratio_agg))
ts.plot(log(data_agg$rex_agg))
ts.plot(log(data_agg$gdp_agg))

# ADF Test - level
t1_agg = ur.df(log(data_agg$ratio_agg), type = c("none"), lags = 1)
t2_agg = ur.df(log(data_agg$rex_agg), type = c("none"), lags = 1)
t3_agg = ur.df(log(data_agg$gdp_agg), type = c("drift"), lags = 1)

# plotting - difference
ts.plot(diff(log(data_agg$ratio_agg)))
ts.plot(diff(log(data_agg$rex_agg)))
ts.plot(diff(log(data_agg$gdp_agg)))

# ADF Test - first difference
t11_agg = ur.df(diff(data_agg$ratio_agg), type = c("none"), lags = 1)
t22_agg = ur.df(diff(data_agg$rex_agg), type = c("none"), lags = 1)
t33_agg = ur.df(diff(data_agg$gdp_agg), type = c("none"), lags = 1)


# Bilateral Level
#===================================================================
# plotting - level
ts.plot(log(data_bi$ratio_Singapore))
ts.plot(log(data_bi$ratio_China))
ts.plot(log(data_bi$ratio_US))
ts.plot(log(data_bi$ratio_Japan))
ts.plot(log(data_bi$ratio_Thailand))

ts.plot(log(data_bi$rex_Singapore))
ts.plot(log(data_bi$rex_China))
ts.plot(log(data_bi$rex_US))
ts.plot(log(data_bi$rex_Japan))
ts.plot(log(data_bi$rex_Thailand))

ts.plot(log(data_bi$gdp_Malaysia))
ts.plot(log(data_bi$gdp_Singapore))
ts.plot(log(data_bi$gdp_China))
ts.plot(log(data_bi$gdp_US))
ts.plot(log(data_bi$gdp_Japan))
ts.plot(log(data_bi$gdp_Thailand))

# ADF Test - level
# RATIO
t_ratio_Singapore = ur.df(log(data_bi$ratio_Singapore), type = c("none"), lags = 1)
t_ratio_China = ur.df(log(data_bi$ratio_China), type = c("none"), lags = 1)
t_ratio_US = ur.df(log(data_bi$ratio_US), type = c("none"), lags = 1)
t_ratio_Japan = ur.df(log(data_bi$ratio_Japan), type = c("none"), lags = 1)
t_ratio_Thailand = ur.df(log(data_bi$ratio_Thailand), type = c("none"), lags = 1)

tt_ratio_Singapore = ur.df(diff(log(data_bi$ratio_Singapore)), type = c("none"), lags = 1)
tt_ratio_China = ur.df(diff(log(data_bi$ratio_China)), type = c("none"), lags = 1)
tt_ratio_US = ur.df(diff(log(data_bi$ratio_US)), type = c("none"), lags = 1)
tt_ratio_Japan = ur.df(diff(log(data_bi$ratio_Japan)), type = c("none"), lags = 1)
tt_ratio_Thailand = ur.df(diff(log(data_bi$ratio_Thailand)), type = c("none"), lags = 1)

# REX
t_rex_Singapore = ur.df(log(data_bi$rex_Singapore), type = c("none"), lags = 1)
t_rex_China = ur.df(log(data_bi$rex_China), type = c("none"), lags = 1)
t_rex_US = ur.df(log(data_bi$rex_US), type = c("none"), lags = 1)
t_rex_Japan = ur.df(log(data_bi$rex_Japan), type = c("none"), lags = 1)
t_rex_Thailand = ur.df(log(data_bi$rex_Thailand), type = c("none"), lags = 1)

tt_rex_Singapore = ur.df(diff(log(data_bi$rex_Singapore)), type = c("none"), lags = 1)
tt_rex_China = ur.df(diff(log(data_bi$rex_China)), type = c("none"), lags = 1)
tt_rex_US = ur.df(diff(log(data_bi$rex_US)), type = c("none"), lags = 1)
tt_rex_Japan = ur.df(diff(log(data_bi$rex_Japan)), type = c("none"), lags = 1)
tt_rex_Thailand = ur.df(diff(log(data_bi$rex_Thailand)), type = c("none"), lags = 1)

# GDP
t_gdp_Malaysia = ur.df(log(data_bi$gdp_Malaysia), type = c("drift"), lags = 1)
t_gdp_Singapore = ur.df(log(data_bi$gdp_Singapore), type = c("drift"), lags = 1)
t_gdp_China = ur.df(log(data_bi$gdp_China), type = c("trend"), lags = 1)
t_gdp_US = ur.df(log(data_bi$gdp_US), type = c("drift"), lags = 1)
t_gdp_Japan = ur.df(log(data_bi$gdp_Japan), type = c("drift"), lags = 1)
t_gdp_Thailand = ur.df(log(data_bi$gdp_Thailand), type = c("drift"), lags = 1)

tt_gdp_Malaysia = ur.df(diff(log(data_bi$gdp_Malaysia)), type = c("none"), lags = 1)
tt_gdp_Singapore = ur.df(diff(log(data_bi$gdp_Singapore)), type = c("none"), lags = 1)
tt_gdp_China = ur.df(diff(log(data_bi$gdp_China)), type = c("drift"), lags = 1)
tt_gdp_US = ur.df(diff(log(data_bi$gdp_US)), type = c("none"), lags = 1)
tt_gdp_Japan = ur.df(diff(log(data_bi$gdp_Japan)), type = c("none"), lags = 1)
tt_gdp_Thailand = ur.df(diff(log(data_bi$gdp_Thailand)), type = c("none"), lags = 1)
