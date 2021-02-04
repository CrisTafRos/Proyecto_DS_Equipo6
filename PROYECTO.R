getwd()


setwd("C:/Users/HP/Desktop/CURSO BEDU FASE 2/Proyecto") # Depende del usuario



DATA<-read.csv(file ="conjunto_de_datos_pibr_pibr_2r2019_p.csv", header = FALSE)
head(DATA)
str(DATA)
View(DATA)

DATOS<-data.frame(t(DATA))
DATOS
head(DATOS)
str(DATOS)
View(DATOS)


suppressMessages(suppressWarnings(library(dplyr)))
SDATOS<-DATOS[-1,]
View(SDATOS)
SDATOS2 <- mutate(SDATOS, X1 = as.Date(X1, "%Y"), X2 = as.numeric(X2), X3 = as.numeric(X3), X4 = as.numeric(X4), X5= as.numeric(X5), X6 = as.numeric(X6), X7 = as.numeric(X7))

View(SDATOS2)
str(SDATOS2)
PIB.DATA <- rename(SDATOS2,  AÑO= X1, PIB = X2, ISPN = X3 , VAB=X4, VAB_A1=X5 , VAB_A2=X6, VAB_A3=X7)
View(PIB.DATA)
str(PIB.DATA)
data.final<-data.frame(PIB.DATA)
summary(data.final)
library(DescTools)
quantile(PIB.DATA$PIB, probs = seq(0.1, 0.9, 0.1))
IQR(PIB.DATA$PIB); sd(PIB.DATA$PIB); var(PIB.DATA$PIB)

library(ggplot2)

hist(x=data.final$PIB, 
     breaks = 10,
     main = " Histograma de PIB",
     ylab = "Frecuencia",
     xlab = "VILES DE MESOS", 
     col = "blue")



#realizando el histograma con la función ggplot()
ggplot(data.final, aes(PIB))+ 
  geom_histogram(binwidth = 1000000, col="black", fill = "blue") + 
  ggtitle("Histograma de Mediciones") +
  ylab("Frecuencia") +
  xlab("Alturas") + 
  theme_light()

(my_scatplot <- ggplot(data.final, aes(x = PIB, y = VAB_A1)) + geom_point()+geom_smooth(method = "lm", se = T))

#VEREMOS SI LA VARIABLE PIB ES UNA DISTRIBUCION NORMAL 
x <- data.final$PIB # Algunos posibles valores que puede tomar la v.a. X (mínimo: mu-4sigma, máximo: mu+4sigma)
y <- dnorm(x, mean = Mean(data.final$PIB), sd=sd(PIB.DATA$PIB) ) # Valores correspondientes de la función de densidad de probabilidad

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
# Contraste de hipótesis

# Dada una muestra aleatoria de tamaño n = 10 de la distribución normal

set.seed(124)
muestra <- rnorm(n = 10, mean = 12397738, sd = 3448562) 
tail(as.data.frame(muestra))
# El valor observado del estadístico de prueba en este caso está dado por

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

m1 <- lm(PIB ~ ISPN+ VAB + VAB_A1 + VAB_A2 + VAB_A3)

summary(m1)

m2 <- update(m1, ~.-VAB_A3)
summary(m2)

m3<-  update(m2, ~.-VAB)
summary(m3)

m4<- update(m3, ~.-ISPN)
summary(m4)
m4
# Acontinuación mostramos una matriz de gráficos de dispersión de los
# DOS predictores continuos. Los predictores parecen estar linealmente
# relacionados al menos aproximadamente
pairs(~ VAB_A1 + VAB_A2, data = data.final, gap = 0.4, cex.labels = 1.5)

# Acontinuación veremos gráficas de residuales estandarizados contra cada
# predictor. La naturaleza aleatoria de estas gráficas es un indicativo de
# que el modelo ajustado es un modelo válido para los datos.

m4 <- lm(PIB ~ VAB_A1+VAB_A2)
summary(m4)
StanRes1 <- rstandard(m4)
par(mfrow = c(2, 2))
plot(ISPN, StanRes1, ylab = "Residuales Estandarizados")
plot(VAB, StanRes1, ylab = "Residuales Estandarizados")
plot(VAB_A1, StanRes1, ylab = "Residuales Estandarizados")
plot(VAB_A2, StanRes1, ylab = "Residuales Estandarizados")
dev.off()

# Finalmente mostramos una gráfica de Y, el precio contra los valores
# ajustados 

plot(m4$fitted.values, PIB, xlab = "Valores ajustados", ylab = "VILES DE PESOS")
abline(lsfit(m1$fitted.values, PIB))


#### Técnicas descriptivas: gráficas, tendencias y variación estacional
library(TSA)
data(PIB.DATA)
seriedetiempo<-ts(data.final$PIB, freq=1, start = c(1980,1) )
data.final
seriedetiempo


plot(seriedetiempo, type = "o", ylab = "millones de pesos", xlab = "Tiempo", main = "Tendecia de PIB anual")

plot(seriedetiempo, type = "l", ylab = "Vmillones de pesos", xlab = "Tiempo",
     main = "Tendecia de PIB anual",
     sub = "Símbolos Especiales")


vab_a1=565151	
vab_a2=4700371

beta0=-5.008e+06
beta3=2.579e+01
beta4=1.519e+00

prediccion =beta0+beta3*vab_a1+beta4*vab_a2
prediccion

plot(x=c(1981:2020), y=data.final$PIB ,type = "o", ylab = "millones de pesos", xlab = "Tiempo", main = "Tendecia de PIB anual")
points(x=2020,y=prediccion,col="blue",pch=19)
max(data.final$PIB)
prediccion
