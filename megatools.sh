#!/bin/bash

#toma el control al pulsar control + c
trap ctrl_c INT
function ctrl_c()
{
clear
figlet -c Gracias por
figlet -c utilizar mi
figlet -c script
wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
exit
}

z_rojo='<span foreground="red">' #rerror peligro
z_azul_chillon='<span foreground="blue">'
z_verde='<span foreground="green">' #general
z_amarillo_chillon='<span foreground="yellow">' #avisos
z_rosa='<span foreground="magenta">'
z_turquesa='<span foreground="turquoise">'
z_amarillo='<span foreground="gold">'
z_fin='</span>'

conexion(){
if ping -c1 google.com &>/dev/null
then
    #echo ""
    #echo -e " Conexion a internet [${verde}ok${borra_colores}]."
    var_conexion="SI"
    #echo ""
else
    #echo ""
    #echo -e " Conexion a internet [${rojo}ko${borra_colores}]."
    var_conexion="NO"
    echo ""
fi
}

software_necesario_terminal(){
var_software="NO"
echo -e " Verificando software necesario:"
software="which git diff ping figlet zenity neofetch lsblk ethtool" #ponemos el foftware a instalar separado por espacion dentro de las comillas ( soft1 soft2 soft3 etc )
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
            echo -e " ${amarillo}Intentelo usted con la orden: (${borra_colores}sudo apt install $paquete ${amarillo})${borra_colores}"
            echo -e ""
            echo -e " ${rojo}No se puede ejecutar el script sin el software necesario.${borra_colores}"
            read pause
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
}

software_necesario_zenity(){
var_software="NO"
echo -e " Verificando software necesario:\n"
software="which git diff ping figlet zenity neofetch lsblk ethtool nano popopopo" #ponemos el foftware a instalar separado por espacion dentro de las comillas ( soft1 soft2 soft3 etc )
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
            echo -e " Intentelo usted con la orden: (sudo apt install $paquete )"
            echo -e ""
            echo -e " No se puede ejecutar el script sin el software necesario."
            exit
        else #intenta instalar
            if sudo -n true 2>&1; then
                echo ""
            else
                contraseña_sudo_zenity
            fi
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
}

contraseña_sudo_zenity(){
# Inicializar el contador de intentos
attempts=0

# Bucle para solicitar la contraseña hasta tres intentos
while [ $attempts -lt 3 ]; do
    # Solicitar la contraseña del usuario actual utilizando Zenity
    PASSWORD=$(zenity --password --title="Ingrese su contraseña")

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
        zenity --info --title="Contraseña Correcta" --text="La contraseña es correcta."
        #exit
        break
    else
        # Contraseña incorrecta
        let "attempts+=1"
        if [ $attempts -lt 3 ]; then
            zenity --error --title="Contraseña Incorrecta" --text="La contraseña es incorrecta. Inténtelo de nuevo."
        else
            zenity --error --title="Contraseña Incorrecta" --text="Se han superado los tres intentos. Saliendo del script."
            exit
        fi
    fi
done
}

actualizar_script(){
archivo_local="megatools.sh" # Nombre del archivo local
ruta_repositorio="https://github.com/sukigsx/MegaTools_gui.git" #ruta del repositorio para actualizar y clonar con git clone

# Obtener la ruta del script
descarga=$(dirname "$(readlink -f "$0")")
#descarga="/home/$(whoami)/scripts"
git clone $ruta_repositorio /tmp/comprobar >/dev/null 2>&1

diff $descarga/$archivo_local /tmp/comprobar/$archivo_local >/dev/null 2>&1


if [ $? = 0 ]
then
    #esta actualizado, solo lo comprueba
    #echo ""
    #echo -e "${verde} El script${borra_colores} $0 ${verde}esta actualizado.${borra_colores}"
    #echo ""
    var_actualizado="SI"
    chmod -R +w /tmp/comprobar
    rm -R /tmp/comprobar
else
    #hay que actualizar, comprueba y actualiza
    echo ""
    echo -e "${amarillo} EL script${borra_colores} $0 ${amarillo}NO esta actualizado.${borra_colores}"
    echo -e "${verde} Se procede a su actualizacion automatica.${borra_colores}"
    sleep 3
    mv /tmp/comprobar/$archivo_local $descarga
    chmod -R +w /tmp/comprobar
    rm -R /tmp/comprobar
    echo ""
    echo -e "${verde} El script se ha actualizado.${borra_colores}"
    sleep 2
    exit
    #kill -9 $(ps -o ppid= -p $$)
    #xdotool windowkill `xdotool getactivewindow`
fi
}


#empieza lo gordo

#comprueba si esta zenity
if which zenity 2>/dev/null 1>/dev/null 0>/dev/null; then
    conexion
    if [ $var_conexion = "SI" ]
    then
        var_conexion="SI"
        (software_necesario_zenity && echo -e "\n Terminado") | zenity --text-info --title="Este es el titulo de la ventana" --text="Se comprobara el software necesario.\nEl que falte se intentara instalar." --auto-scroll --font="DejaVu Sans Mono" --width=600 --height=450
        #actualizar_script
    else
        var_conexion="NO"
        software_necesario_terminal
        var_software="SI"
        var_actualizado="Imposible comprobar sin conexion a internet"
    fi


