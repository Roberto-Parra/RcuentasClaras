ui <- fluidPage(title="Cuentas Claras",
        theme = bslib::bs_theme(version = 4, bootswatch = "minty"),
        includeCSS("www/style.css"),
        useShinyalert(),
        titlePanel(h1(id="title","Cuentas Claras", align = "center")),
        column(12,align="center",h5("!!!Bienvenido a CuentasClaras!!")),
        column(12,align="center",h5("La unica aplicación que te permite organizar actividades con tus amigos de forma justa")),
        column(12,br()),
        column(12,
               tags$div(
                        class = "d-flex justify-content-center",
                        column(4,botonUI('bt1','Añadir Actividad',icon=icon('plus-circle'),width = "70%")),
                        column(4,br()),
                        column(4,botonUI('bt2','Ver Viajeros',icon=icon('users'),width = "70%"))
                )),
        column(12,br()),
        column(12,DTOutput("actividades"))
        )