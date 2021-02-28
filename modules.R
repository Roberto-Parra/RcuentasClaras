botonUI<-function(id,label="Botón",icon=NULL){
        actionButton(NS(id,"but"),label=label,icon=icon,width = "70%")
}
textoUI<-function(id,label="Texto"){
        textInput(NS(id,"tx"),label=label)
}