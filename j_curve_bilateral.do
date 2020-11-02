clear

* load data
insheet using /Users/killshadows/Desktop/DUKE/COURSES/SPRING2020/ECON656/paper/Data/bi_integ.csv

set obs 80
generate quarter = tq(1999q4) + _n-1
format %tq quarter

gen ln_ratio_singapore = ln(ratio_singapore)
gen ln_ratio_china = ln(ratio_china)
gen ln_ratio_us = ln(ratio_us)
gen ln_ratio_japan = ln(ratio_japan)
gen ln_ratio_thailand = ln(ratio_thailand)

gen ln_rex_singapore = ln(rex_singapore)
gen ln_rex_china = ln(rex_china)
gen ln_rex_us = ln(rex_us)
gen ln_rex_japan = ln(rex_japan)
gen ln_rex_thailand = ln(rex_thailand)

gen ln_gdp_malaysia = ln(gdp_malaysia)
gen ln_gdp_singapore = ln(gdp_singapore)
gen ln_gdp_china = ln(gdp_china)
gen ln_gdp_us = ln(gdp_us)
gen ln_gdp_japan = ln(gdp_japan)
gen ln_gdp_thailand = ln(gdp_thailand)

drop date
drop ratio_singapore ratio_china ratio_us ratio_japan ratio_thailand
drop rex_singapore rex_china rex_us rex_japan rex_thailand
drop gdp_malaysia gdp_singapore gdp_china gdp_us gdp_japan gdp_thailand

tsset quarter

*============================
* Singapore
*============================
* find ardl optimal lags
ardl ln_ratio_singapore ln_rex_singapore ln_gdp_malaysia ln_gdp_singapore  if tin(1999q4,2019q3), maxlags(5) aic maxcombs(150000) fast
matrix list e(lags)
// optimal lags (1 0 1 0)

* bound test
ardl ln_ratio_singapore ln_rex_singapore ln_gdp_malaysia ln_gdp_singapore if tin(1999q4,2019q3), ec1 lags(1 0 1 0)
estat ectest
// Pesaran, Shin, and Smith (2001) bounds test
//   | 10%              | 5%               | 1%               | p-value         
//   |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1)
//---+------------------+------------------+------------------+-----------------
// F |   2.797    3.859 |   3.346    4.505 |   4.575    5.920 |   0.004    0.020
// t |  -2.566   -3.445 |  -2.880   -3.791 |  -3.498   -4.454 |   0.001    0.011

// H0: no level relationship       F =  5.319
// Case 3                          t =  -4.408
// have cointegration

* save result of ecm
ardl ln_ratio_singapore ln_rex_singapore ln_gdp_malaysia ln_gdp_singapore if tin(1999q4,2019q3), ec1 lags(1 0 1 0)
esttab using output_singapore_ec.tex, t scalars(r2 r2_a ll) wide

* save result of ardl
ardl ln_ratio_singapore ln_rex_singapore ln_gdp_malaysia ln_gdp_singapore if tin(1999q4,2019q3), lags(1 0 1 0) regstore(ecreg)
esttab using output_singapore_ardl.tex, t scalars(r2 r2_a ll) wide
estimates restore ecreg
regress


* diagonostic test

* Breusch-Godfrey LM test for serial correlation
estat bgodfrey, lags(5)
// chi2(5) = 0.480 , p = 0.9928
// no serial correlation

* Jarque-Bera test for normality
predict residuals_singapore, r
sktest residuals_singapore
// chi2(2) = 3.19, p = 0.2031

* White's test for heteroskedasticity
estat imtest, white
// chi2(20) = 17.10, p = 0.6466
// no heteroskedasticity

* Ramsey RESET test fot functional form
estat ovtest
// F(3, 70) = 1.32, p = 0.2756
// no omitted variables


* Tests of CUSUM and CUSUMSQ for stability
cusum6 ln_ratio_singapore ln_rex_singapore ln_gdp_malaysia ln_gdp_singapore, cs(cusum) lw(lower) uw(upper)
drop cusum upper lower
// behave normally



//////need revision
*============================
* China
*============================
* find ardl optimal lags
ardl ln_ratio_china ln_rex_china ln_gdp_malaysia ln_gdp_china if tin(1999q4,2019q3), maxlags(5) aic maxcombs(150000) fast
matrix list e(lags)
// optimal lags (1 0 0 0)

