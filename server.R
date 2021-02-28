server <- function(input, output) {
        observeEvent(input$`bt1-but`, {
                showModal(modalDialog(
                        title = "Nueva Actividad",
                        textoUI("nact","Nombre")
                ))
                
        })
        
        
}