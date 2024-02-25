
#software necesario para la ejecucion del programa
software="which git diff ping figlet nano neofetch lsblk ethtool zenity"

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
fi
}

software_necesario(){
clear
var_software="NO"
echo -e " Verificando software necesario:\n"

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
archivo_local="pipi.sh" # Nombre del archivo local
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

#ejecuto la funcion para comprobar si esta el software necesario instalado.
#si esta instalado ejecuta el programa y listo.
#si no esta instalado, entonces entra en el if y comprueba la conexion a internet y todo lo demas.
software_necesario_sino
if [ $var_software = "NO" ]; then
    conexion
        if [ $var_conexion = "SI" ]; then
            software_necesario
            actualizar_script_zenity
        else
            clear
            echo -e "${verde}\n Verificando software necesario para el correcto funcionamiento.${borra_colores}"
            echo -e "${rojo}\n No hay conexion a internet.${borra_colores}"
            echo -e "${amarillo} No se puede ejecutar el script sin el software necesario.\n${borra_colores}"
            exit
        fi
fi

echo "Ejecuto el resto"




