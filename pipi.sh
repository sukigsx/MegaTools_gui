#!/bin/bash

while :
do
# Mostrar un cuadro de diálogo con las opciones restantes
opciones=$(zenity --list --checklist --title="Selecciona las acciones a realizar" --column="Seleccionar" --column="Acción" \
    FALSE "Actualizar e instalar paquetes (sudo apt upgrade)" \
    FALSE "Mostrar uso de memoria (free)" \
    --separator="|" \
    --extra-button="Salir sin prguntar")

# Verificar si se seleccionaron acciones
if [ -z "$opciones" ]; then
    zenity --error --text="No se seleccionó ninguna acción."
fi

# Recorrer las acciones seleccionadas y ejecutar los comandos correspondientes
IFS="|"
read -ra seleccionados <<< "$opciones"
for opcion in "${seleccionados[@]}"; do
    case "$opcion" in
        "Actualizar e instalar paquetes (sudo apt upgrade)")
            sudo apt upgrade;;
        "Mostrar uso de memoria (free)")
            free;;
	"Salir sin preguntar")
	    echo "salir sin preguntar"; read p; exit
	    ;;
    esac
done
done
