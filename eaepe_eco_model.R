# IO-SFC MODEL (BASED ON MODEL PC) + ECOSYSTEM

# Created by Marco Veronese Passarella

# Version: 7 June 2024; revised: 11 June 2024

### PREPARE THE ENVIRONMENT ################################################################################

#Clear Environment
rm(list=ls(all=TRUE))

#Clear Plots
if(!is.null(dev.list())) dev.off()

#Clear Console
cat("\014")

#Set directory/folder
#setwd("C:/Users/...")

#set number of periods
nPeriods = 90

#Set number of scenarios
nScenarios = 1 

#Set number of industries ***
nIndustries = 2

### SET THE COEFFICIENTS (EXOGENOUS VARIABLES AND PARAMETERS) ################################################################################

alpha10 = 0.8 #Autonomous component of propensity to consume out of income
alpha11 = 8 #Interest rate elasticity of propensity to consume out of income (minus sign)
alpha2=0.4 #Propensity to consume out of wealth
w = 0.4 #Uniform wage rate
mu = 0.875 #Uniform mark-up
pr1 = 1 #Labour productivity in industry 1
pr2 = 1 #Labour productivity in industry 2
lambda0 = 0.635 #Autonomous share of bills
lambda1 = 5 #Elasticity of bills demand to interest rate
lambda2 = 0.01 #Elasticity of bills demand to yd/v
theta=0.2 #Tax rate on income
r_bar=matrix(data=0.025,nrow=nScenarios,ncol=nPeriods) #Interest rate as policy instrument
beta1_c_bar=0.50 #Household consumption share of product 1
beta2_c_bar=0.50 #Household consumption share of product 2
beta1_g_bar=0.48 #Government consumption share of product 1
beta2_g_bar=0.52 #Government consumption share of product 2
a11 = 0.11 #Quantity of product 1 necessary to produce one unit of product 1
a12 = 0.12 #Quantity of product 1 necessary to produce one unit of product 2
a21 = 0.21 #Quantity of product 2 necessary to produce one unit of product 1
a22 = 0.22 #Quantity of product 2 necessary to produce one unit of product 2

#Tip: try 0.12, 0.12, 0.20, 0.20 for unit prices

### CREATE VARIABLES AND ATTRIBUTE INITIAL VALUES ################################################################################

#Use 'array' function to create 3-dimension variables
x=array(data=0,dim=c(nScenarios,nPeriods,nIndustries)) #Gross output by industry (real)
d=array(data=0,dim=c(nScenarios,nPeriods,nIndustries)) #Demand by industry (real)
beta_c=array(data=0,dim=c(nScenarios,nPeriods,nIndustries)) #Real consumption composition
beta_g=array(data=0,dim=c(nScenarios,nPeriods,nIndustries)) #Real government expenditure composition
p=array(data=1,dim=c(nScenarios,nPeriods,nIndustries)) #Unit prices

#Create matrix of coefficients
A=matrix(data=0,nrow=nIndustries,ncol=nIndustries) #2D matrix of technical coefficients
I = diag(x=1, nrow=nIndustries, ncol=nIndustries) #2D diagonal matrix
A4=array(data=0,dim=c(nScenarios,nPeriods,nIndustries,nIndustries)) #4D matrix of technical coefficients

#Other 2-dimension variables
alpha1=matrix(data=alpha10-alpha11*r_bar,nrow=nScenarios,ncol=nPeriods) #Propensity to consume out of income
b_cb=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Government bills held by Central Bank
b_h=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Government bills held by households
b_s=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Government bills supplied by government
h_h=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Cash money held by households
h_s=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Cash money supplied by central bank
r=matrix(data=r_bar,nrow=nScenarios,ncol=nPeriods) #Interest rate on government bills
t=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Taxes
v=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Households wealth
yd=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Disposable income of households
cons=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Consumption (real)
g=matrix(data=20,nrow=nScenarios,ncol=nPeriods) #Government expenditure (real)
y=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Value of net output (GDP)
p_c=matrix(data=1,nrow=nScenarios,ncol=nPeriods) #Average price for the consumers
p_g=matrix(data=1,nrow=nScenarios,ncol=nPeriods) #Average price for the government
infl=matrix(data=1,nrow=nScenarios,ncol=nPeriods) #Inflation tax (see Godley and Lavoie, 9.2.4 and 9.3.1)

