#Preparando vetor de códigos para cada tabela
library(xlsx)
library(sidrar)
library(dplyr)
variaveis <- read.csv("\\\\bbm003\\Areas\\Macro_Brasil\\Compartilhado\\Brasil\\Pastas Pessoais\\Danilo\\Estudos\\Atividade\\Nowcast\\AGRO.csv", encoding = "UTF-8")
var_825 <- subset(variaveis$cod.prod, variaveis$X825 == 1)
var_1179 <- subset(variaveis$cod.prod, variaveis$X1179 == 1)

tabela1179 <- get_sidra(api="/t/1179/V/2382/C227/all/C12525/all/N1/1")
tabela825 <- get_sidra(api= "/t/825/V/214/C226/all/C12526/all/N1/1")

tabela825 <- filter(tabela825, tabela825$`Produtos da lavoura temporária (Código)` %in% var_825 )
tabela1179 <- filter(tabela1179, `Produtos da lavoura permanente (Código)` %in% var_1179 )

dflist <- split(tabela825, tabela825$`Produtos da lavoura temporária (Código)`)

nom_col <- colnames(tabela825)  
vec <- c()
tabela_agregada <-  data.frame(matrix(c(rep(0,21)), nrow = 1))
colnames(tabela_agregada) <- nom_col
for (i in 1:length(dflist)){
  vec <- c(dflist[[i]][["Valor"]])
  vec <- vec/vec[1]
  vec <- data.frame(vec)
  x <- cbind(dflist[i], vec)
 tabela_agregada <- cbind(x,tabela_agregada) 
}

vec <- c(dflist[[1][["Valor"]]])
vec <- vec/vec[1]
x <- cbind(dflist[[1]],vec)

for (i in 1:2){
  d[i] <- data.frame(dflist[i])
}