* bound test
ardl ln_ratio_china ln_rex_china ln_gdp_malaysia ln_gdp_china if tin(1999q4,2019q3), ec1 lags(1 0 0 0)
estat ectest
// Pesaran, Shin, and Smith (2001) bounds test
//   | 10%              | 5%               | 1%               | p-value         
//   |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1)
//---+------------------+------------------+------------------+-----------------
// F |   2.805    3.857 |   3.354    4.500 |   4.583    5.907 |   0.006    0.031
// t |  -2.572   -3.453 |  -2.885   -3.796 |  -3.501   -4.456 |   0.001    0.015

// H0: no level relationship       F =  4.924
// Case 3                          t =  -4.295
// have cointegration

* save result of ecm
ardl ln_ratio_china ln_rex_china ln_gdp_malaysia ln_gdp_china if tin(1999q4,2019q3), ec1 lags(1 0 0 0)
esttab using output_china_ec.tex, t scalars(r2 r2_a ll) wide

* save result of ardl
ardl ln_ratio_china ln_rex_china ln_gdp_malaysia ln_gdp_china if tin(1999q4,2019q3), lags(1 0 0 0) regstore(ecreg)
esttab using output_china_ardl.tex, t scalars(r2 r2_a ll) wide
estimates restore ecreg
regress


* diagonostic test

* Breusch-Godfrey LM test for serial correlation
estat bgodfrey, lags(5)
// chi2(5) = 2.500 , p = 0.7765
// no serial correlation

* Jarque-Bera test for normality
predict residuals_china, r
sktest residuals_china
// chi2(2) = 4.03, p = 0.1332

* White's test for heteroskedasticity
estat imtest, white
// chi2(14) = 17.40, p = 0.2356
// no heteroskedasticity

* Ramsey RESET test fot functional form
estat ovtest
// F(3, 71) = 1.56, p = 0.2056
// no omitted variables


* Tests of CUSUM and CUSUMSQ for stability
cusum6 ln_ratio_china ln_rex_china ln_gdp_malaysia ln_gdp_china, cs(cusum) lw(lower) uw(upper)
drop cusum upper lower
// behave normally

*============================
* US
*============================

* find ardl optimal lags
ardl ln_ratio_us ln_rex_us ln_gdp_malaysia ln_gdp_us if tin(1999q4,2019q3), maxlags(5) aic maxcombs(150000) fast
matrix list e(lags)
// optimal lags (2 5 3 2)

* bound test
ardl ln_ratio_us ln_rex_us ln_gdp_malaysia ln_gdp_us if tin(1999q4,2019q3), ec1 lags(2 5 3 2)
estat ectest
// Pesaran, Shin, and Smith (2001) bounds test
//   | 10%              | 5%               | 1%               | p-value         
//   |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1)
//---+------------------+------------------+------------------+-----------------
// F |   2.721    3.899 |   3.270    4.579 |   4.518    6.095 |   0.000    0.003
// t |  -2.506   -3.373 |  -2.834   -3.737 |  -3.481   -4.442 |   0.000    0.001

// H0: no level relationship       F =  7.076
// Case 3                          t =  -5.305
// have cointegration

* save result of ecm
ardl ln_ratio_us ln_rex_us ln_gdp_malaysia ln_gdp_us if tin(1999q4,2019q3), ec1 lags(2 5 3 2)
esttab using output_us_ec.tex, t scalars(r2 r2_a ll) wide

* save result of ardl
ardl ln_ratio_us ln_rex_us ln_gdp_malaysia ln_gdp_us if tin(1999q4,2019q3), lags(2 5 3 2) regstore(ecreg)
esttab using output_us_ardl.tex, t scalars(r2 r2_a ll) wide
estimates restore ecreg
regress


* diagonostic test

* Breusch-Godfrey LM test for serial correlation
estat bgodfrey, lags(5)
// chi2(5) = 4.044 , p = 0.5432
// no serial correlation

* Jarque-Bera test for normality
predict residuals_us, r
sktest residuals_us
// chi2(2) = 0.61 , p = 0.7374

* White's test for heteroskedasticity
estat imtest, white
// chi2(74) = 75.00, p = 0.4457
// no heteroskedasticity

* Ramsey RESET test fot functional form
estat ovtest
// F(3, 56) = 0.34, p = 0.7955
// no omitted variables


* Tests of CUSUM and CUSUMSQ for stability
cusum6 ln_ratio_us ln_rex_us ln_gdp_malaysia ln_gdp_us, cs(cusum) lw(lower) uw(upper)
drop cusum upper lower
// behave normally


*============================
* Japan
*============================
* find ardl optimal lags
ardl ln_ratio_japan ln_rex_japan ln_gdp_malaysia ln_gdp_japan if tin(1999q4,2019q3), maxlags(5) aic maxcombs(150000) fast
matrix list e(lags)
// optimal lags (5 2 5 0)

