# BS, TFM AND IO TABLES

# Created by Marco Veronese Passarella

# Version: 7 June 2024; revised: 13 June 2024

### Prepare the environment ################################################################################

#Upload libraries
library(knitr)

#Choose a year
yr=20

### BS matrix ################################################################################

#Create row names for BS matrix
rownames<-c( "Cash (money)",
             "Bills",
             "Wealth",
             "Column total")

#Create households aggregates
H <-c( round(h_h[1,yr], digits = 2),                                                                    
       round(b_h[1,yr], digits = 2),                                                                    
       round(-v[1,yr], digits = 2),                                                                    
       round(-v[1,yr]+h_h[1,yr]+b_h[1,yr], digits = 2)
)                                                                    

#Create table of results
H_BS<-as.data.frame(H,row.names=rownames)

#Print firms column
kable(H_BS)

#Create firms aggregates
P <-c( "",                                                                    
       "",                                                                    
       "",                                                                    
       0
)                                                                    

#Create table of results
F_BS<-as.data.frame(P,row.names=rownames)

#Print firms column
kable(F_BS)

#Create government aggregates
G   <-c( "",                                                                    
         round(-b_s[1,yr], digits = 2),                                                                    
         round(b_s[1,yr], digits = 2),                                                                    
         "0"
)                                                                    

#Create table of results
G_BS<-as.data.frame(G,row.names=rownames)

#Print firms column
kable(G_BS)

#Create CB aggregates
CB  <-c( round(-h_s[1,yr], digits = 2),                                                                    
         round(b_cb[1,yr], digits = 2),                                                                    
         "0",
         round(-h_s[1,yr]+b_cb[1,yr], digits = 2)
)                                                                    

#Create table of results
CB_BS<-as.data.frame(CB,row.names=rownames)

#Print firms column
kable(CB_BS)

#Create "row total" column
Tot  <-c( round(h_h[1,yr]-h_s[1,yr], digits = 2),                                                                    
          round(b_h[1,yr]+b_cb[1,yr]-b_s[1,yr], digits = 2),                                                                    
          round(-v[1,yr]+b_s[1,yr], digits = 2),
          round(h_h[1,yr]-h_s[1,yr]+
                  b_h[1,yr]+b_cb[1,yr]-b_s[1,yr]+
                  -v[1,yr]+b_s[1,yr], digits = 2)
)                                                                    

#Create table of results
Tot_BS<-as.data.frame(Tot,row.names=rownames)

#Print firms column
kable(Tot_BS)

#Create BS matrix
BS_Matrix<-cbind(H_BS,F_BS,CB_BS,G_BS,Tot_BS)
kable(BS_Matrix) #Unload kableExtra to use this

### TFM matrix ################################################################################

#Create row names for TFM
rownames<-c( "Consumption",
             "Government expenditure",
             "GDP (income)",
             "Interest payments",
             "CB profit",
             "Taxes",
             "Change in cash",
             "Change in bills",
             "Column total")

#Create households aggregates
H <-c( round(-cons[1,yr]*p_c[1,yr], digits = 2),
       "",
       round(y[1,yr], digits = 2),                                                                    
       round(r[1,yr-1]*b_h[1,yr-1], digits = 2),
       "",
       round(-t[1,yr], digits = 2),
       round(-h_h[1,yr]+h_h[1,yr-1], digits = 2),
       round(-b_h[1,yr]+b_h[1,yr-1], digits = 2),
       round(-cons[1,yr]*p_c[1,yr]+y[1,yr]+r[1,yr-1]*b_h[1,yr-1]-t[1,yr]+
               -h_h[1,yr]+h_h[1,yr-1]-b_h[1,yr]+b_h[1,yr-1], digits = 2)
)                                                                    

#Create table of results
H_TFM<-as.data.frame(H,row.names=rownames)

#Print firms column
kable(H_TFM)

#Create firms aggregates
P <-c( round(cons[1,yr]*p_c[1,yr], digits = 2),
       round(g[1,yr]*p_g[1,yr], digits = 2),
       round(-y[1,yr], digits = 2),                                                                    
       "",
       "",
       "",
       "",
       "",
       round(cons[1,yr]*p_c[1,yr]+g[1,yr]*p_g[1,yr]-y[1,yr], digits = 2)
)                                                                    

