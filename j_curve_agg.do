clear

* load data
insheet using /Users/killshadows/Desktop/DUKE/COURSES/SPRING2020/ECON656/paper/Data/agg_integ.csv

set obs 80
generate quarter = tq(1999q4) + _n-1
format %tq quarter

gen ln_ratio_agg = ln(ratio_agg)
gen ln_rex_agg = ln(rex_agg)
gen ln_gdp_malaysia = ln(malaysia)
gen ln_gdp_agg = ln(gdp_agg)

drop date ratio_agg rex_agg malaysia gdp_agg

* set time series feature
tsset quarter

* find ardl optimal lags
ardl ln_ratio_agg ln_rex_agg ln_gdp_malaysia ln_gdp_agg  if tin(1999q4,2019q3), maxlags(5) aic maxcombs(150000) fast
matrix list e(lags)
// optimal lags (1 0 0 5)

* bound test
ardl ln_ratio_agg ln_rex_agg ln_gdp_malaysia ln_gdp_agg if tin(1999q4,2019q3), ec1 lags(1 0 0 5)
estat ectest
// Pesaran, Shin, and Smith (2001) bounds test

//   | 10%              | 5%               | 1%               | p-value         
//   |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1)
//---+------------------+------------------+------------------+-----------------
// F |   2.770    3.880 |   3.321    4.543 |   4.564    6.008 |   0.000    0.000
// t |  -2.542   -3.417 |  -2.862   -3.771 |  -3.494   -4.454 |   0.000    0.000


// H0: no level relationship       F =  10.337
// Case 3                          t =  -6.258
// have cointegration

* save result of ecm
ardl ln_ratio_agg ln_rex_agg ln_gdp_malaysia ln_gdp_agg if tin(1999q4,2019q3), ec1 lags(1 0 0 5)
esttab using output_agg_ec.tex, t scalars(r2 r2_a ll) wide

* save result of ardl
ardl ln_ratio_agg ln_rex_agg ln_gdp_malaysia ln_gdp_agg if tin(1999q4,2019q3), lags(1 0 0 5) regstore(ecreg)
esttab using output_agg_ardl.tex, t scalars(r2 r2_a ll) wide
estimates restore ecreg
regress


* diagonostic test

* Breusch-Godfrey LM test for serial correlation
estat bgodfrey, lags(5)
// chi2(5) = 3.057, p = 0.6912
// no serial correlation

* Jarque-Bera test for normality
predict residuals, r
sktest residuals
// chi2(2) = 0.20, p = 0.9028

* White's test for heteroskedasticity
estat imtest, white
// chi2(54) = 49.29, p = 0.6565
// no heteroskedasticity

* Ramsey RESET test fot functional form
estat ovtest
// F(3, 62) = 0.92, p = 0.4349
// no omitted variables


* Tests of CUSUM and CUSUMSQ for stability
cusum6 ln_ratio_agg ln_rex_agg ln_gdp_malaysia ln_gdp_agg, cs(cusum) lw(lower) uw(upper)
drop cusum upper lower
// behave normally






