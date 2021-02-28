ui <- fluidPage(theme = bslib::bs_theme(version = 4, bootswatch = "minty"),
                includeCSS("www/style.css"),
                titlePanel(h1(id="title","Cuentas Claras", align = "center")),
                
                column(12,align="center",h4("!!!Bienvenido a CuentasClaras!!")),
                column(12,align="center",h4("La unica aplicación que te permite organizar actividades con tus amigos de forma justa")),
                mainPanel(
                        
                )
                
                )