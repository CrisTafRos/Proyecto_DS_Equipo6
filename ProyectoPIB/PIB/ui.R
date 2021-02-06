

shinyUI(fluidPage(
    
    dashboardPage(
        
        dashboardHeader(title = "PIB de México"),
        
        dashboardSidebar(
            
            sidebarMenu(
                menuItem("¿Qué es el PIB?", tabName = "info", icon = icon("question-circle")),
                menuItem("Gráfico del PIB", tabName = "graph", icon = icon("line-chart")),
                menuItem("Predicción", tabName = "pred", icon = icon("arrow-circle-right")),
                menuItem("Análisis", tabName = "analisis", icon = icon("file-picture-o")),
                menuItem("Base de datos", tabName = "base", icon = icon("database"))
            )
            
        ),
        
        dashboardBody(
            
            tabItems(
                
                tabItem( tabName = "info",
                         fluidRow(
                             titlePanel(h2("¿Qué es el PIB?", align="center")),
                             p("El Producto Interno Bruto (PIB) es un indicador utilizado para medir 
                             el desarrollo económico de un país. Se calcula sumando el valor de todos 
                             los bienes, servicios e inversiones que se producen en el país durante un 
                               año.", align="justify"),
                             p("El PIB contabiliza sólo los bienes y servicios finales lo que implica 
                         que no se añaden los bienes que contribuyen a la elaboración del producto 
                         definitivo. Tampoco se contabilizan los productos de segunda mano con varios 
                         años de antigüedad vendidos durante ese ejercicio puesto que estos se 
                         contabilizaron cuando fueron producidos.", align="justify"),
                             p("Usualmente el PIB se exprese en porcentaje de crecimiento o disminución 
                           respecto al año anterior (tasa de crecimiento del PIB).", align="justify"),
                             p("El creciento positivo significa que habrá más inversión en edificios, 
                           casas o maquinaria y que se producirán más bienes y servicios. Esto es 
                           beneficioso para todos porque habrá más empleo y más oportunidades para 
                           hacer negocios. Por el contrario, si es negativo, durante un periodo 
                           determinado, la producción y actividad económica del país no aumentará y 
                           estará en recesión. En estas condiciones, es probable que haya más 
                           desempleo.", align="justify"),
                            
                             img( src = "imagen_pib.jpg", 
                                  height = 350, width = 350,)
                         )
                    
                ),
                
                tabItem(tabName = "graph",
                        fluidRow(        
                            titlePanel(h2("Gráfico del PIB")),
                            box(plotOutput("distPlot")),
                            box( sliderInput("fecha",
                                             "Año",
                                             min = 1980,
                                             max = 2019,
                                             value = 1990)
                            )
                        )
                ),
                
                tabItem( tabName = "pred",
                         fluidRow(
                             titlePanel(h2("Predicción del PIB basado en la tendencia")),
                             img( src = "prediccion.png", 
                                  height = 368, width = 452)
                         )
                ),
                tabItem( tabName = "analisis",
                         fluidRow(
                             titlePanel(h2("Análisis de los datos")),
                             img( src = "hist_pib.png", 
                                  height = 368, width = 452),
                             img( src = "hist_mnom.png", 
                                  height = 368, width = 452)
                         )
                ),
                tabItem( tabName = "base",
                         fluidRow(
                             titlePanel(h2("Data Table")),
                             dataTableOutput("base")
                         )
                )
                
            )
        )
    )
)
)