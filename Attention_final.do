*------------------Attention Centrality---------------------------
////Table 1. Summary Statistics
clear
use Data1.dta
winsor2 LnLsize LBM LnLFirmAge LLev LGrowth LInsthold1 LnLreport LROA1 LCAR LCAR_abs LCR LVolatility, replace cuts(1 99)  
tabstat degree eigenvector LnLsize LBM LnLFirmAge LLev LGrowth LInsthold1 LnLreport LROA1 LSOE LCAR LCAR_abs LCR LVolatility, s(N mean sd min max p10 p25 p50 p75 p90) f(%12.3f) c(s)

////Appendix Table 1. Summary Statistics
tabstat between close, s(N mean sd min max p10 p25 p50 p75 p90) f(%12.3f) c(s)


////Table 2. Centrality Persistence: Portfolio Methods
clear
use portfolio.dta
*1.degree
bys qaindex : astile Ldegree6 = Ldegree if Ldegree!=0, nq(5) 
replace Ldegree6=0 if Ldegree==0 
gen low1=1 if Ldegree6==0
replace low1=0 if Ldegree6==5 
gen low2=1 if Ldegree6==1
replace low2=0 if Ldegree6==5 
*pooled average and difference
tab Ldegree6,sum(degree)
ttest degree, by(low1)
ttest degree, by(low2) 
*mean of sorting var
tab Ldegree6,sum(Ldegree)
ttest Ldegree, by(low1)
ttest Ldegree, by(low2)

clear
use portfolio.dta 
*2.eigenvector
bys qaindex : astile Leigenvector6 = Leigenvector if Leigenvector!=0, nq(5) 
replace Leigenvector6=0 if Leigenvector==0 
gen low1=1 if Leigenvector6==0
replace low1=0 if Leigenvector6==5 
gen low2=1 if Leigenvector6==1
replace low2=0 if Leigenvector6==5 
*pooled average and difference
tab Leigenvector6,sum(eigenvector)
ttest eigenvector, by(low1)
ttest eigenvector, by(low2) 
*mean of sorting var
tab Leigenvector6,sum(Leigenvector)
ttest Leigenvector, by(low1)
ttest Leigenvector, by(low2) 

////Appendix Table 2. Centrality Persistence: Portfolio Methods
clear
use portfolio.dta 
*1.between
bys qaindex : astile Lbetween6 = Lbetween if Lbetween!=0, nq(5) 
replace Lbetween6=0 if Lbetween==0 
gen low1=1 if Lbetween6==0
replace low1=0 if Lbetween6==5 
gen low2=1 if Lbetween6==1
replace low2=0 if Lbetween6==5
*pooled average and difference
tab Lbetween6,sum(between)
ttest between, by(low1)
ttest between, by(low2) 
*mean of sorting var
tab Lbetween6,sum(Lbetween)
ttest Lbetween, by(low1)
ttest Lbetween, by(low2) 

clear
use portfolio.dta 
*2.close
bys qaindex : astile Lclose6 = Lclose if Lclose!=0, nq(5) 
replace Lclose6=0 if Lclose==0 
gen low1=1 if Lclose6==0
replace low1=0 if Lclose6==5
gen low2=1 if Lclose6==1
replace low2=0 if Lclose6==5 
*pooled average and difference
tab Lclose6,sum(close)
ttest close, by(low1)
ttest close, by(low2) 
*mean of sorting var
tab Lclose6,sum(Lclose)
ttest Lclose, by(low1)
ttest Lclose, by(low2) 


////Table 3. Centrality Persistence: Panel Regressions
clear
use AR.dta
reghdfe degree Ldegree LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe eigenvector Leigenvector LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 

////Appendix Table 3. Centrality Persistence: Panel Regressions
reghdfe between Lbetween LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe close Lclose LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 


////Table 4. Determinants of Centrality: Panel Regressions
clear
use Data1.dta
winsor2 LnLsize LBM LnLFirmAge LLev LGrowth LInsthold1 LnLreport LROA1 LCAR LCAR_abs LCR LVolatility, replace cuts(1 99)  
*Panel A. Fundamental Characteristics
reghdfe degree LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe eigenvector LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
*Panel B. Information Uncertainty
reghdfe degree LCAR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe degree LCAR_abs LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe degree LCR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe degree LVolatility LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe eigenvector LCAR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe eigenvector LCAR_abs LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe eigenvector LCR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe eigenvector LVolatility LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 

////Appendix Table 4. Determinants of Centrality: Panel Regressions
*Panel A. Fundamental Characteristics
reghdfe between LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe close LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
*Panel B. Information Uncertainty
reghdfe between LCAR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe between LCAR_abs LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe between LCR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe between LVolatility LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe close LCAR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe close LCAR_abs LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe close LCR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 
reghdfe close LVolatility LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd qaindex) 

