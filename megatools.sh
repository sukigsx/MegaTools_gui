#!/bin/bash



titulo="MegaTools"

# Muestrael el menú principal
while :
do
    opcion=$(zenity --list --title="MegaTools ( Diseñado por SUKIGSX )" \
    --text="Informacion relacionada al Megatools :\n Conexion a internet = $var_conexion\n software necesario para el correcto funcionamiento = $var_software\n Script esta actualizado = $var_actualizado\n\nInformacion de SUKIGSX: \n Correo electronico = scripts@mbbsistemas.es\n Pagina web = https://repositorio.mbbsistemas.es\n" \
    --column "Opciones del menu principal:" --column="Descripcion." \
    "UTILIDADES PARA EL SISTEMA" "" \
    "Crear/Borrar lanzador" "Te crea o brra el lanzador de tu escritorio." \
    "Instalacion de software" "Script para instalar programas en tu sistema." \
    "" "" \
    "INFORMACION DE TU SISTEMA" "" \
    "Informacion general" "Te da la informacion mas importante de tu sistema" \
    "Informacion de ips Lan/Wan" "Te da la informacion de ip publica y de tu red" \
    "Informacion de discos" "Informacion de el uso de tus discos del sistema" \
    "Informacion memoria ram" "Pues la informacion del uso de la memoria del sistema" \
    "Informacion dispositivos de red" "Te la la informacion de tus tarjetas de red" \
    "" "" \
    --width=650 \
    --height=650 \
    --ok-label="Aceptar" \
    --cancel-label="Salir" \
    --extra-button="Web Sukigsx" \
    --extra-button="Ayuda")

    # Manejar la opción seleccionada
    case $opcion in
        "UTILIDADES PARA EL SISTEMA")
            zenity --error --title="$titulo" --text="Selecciona una opcion de UTILIDADES PARA TU SISTEMA."
            ;;

            "Instalacion de software")
                bash InstalacionDeSoftware
                ;;

            "Crear/Borrar lanzador")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash CrearBorrarLanzador
                ;;

        "INFORMACION DE TU SISTEMA")
            zenity --error --title="$titulo" --text="Selecciona una opcion de INFORMACION DE TU SISTEMA."
            ;;

            "Informacion general")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash InformacionGeneral
                ;;

            "Informacion de ips Lan/Wan")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash InformacionDeIpsLanWan
                ;;

            "Informacion de discos")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash InformacionDeDiscos
                ;;

            "Informacion memoria ram")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash InformacionMemoriaRam
                ;;

            "Informacion dispositivos de red")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash InformacionDispositivosDeRed
                ;;

        "Web Sukigsx")
            zenity --text-info --title="Web de Sukigsx, Diseñador de $titulo" --html --url="https://repositorio.mbbsistemas.es" --ok-label="Salir" --cancel-label="Atras" --width=10000 --height=10000 2>/dev/null
            if [ $? = 0 ]; then
                zenity --question --title="$titulo" --text="¿ Estás seguro de que deseas salir ?" --cancel-label="No" --ok-label="Si" --width=300
                if [ $? -eq 0 ]; then
                    exit 0
                fi
            fi
            ;;

        "Ayuda")
            zenity --text-info --title="Ayuda - $titulo" --filename=Ayuda --font="DejaVu Sans Mono" --width=650 --height=650
            ;;

        *)
            if [ $? -eq 0 ]; then
                zenity --error --title="$titulo" --text="No has seleccionado ninguna opcion del menu." --width=300
            else
                zenity --question --title="$titulo" --text="¿ Estás seguro de que deseas salir ?" --cancel-label="No" --ok-label="Si" --width=300
                if [ $? -eq 0 ]; then
                    exit 0
                fi
            fi
            ;;
    esac
done
