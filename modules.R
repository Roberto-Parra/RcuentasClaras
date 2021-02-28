botonUI<-function(id,label="Botón",icon=NULL,width=NULL){
        actionButton(NS(id,"but"),label=label,icon=icon,width = width)
}
textoUI<-function(id,label="Texto"){
        textInput(NS(id,"tx"),label=label,width = "100%")
}