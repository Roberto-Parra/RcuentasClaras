botonUI<-function(id,label="Botón",icon=NULL,width=NULL){
        actionButton(NS(id,"but"),label=label,icon=icon,width = width)
}
textoUI<-function(id,label="Texto"){
        textInput(NS(id,"tx"),label=label,width = "100%")
}
ModalUI<-function(){
        showModal(modalDialog(
                title = "Viajeros",
                column(12,DTOutput("viajeros")),
                #textoUI("nact","Nombre"),
                footer = tagList(
                        modalButton("Volver",icon=icon('arrow-circle-left')),
                        botonUI('bt4',"Añadir Viajero",width = NULL,icon=icon('plus-circle'))
                )
        ))
}