else
    conexion
    if [ $var_conexion = "SI" ]
    then
        var_conexion="SI"
        software_necesario
        #actualizar_script
    else
        var_conexion="NO"
        software_necesario
        var_software="SI"
        var_actualizado="Imposible comprobar sin conexion a internet"
    fi
fi
read -p "paralo"



# Función para mostrar el menú principal
while :
do
    opcion=$(zenity --list --title="MegaTools ( Diseñado por SUKIGSX )" \
    --text="Informacion relacionada al Megatools :\n Conexion a internet = $var_conexion\n software necesario para el correcto funcionamiento = $var_software\n Script esta actualizado = $var_actualizado\n\nInformacion de SUKIGSX: \n Correo electronico = scripts@mbbsistemas.es\n Pagina web = https://repositorio.mbbsistemas.es\n" \
    --column "Opciones del menu principal:" --column="Descripcion." \
    "UTILIDADES PARA EL SISTEMA" "" \
    "Utilidades generales" "Scripts utiles para realizar en tu sistema." \
    "Instalacion de software" "Script para instalar programas en tu sistema." \
    "" "" \
    "INFORMACION DE TU SISTEMA" "" \
    "Info general" "Te da la informacion mas importante de tu sistema" \
    "Info de ips Lan/Wan" "Te da la informacion de ip publica y de tu red" \
    "Info de discos" "Informacion de el uso de tus discos del sistema" \
    "Info memoria ram" "Pues la informacion del uso de la memoria del sistema" \
    "Info dispositivos de red" "Te la la informacion de tus tarjetas de red" \
    "" "" \
    "Crear/Borrar lanzador" "Te crea o brra el lanzador de tu escritorio." \
    --width=650 \
    --height=650 \
    --ok-label="Aceptar" \
    --cancel-label="Salir" \
    --extra-button="Web Sukigsx" \
    --extra-button="Ayuda")

    # Manejar la opción seleccionada
    case $opcion in
        "UTILIDADES PARA EL SISTEMA")
            zenity --error --title="MegaTools ( Diseñado por SUKIGSX )" --text="Selecciona una opcion de UTILIDADES PARA TU SISTEMA."
            ;;
        "Instalacion de software")
            #mete el pid del proceso a un archivo para poder matar este script desde otro
            echo $$ > /tmp/ProcesoPidDeMegatools
            bash InstalacionDeSoftware
            ;;
        "Utilidades generales")
            zenity --info --title="Software-MegaTools ( Diseñado por SUKIGSX )" --text="Has seleccionado utilidades generales."
            ;;

        "Instalacion de software")
            zenity --info --title="Opción 2" --text="Has seleccionado instalacion de software."
            ;;

        "INFORMACION DE TU SISTEMA")
            zenity --error --title="MegaTools ( Diseñado por SUKIGSX )" --text="Selecciona una opcion de INFORMACION DE TU SISTEMA."
            ;;

        "Info general")
            #mete el pid del proceso a un archivo para poder matar este script desde otro
            echo $$ > /tmp/ProcesoPidDeMegatools
            bash InformacionGeneral
            ;;

        "Info de ips Lan/Wan")
            #mete el pid del proceso a un archivo para poder matar este script desde otro
            echo $$ > /tmp/ProcesoPidDeMegatools
            bash InfoDeIpsLanWan
            ;;

        "Info de discos")
            #mete el pid del proceso a un archivo para poder matar este script desde otro
            echo $$ > /tmp/ProcesoPidDeMegatools
            bash InfoDeDiscos
            ;;

        "Info memoria ram")
            #mete el pid del proceso a un archivo para poder matar este script desde otro
            echo $$ > /tmp/ProcesoPidDeMegatools
            bash InfoMemoriaRam
            ;;

        "Info dispositivos de red")
            #mete el pid del proceso a un archivo para poder matar este script desde otro
            echo $$ > /tmp/ProcesoPidDeMegatools
            bash InfoDispositivosDeRed
            ;;

        "Web Sukigsx")
            zenity --text-info --title="Ayuda-MegaTools ( Diseñado por SUKIGSX )" --html --url="https://repositorio.mbbsistemas.es" --ok-label="Salir" --cancel-label="Atras" --width=10000 --height=10000 2>/dev/null
            if [ $? = 0 ]; then
                zenity --question --title="MegaTools ( Diseñado por SUKIGSX )" --text="¿ Estás seguro de que deseas salir ?" --cancel-label="No" --ok-label="Si" --width=300
                if [ $? -eq 0 ]; then
                    exit 0
                fi
            fi
            ;;

        "Ayuda")
            zenity --text-info --title="Ayuda - MegaTools" --filename=Ayuda --font="DejaVu Sans Mono" --width=650 --height=650
            ;;

        "Crear/Borrar lanzador")
            #mete el pid del proceso a un archivo para poder matar este script desde otro
            echo $$ > /tmp/ProcesoPidDeMegatools
            bash CrearLanzador
            ;;

        *)
            if [ $? -eq 0 ]; then
                zenity --error --title="MegaTools ( Diseñado por SUKIGSX )" --text="No has seleccionado ninguna opcion del menu." --width=300
            else
                zenity --question --title="MegaTools ( Diseñado por SUKIGSX )" --text="¿ Estás seguro de que deseas salir ?" --cancel-label="No" --ok-label="Si" --width=300
                if [ $? -eq 0 ]; then
                    exit 0
                fi
            fi
            ;;
    esac
done
