#!/bin/bash


while :
do
# Mostrar un cuadro de diálogo con las opciones
opciones=$(zenity --list --checklist --title="Selecciona las acciones a realizar" --column="Seleccionar" --column="Acción" --column="Descripcion" \
    FALSE "NAVEGADORES" "Si seleccionas esta, instalara todos los navegadores" \
    FALSE "AUDIO - VIDEO" "" \
    FALSE "ENTORNOS GRAFICOS LINUX" "" \
    FALSE "UTILIDADES" "" \
    FALSE "OFIMATICA" "" \
    FALSE "SERVIDORES" "" \
    FALSE "GESTOR DE PAQUETES" "" \
    FALSE "PARA TU TERMINAL" "" \
    FALSE "DISCOS" "" \
    FALSE "JUEGOS" "" \
    FALSE "SEGURIDAD" "" \
    FALSE "MENSAJERIA" "" \
    FALSE "Actualizar paquetes (sudo apt update)" "" \
    FALSE "Actualizar e instalar paquetes (sudo apt upgrade)" "" \
    FALSE "Mostrar uso de memoria (free)" "" \
    --width=850 \
    --height=650 \
    --ok-label="Aceptar" \
    --cancel-label="Atras" \
    --extra-button="Ayuda instalacion software" \
    --extra-button="Salir in confitmar" \
    --separator="|")

#Verificar si se seleccionaron acciones
if [ $? -eq 0 ]; then
    zenity --error --title="MegaTools ( Diseñado por SUKIGSX )" --text="No has seleccionado ninguna opcion del menu." --width=300
else
    zenity --question --title="MegaTools ( Diseñado por SUKIGSX )" --text="¿ Estás seguro de que deseas salir ?" --cancel-label="No" --ok-label="Si" --width=300
    if [ $? -eq 0 ]; then
        exit 0
    fi
fi



# Recorrer las acciones seleccionadas y ejecutar los comandos correspondientes
IFS="|"
read -ra seleccionados <<< "$opciones"
for opcion in "${seleccionados[@]}"; do
    case "$opcion" in
        "Actualizar paquetes (sudo apt update)")
            sudo apt update;;
        "Actualizar e instalar paquetes (sudo apt upgrade)")
            sudo apt upgrade;;
        "Mostrar uso de memoria (free)")
            free;;
        "Salir in confitmar")
            echo "uuuuuuuuuuuuuuuuuuuuuuuuuuu"; read p
            ;;
        "Ayuda instalacion software")
            zenity --text-info --title="Ayuda - MegaTools" --filename=AyudaInstalacionSoftware --font="DejaVu Sans Mono" --width=650 --height=650
            ;;
    esac
done

done
exit
