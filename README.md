# 17th EAEPE Summer School [work in progress]

This repository includes the material prepared for the [17th EAEPE Summer School, Rome, 1-4 July](https://eaepe.org/?page=events&side=summer_school&sub=eaepe_summer_school). Specifically, it contains the `R` files that replicate the exercises made in the late morning session of Tuesday (2 July). 

## Table of Contents

- [1 Introduction](#1_Introduction)
- [2 Model PC](#2_Model_PC)
- [3 Model IO-PC](#3_Model_IO-PC)
- [4 Model ECO-IO-PC](#3_Model_ECO-IO-PC)


## 1_Introduction

Stock-Flow Consistent (SFC) models have gained traction in the last three decades, finding applications in empirical macroeconomic research by institutions like the [Bank of England](https://www.bankofengland.co.uk/-/media/boe/files/working-paper/2016/a-dynamic-model-of-financial-balances-for-the-uk) and the [Italian Ministry of Economy and Finance](https://www.sciencedirect.com/science/article/abs/pii/S0264999322003509).

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
|              |             |            |             |           |          |
|Cash (money)  |$$H_h$$      |            |$$-H_s$$     |           |   0      |
|Bills         |$$B_h$$      |            |$$B_{cb}$$   |$$-B_s$$   |   0      |
|Wealth        |$$-V_h$$     |            |             |$$V_g$$    |   0      |
|              |             |            |             |           |          |
|Column tot.   |   0         |0           |0            |0          |   0      |


#### Table 2. Transactions-flow matrix  

|                       |Households           |Firms             |Central bank             |Government           | Row. tot |
|:----------------------|:---------------:    |:----------------:|:--------------:         |:--------------:     |:-------: |
|                       |                     |                  |                         |                     |          |
|Consumption            |$$-C_d$$             |$$C_s$$           |                         |                     |   0      |
|Government expenditure |                     |$$G$$             |                         |$$-G$$               |   0      |
|GDP (income)           |$$Y$$                |$$-Y$$            |                         |                     |   0      |
|Interest payments      |$$r \cdot B_{h,-1}$$ |                  |$$r \cdot B_{cb,-1}$$    |$$-r \cdot B_{s,-1}$$|   0      |
|CB profit              |                     |                  |$$-r \cdot B_{cb,-1}$$   |$$r \cdot B_{cb,-1}$$|   0      |
|Taxes                  |$$-T$$               |                  |                         |$$T$$                |   0      |
|                       |                     |                  |                         |                     |          |
|Change in cash         |$$-\Delta H_h$$      |                  |$$\Delta H_s$$           |                     |   0      |
|Change in bills        |$$-\Delta B_h$$      |                  |$$-\Delta B_{cb}$$       |$$\Delta B_s$$       |   0      |
|                       |                     |                  |                         |                     |          |
|Column tot.            |0                    |0                 |0                        |0                    |   0      |

Completing the identities derived form the tables above with behavioural equations for taxes, consumption, demand for bills, and the interest rate, we obtain the following system of difference equations:

*Equation (`1`)* - National income (identity): 
$$Y = C + G $$
where $C$ is household consumption and $G$ is government expenditure.

*Equation (`2`)* - Disposable income (identity):
$$YD = Y - T + r_{-1} \cdot B_{h,-1} $$
where $r$ is the interest rate and $B_h$ is households' holdings of bills. The subscript $-1$ stands for lagged variable.

*Equation (`3`)* - Tax revenue (behavioural):
$$T = \theta \cdot (Y +  r_{-1} \cdot B_{h,-1} ) $$
where $\theta$ is the average tax rate on total income before taxes.

*Equation (`4`)* - Household wealth (identity):
$$V_h = V_{h,-1} + YD - C  $$

*Equation (`5`)* - Consumption (hehavioural):
$$C = \alpha_1 \cdot YD + \alpha_2 \cdot V_{-1}  $$
where $\alpha_1$ is the propensity to consume out of income and $\alpha_2$ is the propensity to consume out of wealth.

*Equation (`6`)* - Cash held by households (identity):
$$H_h = V_h - B_h  $$

*Equation (`7`)* - Bills held by households (behavioural):
$$\frac{B_h}{V_h} = \lambda_0 + \lambda_1 \cdot r - \lambda_2 \cdot \frac{YD}{V_h}  $$
where $\lambda_0$ is the autonomous share of bills held by the households, $\lambda_1$ is the elasticity to the interest rate, and $\lambda_2$ captures households' liquidity preference.

*Equation (`8`)* - Supply of bills (identity):
$$B_s = B_{s,-1} + G - T + r_{-1} \cdot ( B_{s,-1} - B_{cb,-1} )  $$
where $B_{cb}$ is the amount of bills held by the central bank.

*Equation (`9`)* - Supply of cash (identity):
$$H_s = H_{s,-1} + \Delta B_{cb} $$

*Equation (`10`)* - Bills held by central bank (identity):
$$B_{cb} = B_s - B_h $$

*Equation (`11`)* - Interest rate (behavioural):
$$r = \bar{r} $$
where $\bar{r}$ is the policy rate set by the central bank.

Note that any complete and coherent model must contain an equation that is *redundant*, meaning that it is logically implied by all the others (*Walras' Law*). In Model PC, this is the equation matching the demanded stock of cash with central bank's supply of cash:

$$H_s = H_h $$

This equation must be excluded from the model, which is the reason it is sometimes called the *hidden equation*. However, it can be conveniently used to double-check the consistency of the model.

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

1. Prices are determined by reproduction conditions

1. The composition of both consumption and government spending is exogenously defined

It is also assumed that the marginal propensity to consume out of income is a negative function of the interest rate (as an increase in $r$ redistributes income from the wage earners to the rentiers, and the latter are marked by a lower propensity to consume). Based on these assumptions, a few additional equations are required to transform Model PC into Model IO-PC.

Notice that scalars are represented using *italic characters*, whereas vectors and matrices are represented using non-italic characters hereafter.

*Equation (`12`)* - Column vector defining *composition of real consumption* (behavioural):

$$**\text{B}_c** = **\bar{\text{B}}_c**  $$  

where $\mathrm{B_c} = [ B_{c1} \text{ }  B_{c2} ]$ and $B_{c1} + B_{c2} = 1$.

*Equation (`13`)* - Column vector defining *composition of real government expenditure* (behavioural):

$$**\text{B}_g** = **\bar{\text{B}}_g** $$  

where $\mathrm{B_g} = [ B_{g1} \text{ } B_{g2} ]$ and $B_{g1} + B_{g2} = 1$.

*Equation (`14`)* - Column vector of *final demands in real terms* (identity):

$$**\text{d}** = **\text{B}_c** \cdot c + **\text{B}_g** \cdot g $$  

*Equation (`15`)* - Column vector of *real gross outputs* (identity):

$$**\text{x}** = **\text{A}** \cdot **\text{x}** + **\text{d}**, ~ with: **\text{A}**= \left(\begin{array}{cc} a_{11} & a_{12} \\
                                                                        a_{21} & a_{22}
                                                                        \end{array}\right) $$  

*Equation (`1.A`)* - Modified equation for *national income* (identity):

$$Y = **\text{p}^T** \cdot **\text{d}** $$

*Equation (`16`)* - Column vector of *unit prices of reproduction* (behavioural):

$$**\text{p}** = \frac{w}{**\text{pr}**} + ( **\text{p}**^T \cdot **\text{A}** ) \cdot (1 + \mu) $$

where $w$ is the (uniform) wage rate, $\mathrm{pr}$ is the vector of labour productivities, and $\mu$ is the (uniform) profit rate.

*Equation (`17`)* - *Average consumer price* (identity):

$$p_c = **\text{p}^T** \cdot **\text{B}_c** $$  

*Equation (`18`)* - *Average price for the government* (identity):

$$p_g = **\text{p}^T** \cdot **\text{B}_g** $$  

*Equation (`5.A`)* - *Real consumption function* (behavioural):
$$c = \alpha_1 \cdot \left( \frac{YD}{p_c} - \pi \cdot \frac{V_{-1}}{p_c} \right) + \alpha_2 \cdot \frac{V_{-1}}{p_{c,-1}} $$

where $\pi$ is the rate of growth of the consumer price index (inflation rate), as consumers are assumed not to suffer from monetary illusion.

*Equation (`19`)* - *Propensity to consume out of income* (behavioural):
$$\alpha_1 = \alpha_{10} - \alpha_{11} \cdot r_{-1}$$

where $\alpha_{10}$ and $\alpha_{11}$ are positive coefficients.

Note: the superscript $T$ stands for the transpose of the matrix, turning a column vector into a row vector. 

Equations (`12`) to (`19`) are additional ones. Equations (`1.A`) and (`5.A`) replace equations (`1`) and (`5`) of Model PC, respectively. The main code for developing Model IO-PC and running some experiments can be found [here](https://github.com/marcoverpas/EAEPE_summer_school_2024/blob/main/eaepe_io_model.R).

Using the hidden equation, **Figure 1** demonstrates that the model is watertight, while **Figure 2** illustrates that the evolution of the main macro variables towards the steady state exactly matches that of a standard (aggregative) SFC model. However, unlike a standard SFC model, Model IO-PC also allows for the accounting of the input-output structure of the economy.

The input-output matrix of Model IO-PC is shown in **Table 3**.

#### Table 3. Simplified input-output matrix

|                             | Industry 1 (demand)  | Industry 2 (demand)  |  Final demand   |             Output              |
|:----------------------------|:--------------------:|:--------------------:|:---------------:|:-------------------------------:|
|                             |                      |                      |                 |                                 |
| **Inudstry 1 (production)** | \$p_1 x_1 a\_{11} \$ | \$p_1 x_2 a\_{12} \$ | $p_1 \cdot d_1$ |         $p_1 \cdot x_1$         |
| **Industry 2 (production)** | \$p_2 a\_{21} x_1 \$ | \$p_2 a\_{22} x_2 \$ | $p_2 \cdot d_2$ |         $p_2 \cdot x_2$         |
| **Value added**             |        $yn_1$        |        $yn_2$        |      $yn$       |                                 |
| **Output**                  |   $p_1 \cdot x_1$    |   $p_2 \cdot x_2$    |                 | $\mathrm{p}^T \cdot \mathrm{x}$ |

**Table 3** illustrates cross-industry interdependencies in a simplified economy where two products are produced using the same products and labour.

These interdependencies are also depicted in the chart below. Specifically, **Figure 3** shows the final demands for each product, while **Figure 4** details the inputs required by each industry to produce their respective outputs.

<figure>
<img
src="https://github.com/marcoverpas/figures/blob/main/io_plot_1.png" width="800">
</figure>

## 4_Model_ECO-IO-PC

Although the origins of ecological macroeconomics can be traced back to the inception of economics itself, early SFC models for economic research did not incorporate the ecosystem.

This gap was bridged in the late 2010s (Dafermos, Nikolaidi, and Galanis, 2016, 2018; Jackson and Victor, 2015). The primary characteristic of ecological SFC models is their integration of monetary variables (following Godley and Lavoie, 2008) with physical variables (in line with Georgescu-Roegen, 1971) in a consistent manner. Several ECO-SFC models have been developed since then.

Here we consider a simple extension of Model IO-PC, named Model ECO-IO-PC, where **ECO** stands for "ecological". Additional assumptions are as follows:

1. there are 2 types of reserves: matter and energy

1. there are 2 types of energy: renewable and non-renewable

1. Resources are converted into reserves at a certain rate

1. Industrial CO2 emissions are associated with the use of non-renewable energy

1. Atmospheric temperature is a growing function of CO2 emissions

1. Both goods from industry 1 and industry 2 can be durable or non-durable

1. A share of durable goods (hence socio-economic stock) is discarded in every period

1. Both waste and emissions are produced only by the firm sector

Behavioural equations draw inspiration from the works of [Dafermos, Nikolaidi, and Galanis (2016, 2018)](https://define-model.org/). The main model code is available [here](https://github.com/marcoverpas/EAEPE_summer_school_2024/blob/main/eaepe_eco_model.R). New variables and coefficients are defined between line 88 and line 125. The blocks providing the additional equations for the ecosystem are those included between line 252 and 333.

Firstly, extraction of matter and waste are modelled.

*Equation (`20`)* - Production of *material goods*:

$$ x_{mat} = **\text{m}_{mat}^T** \cdot **\text{x}** $$

where $\text{m}_{mat}$ is the vector of material intensity coefficients by industry.

*Equation (`21`)* - *Extraction* of matter:

$$mat = x_{mat} - rec$$

*Equation (`22`)* - *Recycled* matter:

$$rec = \rho_{dis} \cdot dis$$

where $\rho_{dis}$ is the recycling rate of discarded products.

*Equation (`23`)* - *Discarded* socioeconomic stock:  

$$dis = **\text{m}_{mat}^T** \cdot (**\text{z}_{dc}** \odot **\text{dc}_{-1}**)$$

where $\text{z}_{dc}$ is the vector defining the percentages of discarded socio-economic stock by industry.

*Equation (`24`)* - Stock of *durable goods*:

$$ **\text{dc}** = **\text{dc}_{-1}** + **\text{B}_c** \cdot c - **\text{z}_{dc}** \cdot **\text{dc}_{-1}** $$

*Equation (`25`)* - *Socioeconomic stock*:

$$k_h = k_{h,-1} + x_{mat} - dis $$

*Equation (`26`)* - *Waste*:

$$wa = mat - (k_h - k_{h,-1}) $$

Secondly, energy use and CO2 emissions are considered.

*Equation (`27`)* - *Total energy* required for production:

$$en = **\text{e}_{en}^T** \cdot **\text{x}**$$

where $\text{e}_{en}$ is the vector that defines the energy intensity coefficients by industry.

*Equation (`28`)* - *Renewable* energy at the end of the period:

$$ren = **\text{e}_{en}^T** \cdot (**\text{a}_{en}** \odot **\text{x}** )                 $$

where $\text{a}_{en}$ is the vector that defines the industry-specific shares of renewable energy to total energy.

*Equation (`29`)* - *Non-renewable* energy:

$$nen = en - ren$$

*Equation (`30`)* - Annual flow of *CO2 emissions*:

$$emis = \beta_{e} \cdot nen$$

where $\beta_{e}$ is the CO2 intensity coefficient of non-renewable energy sources.

*Equation (`31`)* - *Cumulative* emissions:

$$co2_{cum} = co2_{cum,-1} + emis$$

*Equation (`32`)* - Atmospheric *temperature*:

$$temp = \frac{1}{1-fnc} \cdot tcre \cdot co2_{cum}$$

where $fnc$ is the non-CO2 fraction of total anthropocentric forcing and $tcre$ is the transient climate response to cumulative carbon emissions.

Thirdly, the dynamics of reserves is modelled.

*Equation (`33`)* - Stock of *matter reserves*:

$$k_m = k_{m,-1} + conv_m - mat$$

*Equation (`34`)* - Matter resources *converted* to reserves:

$$conv_m = \sigma_{m} \cdot res_m$$

where $\sigma_{m}$ is the conversion rate of matter resources into reserves.

*Equation (`35`)* - Stock of *matter resources*:

$$res_m = res_{m,-1} - conv_m$$

*Equation (`36`)* - *Carbon mass* of non-renewable energy:

$$cen = \frac{emis}{car}$$

*Equation (`37`)* - Mass of *oxygen*:

$$o2 = emis - cen$$

*Equation (`38`)* - Stock of *energy reserves*:

$$k_e = k_{e,-1} + conv_e - en$$

*Equation (`39`)* - Energy resources *converted* to reserves:

$$conv_e = \sigma_e \cdot res_e$$

where $\sigma_e$ is the conversion rate of energy resources into reserves.

*Equation (`40`)* - Stock of *energy resources*:

$$res_e = res_{e,-1} - conv_e$$

Lastly, feedback effects and damages can be introduced. Here the
assumption is made that the propensity to consume out of income is
(negatively) influenced by climate change.

*Equation (`19.A`)* - New *propensity to consume* out of income:

$$\alpha_1 = \alpha_{10} - \alpha_{11} \cdot r_{-1} - \alpha_{12} \cdot \Delta temp$$

where $\alpha_{12}$ is a positive coefficient.

The related physical constraints (used to define ecosystem identities) are displayed by **Table 4** and **Table 5**, in which matter is expressed in $Mt$ and energy is expressed in $EJ$. 

#### Table 4. Physical flow matrix

|                               |*Matter*        |*Energy*        |
|:------------------------------|:------------:  |:--------------:|
|                               |                |                |
|**INPUTS**                     |                |                |
|Extracted matter               |$$mat$$         |                |
|Recycled socio-economic stock  |$$rec$$         |                |
|Renewable energy               |                |$$ren$$         |
|Non-renewable energy           |$$cen$$         |$$nen$$         |
|Oxygen                         |$$o2$$          |                |
|                               |                |                |
|**OUTPUTS**                    |                |                |
|Industrial CO2 emissions       |$$-emis$$       |                |
|Discarded socio-economic stock |$$-dis$$        |                |
|Dissipated energy              |                |$$-nen$$        |
|Change in socio-economic stock |$$-\Delta k_h $$|                |
|                               |                |                |
|**TOTAL**                      |0               |0               |


#### Table 5. Physical stock-flow matrix

|                                     |*Matter*     |*Energy*     |*CO2*            |*SES*       |
|:------------------------------------|:----------: |:----------: |:----------:     |:----------:|
|                                     |             |             |                 |            |
|**INITIAL STOCK**                    |$$k_{m,-1}$$ |$$k_{e,-1}$$ |$$co2_{cum,-1}$$ |$$k_{h,-1}$$|
|Resources converted into reserves    |$$conv_m$$   |$$conv_e$$   |                 |            |
|CO2 emissions                        |             |             |$$emis $$        |            |
|Production of material goods         |             |             |                 |$$x_{mat} $$|
|Extraction of matter / use of energy |$$-mat$$     |$$-en $$     |                 |            |
|Destruction of socio-economic stock  |             |             |                 |$$-dis$$    |
|**FINAL STOCK**                      |$$k_m$$      |$$k_e$$      |$$co2_{cum}$$    |$$k_h$$     |

A dynamic rendition of the model is provided in the new Figure 3 and Figure 4, which now show the evolution over time of matter and energy reserves, and the atmospheric temperature, respectively.

<figure>
<img
src="https://github.com/marcoverpas/figures/blob/main/eco_plot_1.png" width="800">
</figure>

Note that the new Figure 1 and Figure 2 demonstrate that the behavior of the economy is qualitatively unchanged, except for the effect of the rise in temperature on consumption. 

[to be continued]