### Ecosystem variables and coefficients ################################################################################

#Variables
x_mat = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Production of material goods 
mat = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Extracted matter  
rec = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Recycled socio-economic stock  
dis = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Discarded socioeconomic stock            
kh = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Socio-economic stock       
en = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Total energy required for production
ren = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Renewable energy
nen = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Non-renewable energy                         
co2_cum = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Cumulative emissions
wa = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Waste by industry
temp = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Atmospheric temperature 
k_m=matrix(data=6000,nrow=nScenarios,ncol=nPeriods) #Matter reserves
conv_m=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Conversion of matter resources into reserves
res_m=matrix(data=388889,nrow=nScenarios,ncol=nPeriods) #Matter resources
k_e=matrix(data=37000,nrow=nScenarios,ncol=nPeriods) #Energy reserves
conv_e=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Conversion of energy resources into reserves
res_e=matrix(data=542000,nrow=nScenarios,ncol=nPeriods) #Energy resources
dc = array(data=0,dim=c(nScenarios,nPeriods,nIndustries)) #Stock of durable goods by industry/product
emis = matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Annual emissions by industry
cen=matrix(data=0,nrow=nScenarios,ncol=nPeriods) #Carbon mass of energy
o2= matrix(data=emis-cen,nrow=nScenarios,ncol=nPeriods) #Mass of oxygen 

#Coefficients
rho_dis = 0.2 #Recycling rate
beta_e = 0.07 #C=2 intensity of non-renewable energy sources
tcre=0.0001 #Transient climate response to cumulative carbon emissions
fnc=0.5 #Non-CO2 fraction of total anthropocentric forcing
sigma_m=0.0005 #Conversion rate of matter resources into reserves
car=3.67 #Coefficient converting Gt of carbon into Gt of CO2
sigma_e=0.003 #Conversion rate of energy resources into reserves
mu_mat = matrix(data=c(0.4,0.6),nrow=nIndustries,ncol=1) #Material intensity coefficients by industry
zeta_dc = matrix(data=c(0.015,0.025),nrow=nIndustries,ncol=1) #Percentages of discarded socio-economic stock by industry
eps_en = matrix(data=c(4,6),nrow=nIndustries,ncol=1) #Energy intensity coefficients by industry                                          
eta_en = matrix(data=c(0.13,0.15),nrow=nIndustries,ncol=1) #Shares of renewable energy in total energy by industry       
alpha12=matrix(data=4,nrow=nScenarios,ncol=nPeriods) #Temperature elasticity of propensity to consume out of income

### RUN THE MODEL ################################################################################

#DEFINE THE LOOPS

