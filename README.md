# 17th EAEPE Summer School

This repository includes the material prepared for the [17th EAEPE Summer School, Rome, 1-4 July](https://eaepe.org/?page=events&side=summer_school&sub=eaepe_summer_school). Specifically, it contains the `R` files that replicate the excercises made in the late morning session of Tuesday (2 July). 

## Table of Contents

- [1 Introduction](#1_Introduction)
- [2 Model PC](#2_Model_PC)
- [3 Model IO-PC](#3_Model_IO-PC)
- [4 Model ECO-IO-PC](#3_Model_ECO-IO-PC)


## 1_Introduction

Stock-Flow Consistent (SFC) models have gained traction in the laste three decades, finding applications in empirical macroeconomic research by institutions like the [Bank of England](https://www.bankofengland.co.uk/-/media/boe/files/working-paper/2016/a-dynamic-model-of-financial-balances-for-the-uk) and the [Italian Ministry of Economy and Finance](https://www.sciencedirect.com/science/article/abs/pii/S0264999322003509).

The resurgence of interest in SFC models can be traced back to Wynne Godley's [successful predictions](https://www.levyinstitute.org/publications/seven-unsustainable-processes) of the U.S. crises in 2001 and 2007. Godley's work laid the foundation for modern SFC modelling. These models, rooted in national accounts and flow of funds, integrate financial and real aspects of the economy, allowing for the identification of unsustainable processes.

Over the last decade, SFC models have evolved into various forms, including Open-Economy or Multi-Area SFC models (MA-SFC), Ecological SFC models (ECO-SFC), Interacting Heterogeneous Agent-Based SFC models (AB-SFC), Input-output SFC Models (IO-SFC), and Empirical SFC Models (E-SFC).

The aim of this lecture is to provide a simple introduction to IO- and ECO-SFC models by using a hand-on approach. For a theoretical introduction to SFC model, please refer to [Monetary Economics. An Integrated Approach to Credit, Money, Income, Production and Wealth](https://link.springer.com/book/10.1007/978-1-137-08599-3) by W. Godley and M. Lavoie. For additional `R` toy models and a more accurate description of them, see my [six lectures on SFC models](https://github.com/marcoverpas/Six_lectures_on_sfc_models)

## 2_Model_PC

This is one of the simplest SFC toy models and will we use it as our benchmark model. It is developed in chapter 4 of "[Monetary Economics. An Integrated Approach to Credit, Money, Income, Production and Wealth](https://link.springer.com/book/10.1007/978-1-137-08599-3)". **PC** stands for "portfolio choice", because households can hold their wealth in terms of cash and/or government bills.

Key assumptions are as follows:

1. Closed economy

1. Four agents: households, “firms”, government, central bank

1. Two financial assets: government bills and outside money (cash)

1. No investment (accumulation) and no inventories

1. Fixed prices and zero net profits

1. No banks, no inside money (bank deposits)

1. No ecosystem

The structure of Model PC is quite simple. Crucial identities of the model are derived using the balance-sheet matrix and the transaction-flow matrix. These tables are also useful to double-check model consistency in each period. 

#### Table 1. Balance sheet matrix  


|              | Households  | Firms      |Central bank |Government | Row. tot |
|:------------:|:------:     |:------:    |:------:     |:------:   |:---:     |
|Cash (money)  |$$H_h$$      |            |$$-H_s$$     |           |   0      |
|Bills         |$$B_h$$      |            |$$B_{cb}$$   |$$-B_s$$   |   0      |
|Wealth        |$$-V_h$$     |            |             |$$V_g$$    |   0      |
|Column tot.   |   0         |0           |0            |0          |   0      |


#### Table 2. Transactions-flow matrix  

|                       |Households           |Firms             |Central bank             |Government           | Row. tot |
|:----------------------|:---------------:    |:----------------:|:--------------:         |:--------------:     |:-------: |
|Consumption            |$$-C_d$$             |$$C_s$$           |                         |                     |   0      |
|Government expenditure |                     |$$G$$             |                         |$$-G$$               |   0      |
|GDP (income)           |$$Y$$                |$$-Y$$            |                         |                     |   0      |
|Interest payments      |$$r \cdot B_{h,-1}$$ |                  |$$r \cdot B_{cb,-1}$$    |$$-r \cdot B_{s,-1}$$|   0      |
|CB profit              |                     |                  |$$-r \cdot B_{cb,-1}$$   |$$r \cdot B_{cb,-1}$$|   0      |
|Taxes                  |$$-T$$               |                  |                         |$$T$$                |   0      |
|                       |                     |                  |                         |                     |          |
|Change in cash         |$$-\Delta H_h$$      |                  |$$\Delta H_s$$           |                     |   0      |
|Change in bills        |$$-\Delta B_h$$      |                  |$$-\Delta B_{cb}$$       |$$\Delta B_s$$       |   0      |
|Column tot.            |0                    |0                 |0                        |0                    |   0      |

Completing the identities derived form the tables above with behavioural equations for taxes, consumption, demand for bills, and the interest rate, we obtain the following system of difference equations:

*Equation `1`* - National income (identity): 
$$Y = C + G $$
where $C$ is household consumption and $G$ is government expenditure.

*Equation `2`* - Disposable income (identity):
$$YD = Y - T + r_{-1} \cdot B_{h,-1} $$
where $r$ is the interest rate and $B_h$ is households' holdings of bills. The subscript $-1$ stands for lagged variable.

*Equation `3`* - Tax revenue (behavioural):
$$T = \theta \cdot (Y +  r_{-1} \cdot B_{h,-1} ) $$
where $\theta$ is the average tax rate on total income before taxes.

*Equation `4`* - Household wealth (identity):
$$V_h = V_{h,-1} + YD - C  $$

*Equation `5`* - Consumption (hehavioural):
$$C = \alpha_1 \cdot YD + \alpha_2 \cdot V_{-1}  $$
where $\alpha_1$ is the propensity to consume out of income and $\alpha_2$ is the propensity to consume out of wealth.

*Equation `6`* - Cash held by households (identity):
$$H_h = V_h - B_h  $$

*Equation `7`* - Bills held by households (behavioural):
$$\frac{B_h}{V_h} = \lambda_0 + \lambda_1 \cdot r - \lambda_2 \cdot \frac{YD}{V_h}  $$
where $\lambda_0$ is the autonomous share of bills held by the households, $\lambda_1$ is the elasticity to the interest rate, and $\lambda_2$ captures households' liquidity preference.

*Equation `8`* - Supply of bills (identity):
$$B_s = B_{s,-1} + G - T + r_{-1} \cdot ( B_{s,-1} - B_{cb,-1} )  $$
where $B_{cb}$ is the amount of bills held by the central bank.

*Equation `9`* - Supply of cash (identity):
$$H_s = H_{s,-1} + \Delta B_{cb} $$

*Equation `10`* - Bills held by central bank (identity):
$$B_{cb} = B_s - B_h $$

*Equation `11`* - Interest rate (behavioural):
$$r = \bar{r} $$
where $\bar{r}$ is the policy rate set by the central bank.

*Redundant equation*:
$$H_s = H_h $$

Note that any complete and coherent model must contain an equation that is *redundant*, meaning that it is logically implied by all the others (*Walras' Law*). This equation must be excluded from the model, which is the reason it is sometimes called the *hidden equation*. However, it can be conveniently used to double-check the consistency of the model.

One of the advantages of using such a simple model as a basic model, is that we can calculate the (quasi) steady state solution for national income $`Y`$. We can do that by observing that in the steady state there must be no saving ($`C=YD`$) and household holdings of bills are stable ($`B_{h,−1}=B_h=B_h^{*}`$). Using these conditions and equations (2) and (3) in $`Y`$, we otain: 

$$Y^{\*}= \frac{G + r \cdot B_h^{*} \cdot (1 − \theta)}{\theta}$$

where $`B_h^{*}`$ is the steady-state value of household stock of bills.

The model can be easily simulated by identifying the coefficients and attributing an initial value to government spending ($G=G_0$, with $G_0>0$). A simple `R` code replicating Model PC can be found [here](https://github.com/marcoverpas/Six_lectures_on_sfc_models/blob/main/PC_model_from_scratch.R). 

## 3_Model_IO-PC

There are currently only a few prototype input-output SFC models, despite recent progress (Berg, Hartley, and Richters, 2015; Jackson and Jackson, 2021, 2023; Valdecantos, 2023). Integrating IO and SFC techniques poses challenges, but it is crucial for analysing both technical progress (Veronese Passarella, 2023) and the interaction of the ecosystem with the economy (Hardt and O’Neill, 2017).

Model IO-PC is an input-output extension of Model PC, where **IO** stands for "input-output structure".

In comparison to Model PC, additional assumptions include:

1. Two industries are considered (within the firms sector)

1. Only circulating capital is used

1. Technical coefficients are fixed

1. Each industry uses only one technique to produce one product

1. Prices are set based on reproduction conditions

1. The composition of both consumption and government spending is exogenously defined

It is also assumed that the marginal propensity to consume out of income is a negative function of the interest rate (as an increase in $r$ redistributes income from the wage earners to the rentiers, and the latter are marked by a lower propensity to consume). Based on these assumptions, a few additional equations are required to transform Model PC into Model IO-PC.

Notice that scalars are represented using *italic characters*, whereas vectors and matrices are represented using non-italic characters hereafter.

*Equation `12`* - Column vector of *unit prices of reproduction* (behavioural):

$$**\text{p}** = \frac{w}{**\text{\pr}**} + ( **\text{p}** \cdot **\text{A}** ) \cdot (1 + \mu) $$

*Equation `13`* - Column vector defining *composition of real consumption* (behavioural):

$$**\text{B}_c** = **\bar{\text{B}}_c**  $$  

*Equation `14`* - Column vector defining *composition of real government expenditure* (behavioural):

$$**\text{B}_g** = **\bar{\text{B}}_g** $$  

*Equation `15`* - *Average consumer price* (identity):

$$p_c = **\text{p}^T** \cdot **\text{B}_c** $$  

*Equation `16`* - *Average price for the government* (identity):

$$p_g = **\text{p}^T** \cdot **\text{B}_g** $$  

*Equation `17`* - Column vector of *final demands in real terms* (identity):

$$**\text{d}** = **\text{B}_c** \cdot c + **\text{B}_g** \cdot g $$  

*Equation `18`* - Column vector of *real gross outputs* (identity):

$$**\text{x}** = **\text{A}** \cdot **\text{x}** + **\text{d}**, ~ with: **\text{A}**= \left(\begin{array}{cc} a_{11} & a_{12} \\
                                                                        a_{21} & a_{22}
                                                                        \end{array}\right) $$  

*Equation `1.A`* - Modified equation for *national income* (identity):

$$Y = **\text{p}^T** \cdot **\text{d}** $$

*Equation `19`* - *Real consumption function* (behavioural):
$$c = \alpha_1 \cdot \left( \frac{YD}{p_c} - \pi \cdot \frac{V_{-1}}{p_c} \right) + \alpha_2 \cdot \frac{V_{-1}}{p_{c,-1}} $$

*Equation `5.A`* - *Nominal consumption* (identity):
$$C = p_c \cdot c $$

*Equation `20`* - *Nominal government spending* (identity):
$$G = p_g \cdot g $$

*Equation `21`* - *Propensity to consume out of income* (behavioural):
$$\alpha_1 = \alpha_{11} - \alpha_{12} \cdot r_{-1}$$

Note: the superscript $T$ stands for the transpose of the matrix, turning a column vector into a row vector. 

While `12` to `21` are additional equations, equations `1.A` and `5.A` replace equations `1` and `5` of Model PC, respectively. The main code for developing Model IO-PC and running some experiments can be found ...
