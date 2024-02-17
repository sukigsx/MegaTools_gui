#!/bin/bash

# Definir las opciones
opcion1="Actualizar paquetes (sudo apt update)"
opcion2="Actualizar e instalar paquetes (sudo apt upgrade)"
opcion3="Mostrar uso de memoria (free)"

# Mostrar un cuadro de diálogo con las opciones
respuesta=$(zenity --forms --title="Selecciona las acciones a realizar" --text="Selecciona las acciones que deseas realizar:" \
    --add-list="Seleccione una acción:" --list-values="$opcion1|$opcion2|$opcion3" \
    --add-entry="" --entry-text="Puedes ver 'Actualizar paquetes (sudo apt update)' pero no seleccionarlo" \
    --separator="|" --column="Acción")

# Verificar si se seleccionaron acciones
if [ -z "$respuesta" ]; then
    zenity --error --text="No se seleccionó ninguna acción."
    exit 1
fi

# Recorrer las acciones seleccionadas y ejecutar los comandos correspondientes
IFS="|"
read -ra seleccionados <<< "$respuesta"
for seleccionado in "${seleccionados[@]}"; do
    case "$seleccionado" in
        "$opcion1")
            # No hacemos nada, ya que esta opción no es seleccionable
            ;;
        "$opcion2")
            sudo apt upgrade;;
        "$opcion3")
            free;;
    esac
done

exit 0
