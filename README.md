# Proyecto_DS_Equipo6
## Integrantes Equipo 6
- Flores Nogueira Diego David
- González Toleto Atzimba Alejandra
- Mendoza Martínez Arturo
- Tafolla Rosales Cristian
## Introducción
Una forma de poder visualizar el progreso de la economía de cualquier nación tomará siempre como referencia el cálculo del Producto Interno Bruto (PIB), indicador que ilustra el valor total de los bienes y servicios finales producidos en un país.
Las organizaciones toman tanto los datos históricos como los pronósticos del PIB para poder tomar decisiones para expandir sus actividades o saber si es conveniente invertir en cierta nación. Por esta razón decidimos profundizar en materia para poder hacer un análisis descriptivo de los registros anuales nacionales, entender su comportamiento y hacer una proyección a partir de dicha información
## Estructura del proyecto
- El archivo nombrado  `PROYECTO.R` contiene todo el código utilizado para el desarrollo del proyecto.
- La carpeta `ProyectoPIB/PIB` corresponde al dashboard construido con Shiny.
- Este archivo,  `README.md` describe a grandes razgos el contenido del proyecto.
## Datos
En México el encargado de calcular el PIB es el Instituto Nacional de Estadística y Geografía (INEGI). Sus tareas principales son captar, procesar y difundir información acerca del territorio, la población y la economía.
El documento disponible en el sitio web del INEGI, el cual contiene los siguientes datos:
1. **PIB**: Producto Interno Bruto, en millones de pesos.
2. **ISPN**: Impuestos sobre los productos, netos. De igual forma interpretado en millones de pesos.
3. **VAB**: Valor agregado bruto, saldo correspondiente al capital fijo de los activos fijos.
4. **VAB_A1**: Valor agregado bruto por actividades primarias. Es la proporción obtenida a través del aprovechamiento de recursos tal y como se pueden obtener de la naturaleza. Por ejemplo: agricultura, pesca, caza, ganadería.
5. **VAB_A2**: Valor agregado bruto por actividades secundarias. Corresponde a la minería, electricidad, agua, suministro de gas, construcción e industrias manufactureras.
6. **VAB_A3**: Valor agregado bruto por actividades terciarias. Aquí encontramos comercios, servicios financieros, transportes, correos, almacenamiento.

| Variable  | Mínimo | Mediana  | Media | Máximo |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| PIB  | 7,642,962  | 12,599,656  | 12,397,738  | 18,520,044  |
| ISPN  | 285,646 | 483,514 | 490,083 | 819,271|
| VAB  | 7,357,316 | 12,112,443 | 11,907,655 | 17,701,291 |
| VAB_A1  | 307,461 | 409,189 | 424,580 | 593,807 |
| VAB_A2  | 2,908,089 | 4,511,800 | 4,252,191 | 5,407,826 |
| VAB_A3  | 4,121,007 | 7,138,068 | 7,230,884 | 11,779,453 |

*Cuadro 1. Estadística descriptiva para el PIB a nivel nacional, por origen del Valor Agregado Bruto*

|10% | 20% | 30% | 40% | 50% | 60% | 70% | 80% | 90%
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
|8,291,274 | 8,429,318 | 9,762,596 | 10,671,439 | 12,599,656 | 13,266,557 | 14,611,063 | 15,608,212 | 17,337,846 |

*Cuadro 2. Estimación de cuantiles de distribución en PIB*

