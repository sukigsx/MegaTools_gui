#!/bin/bash
ruta_ejecucion=$(dirname "$(readlink -f "$0")")

version="1.001154yt454ll0"
#software necesarios para la ejecucion del programa
software="which git diff ping figlet nano neofetch lsblk ethtool zenity wget gdebi find curl"

#colores
#ejemplo: echo -e "${verde} La opcion (-e) es para que pille el color.${borra_colores}"

rojo="\e[0;31m\033[1m" #rojo
verde="\e[;32m\033[1m"
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
rosa="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
borra_colores="\033[0m\e[0m" #borra colores

conexion(){
if ping -c1 google.com &>/dev/null
then
    var_conexion="SI"
else
    var_conexion="NO"
    var_actualizado="No hay conexion a internet"
fi
}

software_necesario_zenity(){
echo -e "\n- MegaTools -"
var_software="NO"
echo -e "\n Actualizando repositorios y verificando software necesario:\n"

# Inicializar el contador de intentos
    attempts=0

# Bucle para solicitar la contraseña hasta tres intentos
while [ $attempts -lt 3 ]; do
    # Solicitar la contraseña del usuario actual utilizando Zenity
    PASSWORD=$(zenity --entry --hide-text --text="Ingrese tu contraseña" --title="Contraseña de usuario. - MegaTools -" --width=450 --height=100)

    # Verificar si se ha cancelado la entrada de la contraseña
    if [ $? -ne 0 ]; then
        # Salir del script si se ha cancelado
        exit
    fi

    # Verificar la contraseña utilizando el comando sudo
    echo "$PASSWORD" | sudo -S ls /root >/dev/null 2>&1

    # Verificar el código de salida del comando sudo
    if [ $? -eq 0 ]; then
        # Contraseña correcta
        zenity --info --title="Contraseña de usuario. - MegaTools -" --text="La contraseña es correcta."
        break
    else
        # Contraseña incorrecta
        let "attempts+=1"
        if [ $attempts -lt 3 ]; then
            zenity --error --title="" --text="La contraseña es incorrecta. Inténtelo de nuevo."
        else
            zenity --error --title="Contraseña de usuario. - MegaTools -" --text="Se han superado los tres intentos. Saliendo del script."
            exit
        fi
    fi
done

sudo apt update 2>/dev/null 1>/dev/null 0>/dev/null
for paquete in $software
do
which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
sino=$? #recojemos el 0 o 1 del resultado de which
contador="1" #ponemos la variable contador a 1
    while [ $sino -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
    do
        if [ $contador = "4" ] || [ $conexion = "no" ] 2>/dev/null 1>/dev/null 0>/dev/null #si el contador es 4 entre en then y sino en else
        then #si entra en then es porque el contador es igual a 4 y no ha podido instalar o no hay conexion a internet
            echo ""
            echo -e " NO se ha podido instalar $paquete."
            echo -e " Intentelo usted con las ordenes: (sudo apt update y sudo apt install $paquete )"
            echo -e ""
            echo -e " No se puede ejecutar el script sin el software necesario."
            exit
        else #intenta instalar

            echo " Instalando $paquete. Intento $contador/3."
            sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null
            let "contador=contador+1" #incrementa la variable contador en 1
            which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
            sino=$? ##recojemos el 0 o 1 del resultado de which
        fi
    done
echo -e " [ok] $paquete."
var_software="SI"
done
echo -e "\n Terminada la verificacion de software.\n Todo el software = [OK]\n"
}

software_necesario(){
clear
echo -e "\n- MegaTools -"
var_software="NO"
echo -e "\n Actualizando repositorios y verificando software necesario:\n"
sudo apt update 2>/dev/null 1>/dev/null 0>/dev/null
for paquete in $software
do
which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
sino=$? #recojemos el 0 o 1 del resultado de which
contador="1" #ponemos la variable contador a 1
    while [ $sino -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
    do
        if [ $contador = "4" ] || [ $conexion = "no" ] 2>/dev/null 1>/dev/null 0>/dev/null #si el contador es 4 entre en then y sino en else
        then #si entra en then es porque el contador es igual a 4 y no ha podido instalar o no hay conexion a internet
            clear
            echo ""
            echo -e " ${amarillo}NO se ha podido instalar ${rojo}$paquete${amarillo}.${borra_colores}"
            echo -e " ${amarillo}Intentelo usted con las ordenes: (${borra_colores}sudo apt update y sudo apt install $paquete ${amarillo})${borra_colores}"
            echo -e ""
            echo -e " ${rojo}No se puede ejecutar el script sin el software necesario.${borra_colores}"
            exit
        else #intenta instalar
            echo " Instalando $paquete. Intento $contador/3."
            sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null
            let "contador=contador+1" #incrementa la variable contador en 1
            which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
            sino=$? ##recojemos el 0 o 1 del resultado de which
        fi
    done
echo -e " [${verde}ok${borra_colores}] $paquete."
var_software="SI"
done
echo -e "\n Terminada la verificacion de software.\n Todo el software = [${verde}OK${borra_colores}]\n"
}

software_necesario_sino(){
#esta funcion recorree el software para comprobar si esta todo instalado.
#si es correcto ejecuta el programa comprobando si hay actualizaciones.
#si no hay conexion permite ejecutar el programa.
for paquete in $software
do
which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
    if [ $? = 0 ]; then
        var_software="SI"
    else
        var_software="NO"
        break
    fi
done
}

actualizar_script(){
archivo_local="megatools.sh" # Nombre del archivo local
ruta_repositorio="https://github.com/sukigsx/MegaTools_gui.git" #ruta del repositorio para actualizar y clonar con git clone

# Obtener la ruta del script
descarga=$(dirname "$(readlink -f "$0")")
git clone $ruta_repositorio /tmp/comprobar >/dev/null 2>&1

diff $descarga/$archivo_local /tmp/comprobar/$archivo_local >/dev/null 2>&1


if [ $? = 0 ]
then
    chmod -R +w /tmp/comprobar
    rm -R /tmp/comprobar
else
    cp -r /tmp/comprobar/* $descarga
    chmod -R +w /tmp/comprobar
    rm -R /tmp/comprobar
    echo -e "\n¡ Nueva version de MegaTools disponible.!\n"
    echo -e " Se procede a su actualizacion automatica.\n"
    echo -e " Es necesario reiniciar MegaTools.\n"
    exit
    salir="SI"
fi



## Obtener la ruta del script
#descarga=$(dirname "$(readlink -f "$0")")
#cd $descarga
##git fetch origin >/dev/null 2>&1
#git reset --hard origin/main >/dev/null 2>&1
#echo -e "\n¡ Nueva version de MegaTools disponible.!\n"
#echo -e " Se procede a su actualizacion automatica.\n"
#echo -e " Es necesario reiniciar MegaTools.\n"
#exit
#salir="SI"
}

comprobar_actualizacion_sino(){

archivo_local="megatools.sh" # Nombre del archivo local
ruta_repositorio="https://github.com/sukigsx/MegaTools_gui.git" #ruta del repositorio para actualizar y clonar con git clone

# Obtener la ruta del script
descarga=$(dirname "$(readlink -f "$0")")
git clone $ruta_repositorio /tmp/comprobar >/dev/null 2>&1

diff $descarga/$archivo_local /tmp/comprobar/$archivo_local >/dev/null 2>&1


if [ $? = 0 ]
then
    var_actualizado="SI"
    chmod -R +w /tmp/comprobar
    rm -R /tmp/comprobar
else
    var_actualizado="NO"
    chmod -R +w /tmp/comprobar
    rm -R /tmp/comprobar
fi
}

#ejecuto la funcion para comprobar si esta el software necesario instalado.
#si esta instalado ejecuta el programa y listo.
#si no esta instalado, entonces entra en el if y comprueba la conexion a internet y todo lo demas.
software_necesario_sino
if [ "$var_software" = "NO" ]; then
    conexion
        if [ $var_conexion = "SI" ]; then
            if which zenity >/dev/null 2>&1; then
                software_necesario_zenity | zenity --text-info --title="Software necesario - MegaTools -" --auto-scroll --font="DejaVu Sans Mono" --width=700 --height=450

                if [ "$var_software" = "SI" ]; then
                    actualizar_script | zenity --text-info --title="Actualizacion - MegaTools -" --auto-scroll --font="DejaVu Sans Mono" --width=700 --height=450
                fi
            else
                software_necesario
                actualizar_script
            fi
        else
             if which zenity>/dev/null 2>&1; then

                zenity --info --title="- MegaTools -" --text="\n Verificando software necesario = $var_software.\n Conexion a internet = $var_conexion.\n No se puede ejecutar el script sin el software necesario.\n" --width=400 --height=150
                salir="SI"
            else
                clear
                echo ""
                echo -e "${verde} - MegaTools -${borra_colores}"
                echo ""
                echo -e "\n Verificando software necesario = ${rojo}$var_software${borra_colores}."
                echo -e "\n Conexion a internet = ${rojo}$var_conexion${borra_colores}."
                echo ""
                echo -e "${amarillo} No se puede ejecutar el script sin el software necesario.\n${borra_colores}"
                exit
            fi
        fi
    else
        var_software="SI"
fi

conexion
if [ $var_conexion = "SI" ]; then
    comprobar_actualizacion_sino
    if [ $var_actualizado = "NO" ]; then
        actualizar_script | zenity --text-info --title="Actualizacion - MegaTools -" --auto-scroll --font="DejaVu Sans Mono" --width=600 --height=450
        if [ $salir="SI" ]; then
            exit
        fi
    fi
fi

if [ "$salir" = "SI" ]; then
    exit
fi

if [ "$var_software" = "NO" ]; then
    exit
fi

# Muestrael el menú principal
while :
do
    opcion=$(zenity --list --title="- MegaTools -" \
    --text=" Version de MegaTools = $version\n Conexion a internet = $var_conexion\n software necesario para el correcto funcionamiento = $var_software\n Script esta actualizado = $var_actualizado\n\nInformacion de SUKIGSX: \n Correo electronico = scripts@mbbsistemas.es\n Pagina web = https://repositorio.mbbsistemas.es\n" \
    --column "Opciones del menu principal:" --column="Descripcion." \
    "UTILIDADES PARA EL SISTEMA" "" \
    "Crear lanzadores" "Crea o borra los lanzadores en tu escritorio." \
    "Instalacion de software" "Script para instalar programas en tu sistema." \
    "" "" \
    "INFORMACION DE TU SISTEMA" "" \
    "Informacion general" "Te da la informacion mas importante de tu sistema" \
    "Informacion de ips Lan/Wan" "Te da la informacion de ip publica y de tu red" \
    "Informacion de discos" "Informacion de el uso de tus discos del sistema" \
    "Informacion memoria ram" "Pues la informacion del uso de la memoria del sistema" \
    "Informacion dispositivos de red" "Te la la informacion de tus tarjetas de red" \
    --width=650 \
    --height=650 \
    --ok-label="Aceptar" \
    --cancel-label="Salir" \
    --extra-button="Web Sukigsx" \
    --extra-button="Ayuda")

    # Manejar la opción seleccionada
    case $opcion in
        "UTILIDADES PARA EL SISTEMA")
            zenity --error --title="- MegaTools -" --text="Selecciona una opcion de UTILIDADES PARA TU SISTEMA."
            ;;

            "Instalacion de software")
                bash $ruta_ejecucion/Megatools/InstalacionDeSoftware/InstalacionDeSoftware
                ;;

            "Crear lanzadores")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash $ruta_ejecucion/Megatools/CrearLanzadores/CrearLanzadores
                ;;

        "INFORMACION DE TU SISTEMA")
            zenity --error --title="- MegaTools -" --text="Selecciona una opcion de INFORMACION DE TU SISTEMA."
            ;;

            "Informacion general")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash $ruta_ejecucion/Megatools/InformacionGeneral/InformacionGeneral
                ;;

            "Informacion de ips Lan/Wan")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash $ruta_ejecucion/Megatools/InformacionDeIpsLanWan/InformacionDeIpsLanWan
                ;;

            "Informacion de discos")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash $ruta_ejecucion/Megatools/InformacionDeDiscos/InformacionDeDiscos
                ;;

            "Informacion memoria ram")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash $ruta_ejecucion/Megatools/InformacionMemoriaRam/InformacionMemoriaRam
                ;;

            "Informacion dispositivos de red")
                #mete el pid del proceso a un archivo para poder matar este script desde otro
                echo $$ > /tmp/ProcesoPidDeMegatools
                bash $ruta_ejecucion/Megatools/InformacionDispositivosDeRed/InformacionDispositivosDeRed
                ;;

        "Web Sukigsx")
            zenity --text-info --title="Web de Sukigsx, Diseñador de MegaTools" --html --url="https://repositorio.mbbsistemas.es" --ok-label="Salir" --cancel-label="Atras" --width=10000 --height=10000 2>/dev/null
            if [ $? = 0 ]; then
                zenity --question --title="- MegaTools -" --text="¿ Estás seguro de que deseas salir ?" --cancel-label="No" --ok-label="Si" --width=300
                if [ $? -eq 0 ]; then
                    exit 0
                fi
            fi
            ;;

        "Ayuda")
            zenity --text-info --title="Ayuda - MegaTools -" --filename=$ruta_ejecucion/Megatools/AyudaPrincipal --font="DejaVu Sans Mono" --width=650 --height=650
            ;;

        *)
            if [ $? -eq 0 ]; then
                zenity --error --title="- Megatools -" --text="No has seleccionado ninguna opcion del menu." --width=300
            else
                zenity --question --title="- MegaTools -" --text="¿ Estás seguro de que deseas salir ?" --cancel-label="No" --ok-label="Si" --width=300
                if [ $? -eq 0 ]; then
                    exit 0
                fi
            fi
            ;;
    esac
done