////Appendix Table 5. Determinants of Centrality: Fama-MacBeth Regressions
clear
use Data1.dta
winsor2 LnLsize LBM LnLFirmAge LLev LGrowth LInsthold1 LnLreport LROA1 LCAR LCAR_abs LCR LVolatility, replace cuts(1 99) 
*Panel A. Fundamental Characteristicsxtset Stkcd qaindex
asreg degree LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg eigenvector LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg between LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg close LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
*Panel B. Information Uncertainty: Degree and Eigenvector
asreg degree LCAR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg degree LCAR_abs LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg degree LCR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg degree LVolatility LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg eigenvector LCAR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg eigenvector LCAR_abs LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg eigenvector LCR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg eigenvector LVolatility LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
*Panel C. Information Uncertainty: Between and Close
asreg between LCAR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg between LCAR_abs LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg between LCR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg between LVolatility LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg close LCAR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg close LCAR_abs LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg close LCR LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg close LVolatility LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first


////Table 5. Lead-Lag Effects: Panel Regressions
*grouped
clear
use group.dta
*1.degree
bys ind dayindex: astile Ldegree5 = Ldegree if Ldegree!=0, nq(5) 
replace Ldegree5=0 if Ldegree==0 
gen Ldegree5_com=1 if Ldegree5==0|Ldegree5==1
replace Ldegree5_com=2 if Ldegree5==2
replace Ldegree5_com=3 if Ldegree5==3
replace Ldegree5_com=4 if Ldegree5==4
replace Ldegree5_com=5 if Ldegree5==5
*2.eigenvector
bys ind dayindex: astile Leigenvector5 = Leigenvector if Leigenvector!=0, nq(5) 
replace Leigenvector5=0 if Leigenvector==0 
gen Leigenvector5_com=1 if Leigenvector5==0|Leigenvector5==1
replace Leigenvector5_com=2 if Leigenvector5==2
replace Leigenvector5_com=3 if Leigenvector5==3
replace Leigenvector5_com=4 if Leigenvector5==4
replace Leigenvector5_com=5 if Leigenvector5==5
*3.between
bys ind dayindex: astile Lbetween5 = Lbetween if Lbetween!=0, nq(5) 
replace Lbetween5=0 if Lbetween==0 
gen Lbetween5_com=1 if Lbetween5==0|Lbetween5==1
replace Lbetween5_com=2 if Lbetween5==2
replace Lbetween5_com=3 if Lbetween5==3
replace Lbetween5_com=4 if Lbetween5==4
replace Lbetween5_com=5 if Lbetween5==5
*4.close
bys ind dayindex: astile Lclose5 = Lclose if Lclose!=0, nq(5) 
replace Lclose5=0 if Lclose==0 
gen Lclose5_com=1 if Lclose5==0|Lclose5==1
replace Lclose5_com=2 if Lclose5==2
replace Lclose5_com=3 if Lclose5==3
replace Lclose5_com=4 if Lclose5==4
replace Lclose5_com=5 if Lclose5==5
save lead_lag.dta,replace

*gen average return 
*1.degree
clear
use lead_lag.dta
keep Stkcd dayindex Ldegree5 ind Dretwd
bys ind dayindex Ldegree5:egen Dretwd_md=mean( Dretwd)
keep if Ldegree5==5
keep dayindex Dretwd_md ind
duplicates drop 
save Dretwd_md.dta,replace
*2.eigenvector
clear
use lead_lag.dta
keep Stkcd dayindex Leigenvector5 ind Dretwd
bys ind dayindex Leigenvector5:egen Dretwd_me=mean( Dretwd)
keep if Leigenvector5==5
keep dayindex Dretwd_me ind
duplicates drop
save Dretwd_me.dta,replace
*3.between
clear
use lead_lag.dta
keep Stkcd dayindex Lbetween5 ind Dretwd
bys ind dayindex Lbetween5:egen Dretwd_mb=mean( Dretwd)
keep if Lbetween5==5
keep dayindex Dretwd_mb ind
duplicates drop
save Dretwd_mb.dta,replace
*4.close
clear
use lead_lag.dta
keep Stkcd dayindex Lclose5 ind Dretwd
bys ind dayindex Lclose5:egen Dretwd_mc=mean( Dretwd)
keep if Lclose5==5
keep dayindex Dretwd_mc ind
duplicates drop
save Dretwd_mc.dta,replace

