library(tidyverse)
library(rvest)
rm(list=ls())

# Page: https://www.worldometers.info/coronavirus/

url=read_html('https://www.worldometers.info/coronavirus/')
df=url%>%html_nodes('.main_table_countries_div')

df=url%>%html_nodes('.main_table_countries_div tbody')
df_t=df[[1]]
df_t_c=df[[1]] %>% html_nodes('tr td')%>%
  html_text()
df_t_c=length(df_t_c)/10

#  Vectors

Country=c()
TotalCases=c()
NewCases=c()
TotalDeaths=c()
NewDeaths=c()
TotalRecovered=c()
ActiveCases=c()
Serious_Critical=c()
TotCases1Mpop=c()
TotDeaths1Mpop=c()

# Extract Nodes

for(i in 1:df_t_c){
  Nodos=xml_child(df_t, i)
  Country=c(Country,xml_child(Nodos, 1)%>%html_text())
  TotalCases=c(TotalCases,xml_child(Nodos, 2)%>%html_text())
  NewCases=c(NewCases,xml_child(Nodos, 3)%>%html_text())
  TotalDeaths=c(TotalDeaths,xml_child(Nodos, 4)%>%html_text())
  NewDeaths=c(NewDeaths,xml_child(Nodos, 5)%>%html_text())
  TotalRecovered=c(TotalRecovered,xml_child(Nodos, 6)%>%html_text())
  ActiveCases=c(ActiveCases,xml_child(Nodos, 7)%>%html_text())
  Serious_Critical=c(Serious_Critical,xml_child(Nodos, 8)%>%html_text())
  TotCases1Mpop=c(TotCases1Mpop,xml_child(Nodos, 9)%>%html_text())
  TotDeaths1Mpop=c(TotDeaths1Mpop,xml_child(Nodos, 10)%>%html_text())
  print(i)
}

# Create dataframe

casos=data.frame(
  Country,
  TotalCases,
  NewCases,
  TotalDeaths,
  NewDeaths,
  TotalRecovered,
  ActiveCases,
  Serious_Critical,
  TotCases1Mpop,
  TotDeaths1Mpop, 
  stringsAsFactors = F
)

# Delete files

rm(df,df_t,Nodos,url,Country,
   TotalCases,
   NewCases,
   TotalDeaths,
   NewDeaths,
   TotalRecovered,
   ActiveCases,
   Serious_Critical,
   TotCases1Mpop,
   TotDeaths1Mpop,df_t_c,i)

# Write file csv
write_csv(casos,'casos.csv')