#Choose scenario
for (j in 1:nScenarios){
  
  #Define time loop
  for (i in 2:nPeriods){
    
    #Define iterations
    for (iterations in 1:100){
      
      
      #DEFINE THE SYSTEM OF EQUATIONS        

      
      ## A) Define the matrix of technical coefficients ####
      
      #4D matrix of technical coefficients
      A4[j,i,,]=c(a11,a21,a12,a22)                   
      
      #2D matrix of technical coefficients
      A = A4[j,i,,]          
      
      
      ## B) Define consumption shares ####
      
      #Household real consumption share of product 1 - eq. 12.1
      beta_c[j,i,1]=beta1_c_bar
      
      #Household real consumption share of product 2 - eq. 12.2
      beta_c[j,i,2]=beta2_c_bar
      
      #Government real consumption share of product 1 - eq. 13.1
      beta_g[j,i,1]=beta1_g_bar
      
      #Government real consumption share of product 2 - eq. 13.2
      beta_g[j,i,2]=beta2_g_bar
      
      
      ## C) Define input-output structure ####
      
      #Real final demand vector by industry - eq. 14
      d[j,i,] = beta_c[j,i,]*cons[j,i] + beta_g[j,i,]*g[j,i]
      
      #Real gross output by industry  - eq. 15
      x[j,i,] = solve(I-A) %*% d[j,i,]
      
      #Value of net output (GDP)  - eq. 1.A
      y[j,i] = t(p[j,i,]) %*% d[j,i,]

      
      ## D) Set prices ####
      
      #Set unit price of output of industry 1 - eq. 16.1
      p[j,i,1] = (w/pr1) + (p[j,i,1]*A[1] + p[j,i,2]*A[2])*(1 + mu) 
      
      #Set unit price of output of industry 2 - eq. 16.2  
      p[j,i,2] = (w/pr2) + (p[j,i,1]*A[3] + p[j,i,2]*A[4])*(1 + mu) 
      
      #Average price for the consumers - eq. 17
      p_c[j,i] = t(p[j,i,]) %*% beta_c[j,i,]
      
      #Average price for the government - eq. 18
      p_g[j,i] = t(p[j,i,]) %*% beta_g[j,i,]
      
      
      ## E) Households' behaviour ####
      
      #Disposable income - eq. 2
      yd[j,i] = y[j,i] - t[j,i] + r[j,i-1]*b_h[j,i-1]
      
      #Wealth accumulation - eq. 4 
      v[j,i] = v[j,i-1] + (yd[j,i] - p_c[j,i]*cons[j,i])
      
      #Real consumption function with no monetary illusion - eq. 5.A.1 
      cons[j,i] = alpha1[j,i]*((yd[j,i]/p_c[j,i])-infl[j,i]) + alpha2*v[j,i-1]/p_c[j,i]
      
      #Inflation tax for households - eq. 5.A.1
      infl[j,i] = ((p_c[j,i]-p_c[j,i-1])/p_c[j,i-1])*(v[j,i-1]/p_c[j,i])
      
      #Endogenous propensity to consume out of income  - eq. 19
      #alpha1[j,i] = alpha10 - alpha11*r[j,i]
      
      
      ## F) Portfolio equations ####
      
      #Demand for cash money - eq. 6
      h_h[j,i] = v[j,i] - b_h[j,i]
      
      #Demand for government bills - eq. 7
      b_h[j,i] = v[j,i]*(lambda0 + lambda1*r[j,i] - lambda2*(yd[j,i]/v[j,i]))
      
      
      ## G) Government ####
      
      #Tax payments - eq. 3 
      t[j,i] = theta*(y[j,i] + r[j,i-1]*b_h[j,i-1])
      
      #Supply of government bills - eq. 8
      b_s[j,i] = b_s[j,i-1] + ( p_g[j,i]*g[j,i] + r[j,i-1]*b_s[j,i-1]) - (t[j,i] + r[j,i-1]*b_cb[j,i-1])
      
      
      ## H) Central bank ####
      
      #Supply of cash - eq. 9
      h_s[j,i] = h_s[j,i-1] + b_cb[j,i] - b_cb[j,i-1]
      
      #Government bills held by the central bank - eq. 10
      b_cb[j,i] = b_s[j,i] - b_h[j,i]
      
      #Interest rate as policy instrument - eq. 11
      r[j,i] = r_bar[j,i]
      
      
      ## I) Ecosystem ####
      
      #Extraction of matter and waste
      
      #Production of material goods 
      x_mat[j,i] = t(mu_mat[,]) %*% x[j,i,]
      
      #Extraction of matter                                       
      mat[j,i] = x_mat[j,i] - rec[j,i]                                             
      
      #Recycled matter (of socioeconomic stock + industrial waste)
      rec[j,i] = rho_dis*dis[j,i]         
      
      #Discarded socioeconomic stock            
      dis[j,i] = t(mu_mat[,]) %*% (zeta_dc[,] * dc[j,i-1,])
      
      #Stock of durable consumption goods                 
      dc[j,i,] = dc[j,i-1,] + beta_c[j,i,]*cons[j,i] - zeta_dc[,] * dc[j,i-1,]    
      
      #Socioeconomic stock
      kh[j,i] = kh[j,i-1] + x_mat[j,i] - dis[j,i]       
      
      #Wasted socio-economic stock
      wa[j,i] = mat[j,i] - (kh[j,i]-kh[j,i-1])                                                                     
      
      
      #Use of energy, emissions and temperature
      
      #Energy required for production
      en[j,i] = t(eps_en[,]) %*% x[j,i,]                                          
      
      #Renewable energy at the end of the period
      ren[j,i] = t(eps_en[,]) %*% (eta_en[,]*x[j,i,])                         
      
      #Non-renewable energy
      nen[j,i] = en[j,i] - ren[j,i]                                                
      
      #C02 emissions
      emis[j,i] = beta_e*nen[j,i]   
      
      #Cumulative emissions
      co2_cum[j,i] = co2_cum[j,i-1] + emis[j,i]
      
      #Atmospheric temperature 
      temp[j,i] = (1/(1-fnc))*tcre*(co2_cum[j,i])
      
      
      #Resources and reserves  
      
      #Stock of material reserves
      k_m[j,i] = k_m[j,i-1] + conv_m[j,i] - mat[j,i]                      
      
      #Material resources converted to reserves 
      conv_m[j,i] = sigma_m*res_m[j,i]                                    
      
      #Stock of material resources
      res_m[j,i] = res_m[j,i-1] - conv_m[j,i]                            
      
      #Carbon mass of non-renewable energy 
      cen[j,i] = emis[j,i]/car                                            
      
      #Mass of oxygen 
      o2[j,i] = emis[j,i] - cen[j,i]                                      
      
      #Stock of energy reserves
      k_e[j,i] = k_e[j,i-1] + conv_e[j,i] - en[j,i]                       
      
      #Energy resources converted to reserves 
      conv_e[j,i] = sigma_e*res_e[j,i]                                    
      
      #Stock of energy resources
      res_e[j,i] = res_e[j,i-1] - conv_e[j,i]                             
      
      
      #Climate related damages / changes
      
      #Endogenous propensity to consume out of income
      alpha1[j,i] = alpha10 - alpha11*r[j,i] - alpha12[j,i] * (temp[j,i] - temp[j,i-1])   
      
      #Tip 1: try also beta_c[j,i,1] = beta0 + beta1 * temp[j,i-1]
      
      #Tip 2: we can connect waste accumulation with other variables...
      
    }
    
  }
}

