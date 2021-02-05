# Proyecto_DS_Equipo6
## Integrantes Equipo 6
- Flores Nogueira Diego David
- González Toleto Atzimba Alejandra
- Mendoza Martínez Arturo
- Tafolla Rosales Cristian
## Introducción
Una forma de poder visualizar el progreso de la economía de cualquier nación tomará siempre como referencia el cálculo del Producto Interno Bruto (PIB), indicador que ilustra el valor total de los bienes y servicios finales producidos en un país.
Las organizaciones toman tanto los datos históricos como los pronósticos del PIB para poder tomar decisiones para expandir sus actividades o saber si es conveniente invertir en cierta nación. Por esta razón decidimos profundizar en materia para poder hacer un análisis descriptivo de los registros anuales nacionales, entender su comportamiento y hacer una proyección a partir de dicha información
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

*Gráfico 1. Histograma de PIB*
