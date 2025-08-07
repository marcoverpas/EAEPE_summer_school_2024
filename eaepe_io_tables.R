# IO Table for Model IO-PC
# Created by Marco Veronese Passarella
# Version: 7 June 2024; revised: 13 June 2024

### Prepare the environment ################################################################################

#Upload libraries
library(knitr)

#Choose a year
yr=20

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

### HTML version ################################################################################

#Create html and latex tables

#Upload libraries
library(kableExtra)

#Create captions
caption3 <- paste("Table 3. Input-output matrix in period ",yr, "under baseline")

#Create html table for IO
IO_Matrix %>%
  kbl(caption=caption3,
      format= "html",
      col.names = c("Industry 1 (demand)","Industry 2 (demand)","Final demand","Output"),
      align="r") %>%
  kable_classic(full_width = F, html_font = "helvetica")