### CONSISTENCY CHECK (REDUNDANT EQUATION) AND PLOTS ################################################################################

#Define layout
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
par(mar = c(5.1+1, 4.1+1, 4.1+1, 2.1+1))

#Figure 1: redundant equation
plot(h_s[1,2:nPeriods]-h_h[1,2:nPeriods], type="l", col="green",lwd=3,lty=1,font.main=1,cex.main=1.5,
     main=expression("Figure 1  Consistency check: " * italic(H[phantom("")]["s"]) - italic(H[phantom("")]["h"])),
     cex.axis=1.5,cex.lab=1.5,ylab = '\u00A3',
     xlab = 'Time',ylim = range(-1,1))

#Figure 2: disposable income and consumption
plot(yd[1,2:45],type="l", col=1, lwd=2, lty=1, font.main=1,cex.main=1.5,
     main="Figure 2  Disposable income and consumption \n under baseline scenario",
     ylab = '\u00A3',xlab = 'Time',ylim = range(min(cons[1,2:45]*p_c[1,2:45]),max(yd[1,2:45])),
     cex.axis=1.5,cex.lab=1.5)
lines(cons[1,2:45]*p_c[1,2:45],type="l",lwd=2,lty=2,col="purple1")
legend("right",c("Disposable income","Nom. consumption"),  bty = "n",
       cex=1.5, lty=c(1,2), lwd=c(2,2), col = c(1,"purple1"), box.lty=0)
abline(h=yd[1,nPeriods],col=1,lty=3)

#Figure 3: reserves depletion rates 
plot(100*(mat[1,2:30]/k_m[1,1:29]),type="l",
     col="coral3", lwd=3, lty=1, font.main=1,cex.main=1.5,
     main="Figure 3  Reserves depletion rates \n under baseline scenario",
     ylab = 'Index (%)',xlab = 'Time',cex.axis=1.5,cex.lab=1.5,ylim=range(0.5,1.5))
lines(100*(en[1,2:30]/k_e[1,1:29]),col="cyan4", lwd=3, lty=1)
legend("bottomright",c("Matter","Energy"),  bty = "n",
       cex=1.5, lty=c(1,1), lwd=c(3,3), col = c("coral3","cyan4"), box.lty=0)

#Figure 4: atmospheric temperature
plot(temp[1,2:30],type="l",
     col="cornflowerblue", lwd=3, lty=1, font.main=1,cex.main=1.5,
     main="Figure 4  Atmospheric temperature \n under baseline scenario",
     ylab = 'C',xlab = 'Time',cex.axis=1.5,cex.lab=1.5)