#Create table of results
F_TFM<-as.data.frame(P,row.names=rownames)

#Print firms column
kable(F_TFM)

#Create government aggregates
G   <-c( "",
         round(-g[1,yr]*p_g[1,yr], digits = 2),
         "",                                                                    
         round(-r[1,yr-1]*b_s[1,yr-1], digits = 2),
         round(r[1,yr-1]*b_cb[1,yr-1], digits = 2),
         round(t[1,yr], digits = 2),
         "",
         round(b_s[1,yr]-b_s[1,yr-1], digits = 2),
         round(-g[1,yr]*p_g[1,yr]+
                 -r[1,yr-1]*b_s[1,yr-1]+
                 r[1,yr-1]*b_cb[1,yr-1]+
                 t[1,yr]+
                 b_s[1,yr]-b_s[1,yr-1], digits = 2)
)                                                                    

#Create table of results
G_TFM<-as.data.frame(G,row.names=rownames)

#Print firms column
kable(G_TFM)

#Create CB aggregates
CB   <-c( "",
          "",
          "",                                                                    
          round(r[1,yr-1]*b_cb[1,yr-1], digits = 2),
          round(-r[1,yr-1]*b_cb[1,yr-1], digits = 2),
          "",
          round(h_s[1,yr]-h_s[1,yr-1], digits = 2),
          round(-b_cb[1,yr]+b_cb[1,yr-1], digits = 2),
          round(h_s[1,yr]-h_s[1,yr-1]-b_cb[1,yr]+b_cb[1,yr-1], digits = 2)
)                                                                    

#Create table of results
CB_TFM<-as.data.frame(CB,row.names=rownames)

#Print firms column
kable(CB_TFM)

#Create "row total" column
Tot   <-c(round(cons[1,yr]*p_c[1,yr]-cons[1,yr]*p_c[1,yr], digits = 2),
          round(g[1,yr]*p_g[1,yr]-g[1,yr]*p_g[1,yr], digits = 2),
          round(y[1,yr]-y[1,yr], digits = 2),                                                                    
          round(r[1,yr-1]*b_h[1,yr-1]+r[1,yr-1]*b_cb[1,yr-1]-r[1,yr-1]*b_s[1,yr-1], digits = 2),
          round(r[1,yr-1]*b_cb[1,yr-1]-r[1,yr-1]*b_cb[1,yr-1], digits = 2),
          round(-t[1,yr]+t[1,yr], digits = 2),
          round(-h_h[1,yr]+h_h[1,yr-1]+h_s[1,yr]-h_s[1,yr-1], digits = 2),
          round(-b_h[1,yr]+b_h[1,yr-1]-b_cb[1,yr]+b_cb[1,yr-1]+b_s[1,yr]-b_s[1,yr-1], digits = 2),
          round(cons[1,yr]*p_c[1,yr]-cons[1,yr]*p_c[1,yr]+
                  g[1,yr]*p_g[1,yr]-g[1,yr]*p_g[1,yr]+
                  y[1,yr]-y[1,yr]+
                  r[1,yr-1]*b_h[1,yr-1]+r[1,yr-1]*b_cb[1,yr-1]-r[1,yr-1]*b_s[1,yr-1]+
                  r[1,yr-1]*b_cb[1,yr-1]-r[1,yr-1]*b_cb[1,yr-1]+
                  -t[1,yr]+t[1,yr]+
                  -h_h[1,yr]+h_h[1,yr-1]+h_s[1,yr]-h_s[1,yr-1]+
                  -b_h[1,yr]+b_h[1,yr-1]-b_cb[1,yr]+b_cb[1,yr-1]+b_s[1,yr]-b_s[1,yr-1], digits = 2)
)                                                                    

#Create table of results
Tot_TFM<-as.data.frame(Tot,row.names=rownames)

#Print firms column
kable(Tot_TFM)

