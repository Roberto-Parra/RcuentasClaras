server <- function(input, output) {
        df<-reactiveValues()
        df$reload<-NULL
        
##### Agregar actividad #########
observeEvent(input$`bt1-but`, {
                showModal(modalDialog(
                        title = "Nueva Actividad",
                        textoUI("nact","Nombre"),
                        footer = tagList(
                                botonUI('bt3',"Guardar",width = NULL),
                                modalButton("Cancelar")
                        )
                ))
                
        })
####### Ver Viajeros #########
observeEvent(input$`bt2-but`, {ModalUI()})
        tablavi<-reactive({
                reload<-df$reload
                db <- dbConnect(SQLite(), "./data/cuentasclaras.sqlite")
                casos<-dbReadTable(db, "Viajeros")
                RSQLite::dbDisconnect(db)
                return(casos)
        })
output$viajeros <- DT::renderDT({
        dt<-datatable(tablavi(),
                      colnames=c("Nombre","Apellido"),
                      rownames = FALSE,
                      class='display compact cell-border',
                      selection='none',
                      escape=F,
                      options=list(
                              deferRender=TRUE,
                              dom = 'tp',
                              pageLength = 10,
                              ordering=FALSE,
                              columnDefs = list(list(visible=FALSE,targets=c(0)))
                              )
                )})
######## Guardar Nuevo Viajero #############
observeEvent(input$`bt4-but`,{
        showModal(modalDialog(
                title = "Nuevo Viajero",
                textoUI("nviaj","Nombre"),
                textoUI("napel","Apellido"),
                footer = tagList(
                        botonUI('bt5',"Guardar",width = NULL),
                        botonUI('bt6',"Cancelar",width = NULL)
                        )
                ))
        })        
observeEvent(input$`bt5-but`,{
        req(input$`nviaj-tx`,input$`napel-tx`)
        data<-data.frame(nombre=input$`nviaj-tx`,apellidos=input$`napel-tx`)
        db <- dbConnect(SQLite(), dbname="./data/cuentasclaras.sqlite")
        dbWriteTable(db,"Viajeros",data,append=TRUE)
        dbDisconnect(db)
        removeModal(session = getDefaultReactiveDomain())
        df$reload<-rnorm(1,10)
        ModalUI()
        })
observeEvent(input$`bt6-but`,{
        removeModal(session = getDefaultReactiveDomain())
        ModalUI()
        })        
######## Guardar Nueva Actividad #############
observeEvent(input$`bt3-but`,{
        req(input$`nact-tx`)
        data<-data.frame(nombre=input$`nact-tx`)
        db <- dbConnect(SQLite(), dbname="./data/cuentasclaras.sqlite")
        dbWriteTable(db,"Actividades",data,append=TRUE)
        dbDisconnect(db)
        shinyalert("Ok!", "Actividad Ingresada", type = "success",closeOnClickOutside = TRUE)
        removeModal(session = getDefaultReactiveDomain())
        df$reload<-rnorm(1,10)
        })

######## Mostrar Tabla Actividad #############        
tabla<-reactive({
        reload<-df$reload
        db <- dbConnect(SQLite(), "./data/cuentasclaras.sqlite")
        casos<-dbReadTable(db, "Actividades")
        RSQLite::dbDisconnect(db)
        return(casos)
        })
        
output$actividades <- DT::renderDT({
        dt<-datatable(tabla(),
                      colnames=c("Actividades","id"),
                      rownames = FALSE,
                      class='display compact cell-border',
                      selection='none',
                      escape=F,
                      options=list(
                              deferRender=TRUE,
                              dom = 'tp',
                              pageLength = 10,
                              ordering=FALSE,
                              columnDefs = list(list(visible=FALSE,targets=c(0,2)))
                              )
                              )})
}