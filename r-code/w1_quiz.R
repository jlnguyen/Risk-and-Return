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

## ATTEMPT 2
# (5 points) A pure discount (or zero-coupon) government bond is issued today that promises to pay $10,000 in 15 years. If the current interest rate on similar bonds is 7%, what is the price of the bond?
faceVal <- 10e3
r <- 0.07 / halfsPerYear
n <- 15 * halfsPerYear
PV(faceVal, r, n)


## Question 2
# (5 points) For two otherwise identical coupon bonds, the one with the higher coupon will have a higher price.
# TRUE

## ATTEMPT 2
# (5 points) For two otherwise identical coupon bonds, the one with the higher rating will have a higher yield to maturity.
# Higher rating -> less risk means higher YTM
# TRUE
# CORRECT ANSWER - FALSE (rating = interest rate? If so, higher r means lowers price, which means lower YTM)


## Question 3
# (5 points) Coupon bonds are selling at a premium relative to the par value when the yield to maturity is higher than the coupon rate.
# FALSE - premium if YTM is less than coupon rate

## ATTEMPT 2
# (5 points) To calculate the yield to maturity for semiannual coupon bonds, you need to double the semiannual yield to arrive at the annualized figure.
# TRUE


## Question 4
# (10 points) What is the yield to maturity (YTM) of a zero coupon bond with a face value of $1,000, current price of $770 and maturity of 4 years? Recall that the compounding interval is 6 months and the YTM, like all interest rates, is reported on an annualized basis. (No more than two decimals in the percentage but do not enter the % sign.)
fv <- 1e3
pv <- 770
n <- 4 * halfsPerYear
r <- YTM(fv, pv, n) * halfsPerYear
round(r * 100, 2)

# sanity check
PV(fv, r/halfsPerYear, n)

## ATTEMPT 2
# (10 points) What is the yield to maturity (YTM) of a zero coupon bond with a face value of $1,000, current price of $940 and maturity of 9 years? 
faceVal <- 1e3
price <- 940
n <- 9 * halfsPerYear
r <- YTM(faceVal, price, n) * halfsPerYear
round(r * 100, 2)


# INCORRECT ATTEMPT 1
## Question 5
# (10 points) The government in the U.S. issues zero-coupon bonds up to one year maturity, but STRIPS are "manufactured" zero-coupon bonds with maturities up to 30 years. So, for example, a financial institution could first buy 500 30-year coupon bonds issued by the government that each pay $2 of coupon every six months. The institution could then sell the combined coupons totaling $1,000 as a separate zero-coupon bond for each maturity ranging from 6 months up to 30 years. This is a financial innovation that occurred decades ago in the face of volatile inflation and an increased demand for long-term zero coupon government bonds. Given this information, analyze the following statement: "The price of a long-term STRIP will typically be lower than that of a short-term STRIP."
#
# A STRIP (zero-coupon bond) eliminates volatility over the long term. The financial instituition absorbs the risk of changes in YTM. Since risk is reduced over the long term, the price is higher; pay a premium for the return guarantee.
# FALSE
#
# CORRECT ATTEMPT 2 - TRUE
# From investopedia, "Bond maturities can range from a day or less to more than 30 years. The longer the bond maturity, or duration, the greater the chances of adverse effects. Longer-dated bonds also tend to have lower liquidity. Because of these attributes, bonds with a longer time to maturity typically command a higher (coupon) interest rate."
#
# However, from reasoning in attempt 1, price of long-term STRIP will be less (than short-term STRIP) because it has more risk. More risk means lower price.


## Question 6
# (10 points) Suppose Wolverine Steel Company wishes to issue a $100,000 bond with a maturity of 8 years to raise $81,110. The market requires a yield to maturity (YTM) of 11.5% for this company's borrowing/debt. How much coupon will the company have to pay every six months? (round to closest integer)
#
# $100e3 is future value to be paid by Wolverine to buyer, who now buys the bond for $81110.
fv <- 100e3
price <- 81110
n <- 8 * halfsPerYear
r <- 0.115 / halfsPerYear

# Find C such that summation of compound interest-adjusted C's and fv ($100e3) equals issue price ($81110)
# First subtract fv from price
pv <- price - PV(fv, r, n)

# Determine C to pay off remaining pv
round(annuity_c(0, pv, r, n), 0)