*regression
clear
use group.dta
merge m:1 ind dayindex using Dretwd_md.dta,nogen keep(1 3)  
merge m:1 ind dayindex using Dretwd_me.dta,nogen keep(1 3)
merge m:1 ind dayindex using Dretwd_mb.dta,nogen keep(1 3)
merge m:1 ind dayindex using Dretwd_mc.dta,nogen keep(1 3)
*1.degree
reghdfe FDretwd Dretwd_md LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd dayindex ) vce(cluster Stkcd dayindex) 
reghdfe FDretwd Dretwd_md LDretwd LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd dayindex ) vce(cluster Stkcd dayindex) 
*2.eigenvector
reghdfe FDretwd Dretwd_me LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd dayindex ) vce(cluster Stkcd dayindex) 
reghdfe FDretwd Dretwd_me LDretwd LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd dayindex ) vce(cluster Stkcd dayindex) 

////Appendix Table 6. Lead-Lag Effects: Panel Regressions 
*1.between
reghdfe FDretwd Dretwd_mb LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd dayindex ) vce(cluster Stkcd dayindex) 
reghdfe FDretwd Dretwd_mb LDretwd LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd dayindex ) vce(cluster Stkcd dayindex) 
*2.close
reghdfe FDretwd Dretwd_mc LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd dayindex ) vce(cluster Stkcd dayindex) 
reghdfe FDretwd Dretwd_mc LDretwd LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd dayindex ) vce(cluster Stkcd dayindex) 

////Appendix Table 7. Lead-Lag Effects: Fama-MacBeth Regressions
////*Table4 lead_lag effects 
clear
use daily_reg.dta
*1.degree
xtset Stkcd dayindex
asreg FDretwd Dretwd_md LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg FDretwd Dretwd_md LDretwd LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
*2.eigenvector
asreg FDretwd Dretwd_me LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg FDretwd Dretwd_me LDretwd LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
*3.between
asreg FDretwd Dretwd_mb LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg FDretwd Dretwd_mb LDretwd LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
*4.close
asreg FDretwd Dretwd_mc LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first
asreg FDretwd Dretwd_mc LDretwd LnLsize LBM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev, fmb newey(2) first


