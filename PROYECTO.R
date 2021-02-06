getwd()


setwd("C:/Users/HP/Desktop/CURSO BEDU FASE 2/Proyecto") # Depende del usuario



DATA<-read.csv(file ="conjunto_de_datos_pibr_pibr_2r2019_p.csv", header = FALSE)
head(DATA)
str(DATA)
View(DATA)

# Analizamos la data y la depuramos

a <- gsub("<C1>","",DATA$V1)
a <- gsub("<C2>","",a)
a <- gsub("B.1bV---","",a)
a <- gsub("B.1bP---","",a)
a <- gsub("D.21-D.31---","",a)
a <- gsub("ï»¿","",a)

DATA$V1 <- a

DATOS<-data.frame(t(DATA))
DATOS
head(DATOS)
str(DATOS)
View(DATOS)

suppressMessages(suppressWarnings(library(dplyr)))
SDATOS<-DATOS[-1,]
View(SDATOS)

# Analizamos la data y la depuramos

a <- gsub("<R>","",SDATOS$X1)
a <- gsub("<P>","",a)
SDATOS$X1 <- a

SDATOS2 <- mutate(SDATOS, X1 = as.Date(X1, "%Y"), X2 = as.numeric(X2), X3 = as.numeric(X3), X4 = as.numeric(X4), X5= as.numeric(X5), X6 = as.numeric(X6), X7 = as.numeric(X7))

View(SDATOS2)
str(SDATOS2)
PIB.DATA <- rename(SDATOS2,  AÑO= X1, PIB = X2, ISPN = X3 , VAB=X4, VAB_A1=X5 , VAB_A2=X6, VAB_A3=X7)
View(PIB.DATA)
str(PIB.DATA)

data.final<-data.frame(PIB.DATA)
View(data.final)
summary(data.final)
library(DescTools)
quantile(PIB.DATA$PIB, probs = seq(0.1, 0.9, 0.1))
IQR(PIB.DATA$PIB); sd(PIB.DATA$PIB); var(PIB.DATA$PIB)

library(ggplot2)

hist(x=data.final$PIB, 
     breaks = 10,
     main = " Histograma de PIB",
     ylab = "Frecuencia",
     xlab = "MILES DE MESOS", 
     col = "blue")



#realizando el histograma con la funci?n ggplot()
ggplot(data.final, aes(PIB))+ 
  geom_histogram(binwidth = 1000000, col="black", fill = "blue") + 
  ggtitle("Histograma de Mediciones") +
  ylab("Frecuencia") +
  xlab("VALIRES DE PIB") + 
  theme_light()

(my_scatplot <- ggplot(data.final, aes(x = PIB, y = VAB_A1)) + geom_point()+geom_smooth(method = "lm", se = T))

#VEREMOS SI LA VARIABLE PIB ES UNA DISTRIBUCION NORMAL 
x <- data.final$PIB # Algunos posibles valores que puede tomar la v.a. X (m?nimo: mu-4sigma, m?ximo: mu+4sigma)
y <- dnorm(x, mean = mean(data.final$PIB), sd=sd(PIB.DATA$PIB) ) # Valores correspondientes de la funci?n de densidad de probabilidad

plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 12397738, " y ", sigma == 3448562)))
abline(v = 12397738, lwd = 2, lty = 2) # La media es 175 

ma <- rnorm(1000, mean = 12397738, sd = 3448562) 
madf <- as.data.frame(ma)
tail(madf)

p <- ggplot(madf, aes(ma)) + 
  geom_histogram(colour = 'red', 
                 fill = 'blue',
                 alpha = 0.8, # Intensidad del color fill
                 binwidth = 1000000) + 
  geom_density(aes(y = 3.5*..count..))+
  geom_vline(xintercept = mean(ma), 
             linetype="dashed", color = "black") + 
  ggtitle('Histograma para la muestra normal') + 
  labs(x = 'Valores obtenidos', y = 'Frecuencia')+
  theme_dark() +
  theme(plot.title = element_text(hjust = 0.5, size = 16))
p

ma <- rnorm(1000, mean = 12397738, sd = 3448562) 
# Contraste de hip?tesis

# Dada una muestra aleatoria de tama?o n = 10 de la distribuci?n normal

set.seed(124)
muestra <- rnorm(n = 10, mean = 12397738, sd = 3448562) 
tail(as.data.frame(muestra))
# El valor observado del estad?stico de prueba en este caso est? dado por