#Create TFM matrix
TFM_Matrix<-cbind(H_TFM,F_TFM,CB_TFM,G_TFM,Tot_TFM)
kable(TFM_Matrix) #Unload kableExtra to use this

### IO matrix ################################################################################

#Create row names for IO matrix
rownames <-c( "Inudstry 1 (production)",
              "Industry 2 (production)",
              "Value added",
              "Output"
)

#Create industry 1 column
Ind1 <- c(round(x[1,yr,1]*A[1]*p[1,yr,1], digits = 2),                                                                    
          round(x[1,yr,1]*A[2]*p[1,yr,2], digits = 2),
          round(x[1,yr,1]*p[1,yr,1]-(x[1,yr,1]*A[1]*p[1,yr,1]+x[1,yr,1]*A[2]*p[1,yr,2]), digits = 2),
          round(x[1,yr,1]*p[1,yr,1], digits = 2)
)

#Create table of results
IO_Ind1<-as.data.frame(Ind1,row.names=rownames)
kable(IO_Ind1)

#Create industry 2 column
Ind2 <- c(round(x[1,yr,2]*A[3]*p[1,yr,1], digits = 2),                                                                    
           round(x[1,yr,2]*A[4]*p[1,yr,2], digits = 2),
           round(x[1,yr,2]*p[1,yr,2]-(x[1,yr,2]*A[3]*p[1,yr,1]+x[1,yr,2]*A[4]*p[1,yr,2]), digits = 2),
           round(x[1,yr,2]*p[1,yr,2], digits = 2)
)

#Create table of results
IO_Ind2<-as.data.frame(Ind2,row.names=rownames)
kable(IO_Ind2)

#Create final demand column
Dem <- c(round(d[1,yr,1]*p[1,yr,1], digits = 2),                                                                    
         round(d[1,yr,2]*p[1,yr,2], digits = 2),
         round((d[1,yr,1]*p[1,yr,1]+d[1,yr,2]*p[1,yr,2]), digits = 2),
         "")


#Create table of results
IO_Dem<-as.data.frame(Dem,row.names=rownames)
kable(IO_Dem)

#Create output column
Out <- c(round(x[1,yr,1]*A[1]*p[1,yr,1]+x[1,yr,2]*A[3]*p[1,yr,1]+d[1,yr,1]*p[1,yr,1], digits = 2),                                                                    
         round(x[1,yr,1]*A[2]*p[1,yr,2]+x[1,yr,2]*A[4]*p[1,yr,2]+d[1,yr,2]*p[1,yr,2], digits = 2),
         "",
         round(p[1,yr,1]*x[1,yr,1]+p[1,yr,2]*x[1,yr,2], digits = 2))


#Create table of results
IO_Out<-as.data.frame(Out,row.names=rownames)
kable(IO_Out)

#Create IO matrix
IO_Matrix<-cbind(IO_Ind1,IO_Ind2,IO_Dem,IO_Out)
kable(IO_Matrix) #Unload kableExtra to use this

### HTML versions ################################################################################

#Create html and latex tables

#Upload libraries
library(kableExtra)

#Create captions
caption1 <- paste("Table 1. Balance sheet in period", yr, "under baseline")
caption2 <- paste("Table 2. Transactions-flow matrix in period ",yr, "under baseline")
caption3 <- paste("Table 3. Input-output matrix in period ",yr, "under baseline")

#Create html table for BS
BS_Matrix %>%
  kbl(caption=caption1,
      format= "html",
      #format= "latex",
      col.names = c("Households","Firms","Central bank","Government","Row total"),
      align="r") %>%
  kable_classic(full_width = F, html_font = "helvetica")

#Create html table for TFM
TFM_Matrix %>%
  kbl(caption=caption2,
      format= "html",
      #format= "latex",
      col.names = c("Households","Firms","Central bank","Government","Row total"),
      align="r") %>%
  kable_classic(full_width = F, html_font = "helvetica")

#Create html table for IO
IO_Matrix %>%
  kbl(caption=caption3,
      format= "html",
      col.names = c("Industry 1 (demand)","Industry 2 (demand)","Final demand","Output"),
      align="r") %>%
  kable_classic(full_width = F, html_font = "helvetica")
