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

The aim of this lecture is to provide a simple introduction to IO- and ECO-SFC models by using a hand-on approach. For a theoretical introduction to SFC model, please refer to [Monetary Economics: An Integrated Approach to Credit, Money, Income, Production and Wealth](https://link.springer.com/book/10.1007/978-1-137-08599-3) by W. Godley and M. Lavoie. For additional `R` toy models and a more accurate description of them, see my [six lectures on SFC models](https://github.com/marcoverpas/Six_lectures_on_sfc_models)

## 2_Model_PC

This is one of the simplest SFC toy models. It is developed in chapter 4 of Godley and Lavoie (2007), "[Monetary Economics. An Integrated Approach to Credit, Money, Income, Production and Wealth](https://link.springer.com/book/10.1007/978-1-137-08599-3)". **PC** stands for "portfolio choice", because households can hold their wealth in terms of cash and/or government bills.

Key assumptions are as follows:

1. Closed economy

1. Four agents: households, “firms”, government, central bank

1. Two financial assets: government bills and outside money (cash)

1. No investment (accumulation) and no inventories

1. Fixed prices and zero net profits

1. No banks, no inside money (bank deposits)

1. No ecosystem

The structure of Model PC is quite simple [to be continued]