![alt text](https://github.com/CrisTafRos/Proyecto_DS_Equipo6/raw/main/histograma_PIB.jpeg)

*Gráfico 1. Histograma de PIB, utilizando `hist()`*

![alt text](https://github.com/CrisTafRos/Proyecto_DS_Equipo6/raw/main/histograma_ggplot.jpeg)

*Gráfico 2. Histograma de PIB, utilizando `ggplot()`*

![alt text](https://github.com/CrisTafRos/Proyecto_DS_Equipo6/raw/main/correlacion_PIB_VAB1.jpeg)

*Gráfico 3. Correlación entre PIB y Valor agregado bruto por actividades primarias*

Observemos si el Producto Interno Bruto sigue una distribución normal.

Podemos notar que la media es de 175.

![alt text](https://github.com/CrisTafRos/Proyecto_DS_Equipo6/raw/main/densidadProbNorm.jpeg)

*Gráfico 4. Densidad de probabilidad normal*

![alt text](https://github.com/CrisTafRos/Proyecto_DS_Equipo6/raw/main/hist_MuestraNormal.jpeg)

*Gráfico 5. Histograma para la muestra normal*

Contraste de hipótesis:
Dada una muestra aleatoria de tamaño n = 10 de la distribución normal.
```r
# Últimos 6 elementos de nuestra muestra
    muestra
5  17313794
6  14965123
7  14812523
8  11606794
9  13077428
10 16560683
```
Formulando una regresión lineal múltiple de PIB

- Llevamos a cabo el siguiente modelo y si es necesario ajustarlo, cabe resaltar que este modelo ya esta establecido por el INEGI

Y(PIB) = beta0 + beta1 * ISPN + beta2 * VAB + beta3 * VAB_A1 + beta4 * VAB_A2 + beta5 * VAB_A3 + e
```
> m1 <- lm(PIB ~ ISPN+ VAB + VAB_A1 + VAB_A2 + VAB_A3)
> summary(m1)

Call:
lm(formula = PIB ~ ISPN + VAB + VAB_A1 + VAB_A2 + VAB_A3)

Residuals:
      Min        1Q    Median        3Q       Max 
-0.115962 -0.013043 -0.003682  0.011772  0.108759 

Coefficients: (1 not defined because of singularities)
              Estimate Std. Error    t value Pr(>|t|)    
(Intercept) -5.653e-02  1.660e-01 -3.400e-01    0.736    
ISPN         1.000e+00  6.183e-07  1.617e+06   <2e-16 ***
VAB          1.000e+00  4.742e-08  2.109e+07   <2e-16 ***
VAB_A1       2.521e-07  8.789e-07  2.870e-01    0.776    
VAB_A2      -8.498e-08  6.714e-08 -1.266e+00    0.214    
VAB_A3              NA         NA         NA       NA    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.04679 on 35 degrees of freedom
Multiple R-squared:      1,	Adjusted R-squared:      1 
F-statistic: 5.297e+16 on 4 and 35 DF,  p-value: < 2.2e-16
```
Este primer modelo indica que el R cuadrada ajustada es igual a 1, entonces es un buen modelo. Continuaremos manipulando a las variables para llegar a un modelo de 95% de exactitug y no del 100%

- Omitiendo el valor agregado bruto por actividades terciarias.

```
> m2 <- update(m1, ~.-VAB_A3)
> summary(m2)

Call:
lm(formula = PIB ~ ISPN + VAB + VAB_A1 + VAB_A2)

Residuals:
      Min        1Q    Median        3Q       Max 
-0.115962 -0.013043 -0.003682  0.011772  0.108759 

Coefficients:
              Estimate Std. Error    t value Pr(>|t|)    
(Intercept) -5.653e-02  1.660e-01 -3.400e-01    0.736    
ISPN         1.000e+00  6.183e-07  1.617e+06   <2e-16 ***
VAB          1.000e+00  4.742e-08  2.109e+07   <2e-16 ***
VAB_A1       2.521e-07  8.789e-07  2.870e-01    0.776    
VAB_A2      -8.498e-08  6.714e-08 -1.266e+00    0.214    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.04679 on 35 degrees of freedom
Multiple R-squared:      1,	Adjusted R-squared:      1 
F-statistic: 5.297e+16 on 4 and 35 DF,  p-value: < 2.2e-16
```
Después de eliminar dicha variable de las actividades terciarias, vemos que no hay cambio significativos, así que seguiremos eliminando variables que intuimos que harian cambiar el modelo:
- Omitiendo el valor agregado bruto.
```
> m3 <- update(m2, ~.-VAB)
> summary(m3)

Call:
lm(formula = PIB ~ ISPN + VAB_A1 + VAB_A2)

Residuals:
    Min      1Q  Median      3Q     Max 
-248125 -116854  -23793   78636  459269 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -1.722e+06  5.082e+05  -3.388  0.00172 ** 
ISPN         1.027e+01  1.529e+00   6.714 7.81e-08 ***
VAB_A1       8.395e+00  2.754e+00   3.048  0.00430 ** 
VAB_A2       1.299e+00  9.382e-02  13.847 5.44e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 164400 on 36 degrees of freedom
Multiple R-squared:  0.9979,	Adjusted R-squared:  0.9977 
F-statistic:  5705 on 3 and 36 DF,  p-value: < 2.2e-16
```
Este tercer modelo da como resultado una r cuadrada de **0.9977**, así que quitaremos otra variable para llegar al 95%

- Omitiendo los impuestos sobre los productos netos.
```r
> m4<- update(m3, ~.-ISPN)
> summary(m4)

Call:
lm(formula = PIB ~ VAB_A1 + VAB_A2)

Residuals:
    Min      1Q  Median      3Q     Max 
-493778 -139859   17982  140946  718779 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -5.008e+06  2.027e+05  -24.71  < 2e-16 ***
VAB_A1       2.579e+01  1.386e+00   18.61  < 2e-16 ***
VAB_A2       1.518e+00  1.302e-01   11.66 5.88e-14 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 243400 on 37 degrees of freedom
Multiple R-squared:  0.9953,	Adjusted R-squared:  0.995 
F-statistic:  3895 on 2 and 37 DF,  p-value: < 2.2e-16
```

Por lo tanto, el modelo resultante sería: `Y(PIB)= BETA0 + BETA3 * ACTIVIDADES PRIMARIAS + BETA4 * ACTIVIDADES SECUNDARIAS`
O en otros términos, `y=beta0+beta3*VAB_A2 + beta4*VAB_A3`

Ahora, asignaremos los valores de betas:
```r
beta0=-5.008e+06
beta3=2.579e+01
beta4=1.519e+00
```