## ATTEMPT 2
# (10 points) Suppose Wolverine Steel Company wishes to issue a $100,000 bond with a maturity of 6 years to raise $85,382. The market requires a yield to maturity (YTM) of 10.0% for this company's borrowing/debt. How much coupon will the company have to pay every six months?
faceVal <- 100e3
price <- 85382
n <- 6 * halfsPerYear
r <- 0.1 / halfsPerYear

pv <- price - PV(faceVal, r, n)
round(annuity_c(0, pv, r, n), 0)


# INCORRECT ATTEMPT 1
## Question 7
# (10 points) The prices of a bond with a higher fixed coupon rate will be less volatile than those of an otherwise identical bond with a lower fixed coupon rate.
#
# FALSE - coupon rate doesn't have anything to do with volatility
#
# CORRECT ATTEMPT 2 - TRUE
faceVal <- 1000
n <- 10
r <- 0.04
cr <- seq(0.01, 0.1, by = 0.005)
coupon <- cr * faceVal
price <- annuity_pv(coupon,r,n) + PV(faceVal,r,n)
plot(cr * 100, price)
#
# It appears bond price increases with coupon rate. We also know bond price varies inversely with market interest rate (r). If r is high, price is low, suggesting the bond is riskier (less people willing to buy). Therefore, a high price bond which has a high coupon rate is safer (less volatile). This is why it sells at a premium.


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
price <- 2.3e6
n <- 11 * halfsPerYear
r <- 0.095 / halfsPerYear
cfLast <- 3.1e6
cfInt <- 230e3
cpay <- 115e3

cfProfit <- cfInt - cpay
# pv (price) = annuity_pv(cpay) - annuity_pv(cfProfit) - PV(cfLast) - PV(faceVal)
# PV(faceVal) = rearrange equation above
# faceVal = FV(PV(faceVal))

faceValPv <- price - annuity_pv(cpay,r,n) + annuity_pv(cfProfit,r,n) + PV(cfLast,r,n)
faceVal <- FV(faceValPv,r,n); round(faceVal)

## ABOVE INCORRECT; Interpretation from discussion forum:
# Don't have to consider project cf (PCF = $3.1e6), we just have to ensure face value is less than PCF where company uses PCF to pay matured bond. By same token, don't have to consider cfInt in calculation. So,
# price = annuity_pv(cpay) + PV(faceVal)
# faceVal = FV(price - annuity_pv(cpay))
faceVal <- FV(price - annuity_pv(cpay,r,n), r,n); round(faceVal)


## Question 10
# (15 points) Five years ago, Highland, Inc. issued a corporate bond with an annual coupon of $5,500, paid at the rate of $2,750 every six months, and a maturity of 14 years. The par (face) value of the bond is $1,000,000. Recently, however, the company has run into some financial difficulty and has restructured its obligations. Today's coupon payment has already been paid, but the remaining coupon payments will be postponed until maturity. The postponed payments will accrue interest at an annual rate of 6.5% per year and will be paid as a lump sum amount at maturity along with the face value. The discount rate on the renegotiated bonds, now considered much riskier, has gone from 8.5% prior to the renegotiations to 12.5% per annum with the announcement of the restructuring. What is the price at which the new renegotiated bond should be selling today? Recall that the compounding interval is 6 months and the YTM, like all interest rates, is reported on an annualized basis. (round to closest integer)
cpay <- 2750
faceVal <- 1e6
r0 <- 0.085 / halfsPerYear
n0 <- 14 * halfsPerYear

r1 <- 0.125 / halfsPerYear
n1 <- 9 * halfsPerYear

r <- 0.065 / halfsPerYear

# Initial price
price0 <- annuity_pv(cpay,r0,n0) + PV(faceVal,r0,n0)

# Amount paid (up to today)
cpayPaid <- annuity_fv(cpay, r0, n0-n1)

# Remaining price (today)
priceRem <- FV(price0, r0, n0-n1) - cpayPaid

# Maturity value of remaining price
faceValRem <- FV(priceRem, r0, n1)

# FV of 6.5% interest-accuring coupons (at maturity) from today
lump <- annuity_fv(cpay, r, n1)

# New total bond face value
faceValNew <- faceValRem + lump

# New price today
priceNew <- PV(faceValNew, r1, n1); round(priceNew)


## ABOVE INCORRECT; Interpretation from discussion forum:
# Much simpler, don't need to compute faceValRem; i.e. don't need to consider cpayPaid (why not??). The new price is just PV(faceVal + lump)
# New total bond face value
faceValNew <- faceVal + lump

# New price today
priceNew <- PV(faceValNew, r1, n1); round(priceNew)