////Table 6. Lead-Lag Effects: Time Series Regressions
clear
use lead_lag.dta
*1.degree
local industries "A B C1 C2 C3 C4 D E F G H I J K L M N O P Q R S"
local i = 1
foreach industry in `industries' {
    keep if ind == "`industry'"
	*regression
	bys Ldegree5_com dayindex: egen LDretwd_mean=mean(LDretwd)
	bys Ldegree5_com dayindex: egen Dretwd_mean=mean(Dretwd)
	bys Ldegree5_com dayindex: egen FDretwd_mean=mean(FDretwd)
	keep Ldegree5_com dayindex LDretwd_mean Dretwd_mean FDretwd_mean
	duplicates drop
	drop if Ldegree5_com==.
	
	capture reshape wide (LDretwd_mean Dretwd_mean FDretwd_mean), i(dayindex) j(Ldegree5_com)
    local degree_file = "T5_d`i'.doc"
	
	capture reg Dretwd_mean1 LDretwd_mean5 
	capture outreg2 using `degree_file'.doc, tstat bracket bdec(3) tdec(2) e(r2_a) replace
	capture reg Dretwd_mean1 LDretwd_mean5 LDretwd_mean1
	capture outreg2 using `degree_file'.doc, tstat bracket bdec(3) tdec(2) e(r2_a) append

    local i = `i' + 1
	
    use lead_lag.dta,replace
}

*2.eigenvector
local industries "A B C1 C2 C3 C4 D E F G H I J K L M N O P Q R S"
local i = 1
foreach industry in `industries' {
    keep if ind == "`industry'"
	*regression
	bys Leigenvector5_com dayindex: egen LDretwd_mean=mean(LDretwd)
	bys Leigenvector5_com dayindex: egen Dretwd_mean=mean(Dretwd)
	bys Leigenvector5_com dayindex: egen FDretwd_mean=mean(FDretwd)
	keep Leigenvector5_com dayindex LDretwd_mean Dretwd_mean FDretwd_mean  
	duplicates drop
	drop if Leigenvector5_com==.
	
	capture reshape wide (LDretwd_mean Dretwd_mean FDretwd_mean), i(dayindex) j(Leigenvector5_com)
	
    local eigenvector_file = "T5_e`i'.doc"
	
	capture reg Dretwd_mean1 LDretwd_mean5 
	capture outreg2 using `eigenvector_file'.doc, tstat bracket bdec(3) tdec(2) e(r2_a) replace
	capture reg Dretwd_mean1 LDretwd_mean5 LDretwd_mean1
	capture outreg2 using `eigenvector_file'.doc, tstat bracket bdec(3) tdec(2) e(r2_a) append

    local i = `i' + 1
	
    use lead_lag.dta,replace
}

////Appendix Table 8. Lead-Lag Effects: Time Series Regressions 
*1.between
local industries "A B C1 C2 C3 C4 D E F G H I J K L M N O P Q R S"
local i = 1
foreach industry in `industries' {
    keep if ind == "`industry'"
	*regression
	bys Lbetween5_com dayindex: egen LDretwd_mean=mean(LDretwd)
	bys Lbetween5_com dayindex: egen Dretwd_mean=mean(Dretwd)
	bys Lbetween5_com dayindex: egen FDretwd_mean=mean(FDretwd)
	keep Lbetween5_com dayindex LDretwd_mean Dretwd_mean FDretwd_mean 
	duplicates drop
	drop if Lbetween5_com==.
	
	capture reshape wide (LDretwd_mean Dretwd_mean FDretwd_mean), i(dayindex) j(Lbetween5_com)
	
    local between_file = "T5_b`i'.doc"
	
	capture reg Dretwd_mean1 LDretwd_mean5 
	capture outreg2 using `between_file'.doc, tstat bracket bdec(3) tdec(2) e(r2_a) replace
	capture reg Dretwd_mean1 LDretwd_mean5 LDretwd_mean1
	capture outreg2 using `between_file'.doc, tstat bracket bdec(3) tdec(2) e(r2_a) append

    local i = `i' + 1
	
    use lead_lag.dta,replace
}

*2.close
local industries "A B C1 C2 C3 C4 D E F G H I J K L M N O P Q R S"
local i = 1
foreach industry in `industries' {
    keep if ind == "`industry'"
	*regression
	bys Lclose5_com dayindex: egen LDretwd_mean=mean(LDretwd)
	bys Lclose5_com dayindex: egen Dretwd_mean=mean(Dretwd)
	bys Lclose5_com dayindex: egen FDretwd_mean=mean(FDretwd)
	keep Lclose5_com dayindex LDretwd_mean Dretwd_mean FDretwd_mean  
	duplicates drop
	drop if Lclose5_com==.
	
	capture reshape wide (LDretwd_mean Dretwd_mean FDretwd_mean), i(dayindex) j(Lclose5_com)
	
    local close_file = "T5_c`i'.doc"
	
	capture reg Dretwd_mean1 LDretwd_mean5 
	capture outreg2 using `close_file'.doc, tstat bracket bdec(3) tdec(2) e(r2_a) replace
	capture reg Dretwd_mean1 LDretwd_mean5 LDretwd_mean1
	capture outreg2 using `close_file'.doc, tstat bracket bdec(3) tdec(2) e(r2_a) append

    local i = `i' + 1
	
    use lead_lag.dta,replace
}


////Table 7. Information Implications of Analysts’ Forecast Reports: Panel Regressions 
clear
use Data2.dta
winsor2 FReport Lnsize BM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LLev,replace cut(1 99)
reghdfe FReport degree Lnsize BM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd) 
reghdfe FReport eigenvector Lnsize BM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd) 

////Appendix Table 9. Information Implications of Analysts’ Forecast Reports: Panel Regressions 
reghdfe FReport between Lnsize BM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd) 
reghdfe FReport close Lnsize BM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd) 


////Table 8. Information Implications of Idiosyncratic Volatility: Panel Regressions 
*Idiosyncratic Volatility
clear
use IVOL_prep.dta
statsby _b, by(St qaindex): reg r Risk SMB HML  
save coefficient, replace

clear
use IVOL_prep.dta
merge m:1 St qaindex using coefficient, nogen keep(1 3)
g e = r - (_b_cons + _b_R*Risk + _b_SM*SM + _b_H*H)

bys St qaindex: egen n = count(day)
bys St qaindex: egen sd = sd(e)
g IVOL = n^0.5*sd
keep St qaindex IVOL
duplicates drop
save IVOL.dta, replace

*regression
clear
use Data3.dta
winsor2 FIVOL Lnsize BM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LLev, replace cuts(1 99)
reghdfe FIVOL degree Lnsize BM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd) 
reghdfe FIVOL eigenvector Lnsize BM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd) 

////Appendix Table 10. Information Implications of Idiosyncratic Volatility: Panel Regressions 
reghdfe FIVOL between Lnsize BM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd) 
reghdfe FIVOL close Lnsize BM LnLFirmAge LGrowth LInsthold1 LnLreport LROA1 LSOE LLev,absorb( Stkcd qaindex ) vce(cluster Stkcd) 

