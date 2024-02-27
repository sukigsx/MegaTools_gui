

software="which git diff ping figlet neofetch lsblk ethtool zenity nano"

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
clear
var_software="NO"
echo -e " Verificando software necesario:"
#software="which git diff ping figlet neofetch lsblk ethtool zenity" #ponemos el foftware a instalar separado por espacion dentro de las comillas ( soft1 soft2 soft3 etc )
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
#software="which git diff ping figlet neofetch lsblk ethtool nano zenity popo" #ponemos el foftware a instalar separado por espacion dentro de las comillas ( soft1 soft2 soft3 etc )
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
            salir="SI"
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
            salir="SI"
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
        (software_necesario_zenity && echo -e "\n Terminado") | zenity --text-info --title="Este es el titulo de la ventana" --text="Se comprobara el software necesario.\nEl que falte se intentara instalar." --auto-scroll --font="DejaVu Sans Mono" --width=600 --height=450
        var_software="SI"
        var_actualizado="Imposible comprobar sin conexion a internet"
    fi
else
    conexion
    if [ $var_conexion = "SI" ]
    then
        var_conexion="SI"
        software_necesario_terminal
        #actualizar_script
    else
        var_conexion="NO"
        software_necesario_terminal
        var_software="SI"
        var_actualizado="Imposible comprobar sin conexion a internet"
    fi
fi

zenity --text-info --title="Este es el titulo de la ventana"
