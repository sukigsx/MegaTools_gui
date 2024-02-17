#!/bin/bash

# Mostrar un cuadro de diálogo con las opciones
opciones=$(zenity --list --checklist --title="Selecciona las acciones a realizar" --column="Seleccionar" --column="Acción" \
    FALSE "Actualizar paquetes (sudo apt update)" \
    FALSE "Actualizar e instalar paquetes (sudo apt upgrade)" \
    FALSE "Mostrar uso de memoria (free)" \
    --separator="|")

# Verificar si se seleccionaron acciones
if [ -z "$opciones" ]; then
    zenity --error --text="No se seleccionó ninguna acción."
    exit 1
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
    esac
done

exit 0