* bound test
ardl ln_ratio_japan ln_rex_japan ln_gdp_malaysia ln_gdp_japan if tin(1999q4,2019q3), ec1 lags(5 2 5 0)
estat ectest
// Pesaran, Shin, and Smith (2001) bounds test
//   | 10%              | 5%               | 1%               | p-value         
//   |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1)
//---+------------------+------------------+------------------+-----------------
// F |   2.721    3.899 |   3.270    4.579 |   4.518    6.095 |   0.402    0.705
// t |  -2.506   -3.373 |  -2.834   -3.737 |  -3.481   -4.442 |   0.244    0.541

// H0: no level relationship       F =  1.518
// Case 3                          t =  -1.995
// NO cointegration

* save result of ardl
ardl ln_ratio_japan ln_rex_japan ln_gdp_malaysia ln_gdp_japan if tin(1999q4,2019q3), lags(5 2 5 0) regstore(ecreg)
esttab using output_japan_ardl.tex, t scalars(r2 r2_a ll) wide
estimates restore ecreg
regress

// did not do the test because of lack of cointegration
* diagonostic test

* Breusch-Godfrey LM test for serial correlation
estat bgodfrey, lags(5)
// chi2(5) = 10.786 , p = 0.0558
// no serial correlation

* Jarque-Bera test for normality
predict residuals_us, r
sktest residuals_us
// chi2(2) = 40.61, p = 0.7374

* White's test for heteroskedasticity
estat imtest, white
// chi2(74) = 1.21 , p = 0.5469
// no heteroskedasticity

* Ramsey RESET test fot functional form
estat ovtest
// F(3, 56) = 0.75, p = 0.5296
// no omitted variables

* Tests of CUSUM and CUSUMSQ for stability
cusum6 ln_ratio_japan ln_rex_japan ln_gdp_malaysia ln_gdp_japan, cs(cusum) lw(lower) uw(upper)
drop cusum upper lower
// behave normally

*============================
* Thailand
*============================

* find ardl optimal lags
ardl ln_ratio_thailand ln_rex_thailand ln_gdp_malaysia ln_gdp_thailand if tin(1999q4,2019q3), maxlags(5) aic maxcombs(150000) fast
matrix list e(lags)
// optimal lags (1 0 0 1)

* bound test
ardl ln_ratio_thailand ln_rex_thailand ln_gdp_malaysia ln_gdp_thailand if tin(1999q4,2019q3), ec1 lags(1 0 0 1)
estat ectest
// Pesaran, Shin, and Smith (2001) bounds test
//   | 10%              | 5%               | 1%               | p-value         
//   |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1) |    I(0)     I(1)
//---+------------------+------------------+------------------+-----------------
// F |   2.797    3.859 |   3.346    4.505 |   4.575    5.920 |   0.000    0.002
// t |  -2.566   -3.445 |  -2.880   -3.791 |  -3.498   -4.454 |   0.000    0.001


// H0: no level relationship       F =  7.283
// Case 3                          t =  -5.282
// have cointegration

* save result of ecm
ardl ln_ratio_thailand ln_rex_thailand ln_gdp_malaysia ln_gdp_thailand if tin(1999q4,2019q3), ec1 lags(1 0 0 1)
esttab using output_thailand_ec.tex, t scalars(r2 r2_a ll) wide

* save result of ardl
ardl ln_ratio_thailand ln_rex_thailand ln_gdp_malaysia ln_gdp_thailand if tin(1999q4,2019q3), lags(1 0 0 1) regstore(ecreg)
esttab using output_thailand_ardl.tex, t scalars(r2 r2_a ll) wide
estimates restore ecreg
regress


* diagonostic test

* Breusch-Godfrey LM test for serial correlation
estat bgodfrey, lags(5)
// chi2(5) = 4.751 , p = 0.4470
// no serial correlation

* Jarque-Bera test for normality
predict residuals_thailand, r
sktest residuals_thailand
// chi2(2) = 0.37, p = 0.8306

* White's test for heteroskedasticity
estat imtest, white
// chi2(20) = 23.75, p = 0.2536
// no heteroskedasticity

* Ramsey RESET test fot functional form
estat ovtest
// F(3, 70) = 0.85, p = 0.4699
// no omitted variables


* Tests of CUSUM and CUSUMSQ for stability
cusum6 ln_ratio_thailand ln_rex_thailand ln_gdp_malaysia ln_gdp_thailand, cs(cusum) lw(lower) uw(upper)
drop cusum upper lower
// behave normally