t0 <- (mean(muestra)-12397738)/(sd(muestra)/sqrt(10)) 
t0
(t.05 <- qt(p = 0.05, df = 9))
t0 < t.05
#NO RECHAZAMOS LA HIPOTESISI NULA 
(pvalue <- pt(t0, df = 9)) # 2.

t.test(x = muestra, # 3.
       alternative = "less",
       mu = 12397738)



#regresion lineal multiple  de PIB 
suppressWarnings(suppressMessages(library(dplyr)))


head(data.final, 2); tail(data.final, 2); dim(data.final)

attach(data.final)
# Llevamos a cabo el siguiente modelo y si es necesario ajustarlo
# Y(PIB) = beta0 + beta1*ISPN + beta2*VAB + beta3*VAB_A1 + beta4*VAB_A2 + beta5*VAB_A3 + e
#cabe resaltar que este modelo ya esta dado por el inegi
m1 <- lm(PIB ~ ISPN+ VAB + VAB_A1 + VAB_A2 + VAB_A3)

summary(m1)
#ste primer modelo con dice que el R cuadrada ajustada es igual a 1 entonces es un buen modelo 
# tiene logica pues el mdelo que usa el inegi juaremos un poco con las variables para llegar a 
#un modelp de 95% de esactitid y no del 100%

m2 <- update(m1, ~.-VAB_A3)
summary(m2)

#despes de eliminar la variable de las actividades terciarias vemos que sigue igual seguiremos eliminando 
#variables que pensemos que harian cambiar el modelo 

m3<-  update(m2, ~.-VAB)
summary(m3)
# este modelo 3 nos saca una r cuadrad de 0.9977 quitaremos otra variable para ver si llegamos a 95%

m4<- update(m3, ~.-ISPN)
summary(m4)
m4

# entonces nuestro modelo queda asi 
#Y(PIB)= BETA0 + BETA3*ACTIVIDADES_PRIMARIAS + BETA4*ACTIVIDADES SECUNDARIAS 
#y=beta0+beta3*VAB_A2 + beta4*VAB_A3
# nuestros valores de betas son 
beta0=-5.008e+06
beta3=2.579e+01
beta4=1.519e+00


# hacemos la prediccion en base a datos encontrados en inegi de lo que fue el a?o 2020
DATOS2020<-read.csv(file ="PIB2020.csv")
names(DATOS2020)
DATOS2020<-rename(DATOS2020,X1=Impuestos.sobre.los.productos..netos,X2=Valor.agregado.bruto,X3=Actividades.primarias,X4=Actividades.secundarias,X5=Actividades.terciarias)
str(DATOS2020)
View(DATOS2020)
prediccion =beta0+beta3*DATOS2020$X3+beta4*DATOS2020$X4
prediccion

#aqui podemos ver nuestras 5 predicciones con los valores dados
plot(x=c(1981:2020), y=data.final$PIB ,type = "o", ylab = "millones de pesos", xlab = "Tiempo", main = "Tendecia de PIB anual")
points(x=rep(2020,5),y=prediccion,col="blue",pch=19)
#y aqui vemos graica uno por uno 
plot(x=c(1981:2020), y=data.final$PIB ,type = "o", ylab = "millones de pesos", xlab = "Tiempo", main = "Tendecia de PIB 1 trimestre ")
points(x=2020,y=prediccion[1],col="blue",pch=19)

plot(x=c(1981:2020), y=data.final$PIB ,type = "o", ylab = "millones de pesos", xlab = "Tiempo", main = "Tendecia de PIB 2 trimestre ")
points(x=2020,y=prediccion[2],col="blue",pch=19)

plot(x=c(1981:2020), y=data.final$PIB ,type = "o", ylab = "millones de pesos", xlab = "Tiempo", main = "Tendecia de PIB 3 trimestre ")
points(x=2020,y=prediccion[3],col="blue",pch=19)

plot(x=c(1981:2020), y=data.final$PIB ,type = "o", ylab = "millones de pesos", xlab = "Tiempo", main = "Tendecia de PIB semestral")
points(x=2020,y=prediccion[4],col="blue",pch=19)

plot(x=c(1981:2020), y=data.final$PIB ,type = "o", ylab = "millones de pesos", xlab = "Tiempo", main = "Tendecia de PIB de nueve meses")
points(x=2020,y=prediccion[5],col="blue",pch=19)

prediccion
