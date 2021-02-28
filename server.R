server <- function(input, output) {
        df<-reactiveValues()
        df$reload<-NULL
        
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
        observeEvent(input$`bt3-but`,{
                req(input$`nact-tx`)
                data<-data.frame(nombre=input$`nact-tx`,Vigencia=0)
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
        
        #df <- reactiveVal(NULL)
        
        
        # df <- reactiveVal({
        #         db <- dbConnect(SQLite(), "./data/cuentasclaras.sqlite")
        #         casos<-dbReadTable(db, "Actividades")
        #         RSQLite::dbDisconnect(db)
        #         return(casos)
        #         
        # }
                
                # tibble(
                #         Name = c('Dilbert', 'Alice', 'Wally', 'Ashok', 'Dogbert'),
                #         Motivation = c(62, 73, 3, 99, 52),
                #         Actions = shinyInput(
                #                 FUN = actionButton,
                #                 n = 5,
                #                 id = 'button_',
                #                 label = "Fire",
                #                 onclick = 'Shiny.setInputValue(\"select_button\", this.id, {priority: \"event\"})'
                #         )
                # )
        #)
        
        output$actividades <- DT::renderDT({
                
                dt<-datatable(tabla(),
                              colnames=c("Actividades0","Actividades"),
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
                                      columnDefs = list(
                                      #         list(className = 'dt-center',targets=c(1:3,5:9))
                                                list(visible=FALSE,targets=c(0,2,3,4))
                                      #         ,list(targets = c(2,5:9),width = '70px')
                                      #         ,list(targets = c(1,3),width = '100px')
                                      #         ,list(targets = 4,width = '525px')
                                       )
                              )
                              
                              
                              
                              )
        #         
        #         df()
        #         
        # },escape = FALSE,selection = 'none'
        })
        
        
}