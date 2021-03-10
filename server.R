server <- function(input, output) {
        df<-reactiveValues()
        df$reload<-NULL
        
        ##### Agregar actividad #########
        observeEvent(input$`bt1-but`, {
                showModal(modalDialog(
                        title = "Nueva Actividad",
                        textoUI("nact","Nombre"),
                        footer = tagList(
                                #actionButton("ok", "Guardar"),
                                botonUI('bt3',"Guardar",width = NULL),
                                modalButton("Cancelar")
                        )
                ))
                
        })
        ####### Ver Viajeros #########
        observeEvent(input$`bt2-but`, {
                showModal(modalDialog(
                        title = "Viajeros",
                        #textoUI("nact","Nombre"),
                        footer = tagList(
                                modalButton("Volver",icon=icon('arrow-circle-left')),
                                botonUI('bt4',"Añadir Viajero",width = NULL,icon=icon('plus-circle'))
                        )
                ))
                
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
                              #filter = 'top',
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