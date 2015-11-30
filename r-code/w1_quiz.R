# Coursera Finance Specialisation (U Michigan)
# M2 -- Risk and Return
# Week 1 - Quiz 1 -- Bond Valuation
#
# Joe Nguyen | 30 Nov, 2015

rm(list = ls())

# Change working directory
dirBase <- "/home/joe/Documents/01-coursera/02-finance"
dirWorking <- "/02-risk-and-return/r-code"
setwd(paste0(dirBase, dirWorking))

# Generic finance functions
source(paste0(dirBase, "/01-tvm/r-code/func_finance.R"))


## Question 1
# (5 points) A pure discount (or zero-coupon) government bond is issued today that promises to pay $10,000 in 5 years. If the current interest rate on similar bonds is 6%, what is the price of the bond? Recall that the compounding interval for bonds is 6 months.
fv <- 10e3
r <- 0.06 / halfsPerYear
n <- 5 * halfsPerYear
PV(fv, r, n)


## Question 2
# (5 points) For two otherwise identical coupon bonds, the one with the higher coupon will have a higher price.
# TRUE


## Question 3
# (5 points) Coupon bonds are selling at a premium relative to the par value when the yield to maturity is higher than the coupon rate.
# FALSE - premium if YTM is less than coupon rate


## Question 4
# (10 points) What is the yield to maturity (YTM) of a zero coupon bond with a face value of $1,000, current price of $770 and maturity of 4 years? Recall that the compounding interval is 6 months and the YTM, like all interest rates, is reported on an annualized basis. (No more than two decimals in the percentage but do not enter the % sign.)
fv <- 1e3
pv <- 770
n <- 4 * halfsPerYear
r <- YTM(fv, pv, n) * halfsPerYear
round(r * 100, 2)

# sanity check
PV(fv, r/halfsPerYear, n)


## Question 5
# (10 points) The government in the U.S. issues zero-coupon bonds up to one year maturity, but STRIPS are "manufactured" zero-coupon bonds with maturities up to 30 years. So, for example, a financial institution could first buy 500 30-year coupon bonds issued by the government that each pay $2 of coupon every six months. The institution could then sell the combined coupons totaling $1,000 as a separate zero-coupon bond for each maturity ranging from 6 months up to 30 years. This is a financial innovation that occurred decades ago in the face of volatile inflation and an increased demand for long-term zero coupon government bonds. Given this information, analyze the following statement: "The price of a long-term STRIP will typically be lower than that of a short-term STRIP."
#
# A STRIP (zero-coupon bond) eliminates volatility over the long term. The financial instituition absorbs the risk of changes in YTM. Since risk is reduced over the long term, the price is higher; pay a premium for the return guarantee.
# FALSE


## Question 6
# (10 points) Suppose Wolverine Steel Company wishes to issue a $100,000 bond with a maturity of 8 years to raise $81,110. The market requires a yield to maturity (YTM) of 11.5% for this company's borrowing/debt. How much coupon will the company have to pay every six months? (round to closest integer)
#
# $100e3 is future value to be paid by Wolverine to buyer, who now buys the bond for $81110.
fv <- 100e3
loan <- 81110
n <- 8 * halfsPerYear
r <- 0.115 / halfsPerYear

# Find C such that summation of compound interest-adjusted C's and fv ($100e3) equals loan ($81110)
# First subtract fv from loan
pv <- loan - PV(fv, r, n)

# Determine C to pay off remaining pv
round(annuity_c(0, pv, r, n), 0)


## Question 7
# (10 points) The prices of a bond with a higher fixed coupon rate will be less volatile than those of an otherwise identical bond with a lower fixed coupon rate.
#
# FALSE - coupon rate does have anything to do with volatility


## Question 8
# (15 points) Three years ago, you invested in a zero coupon bond with a face value of $1,000 that had a YTM of 11.5% and 5 years left until maturity. Today, that bond has a YTM of 6.0%. Due to a financial emergency, you are forced to sell the bond. What is your capital gain/loss, which is defined as the dollar gain/loss relative to the price of the bond when you bought it? Recall that the compounding interval is 6 months and the YTM, like all interest rates, is reported on an annualized basis. (round to closest integer)
fv <- 1e3
r0 <- 0.115 / halfsPerYear
n0 <- 5 * halfsPerYear

r1 <- 0.06 / halfsPerYear
n1 <- 2 * halfsPerYear

# Initial price paid for bond
p0 <- PV(fv, r0, n0); p0

# Value of bond today (with 2 years left to maturity)
p1 <- PV(fv, r1, n1); p1

# Capital gain
round(p1 - p0)
# This is actually good to sell because r1 < r0


## Question 9
# (15 points) Hard Spun Industries (HSI) has a project that it expects will produce a cash flow of $3.1 million in 11 years. To finance the project, the company needs to borrow $2.3 million today. The project will also produce intermediate cash flows of $230,000 per year that HSI can use to service coupon payments of $115,000 every six months. Based on the risk of this investment, market participants will require a 9.5% yield. If HSI wishes a maturity of 11 years (matching the arrival of the lump sum cash flow), what does the face value of the bond have to be? Recall that the compounding interval is 6 months and the YTM, like all interest rates, is reported on an annualized basis. (round to closest integer)
loan <- 2.3e6
fv <- 3.1
n <- 11 * halfsPerYear
r <- 0.095 / halfsPerYear
c <- 230e3
cp <- 115e3










