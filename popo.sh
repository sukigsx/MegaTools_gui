 #!/bin/bash



software_necesario(){
clear
var_software="NO"
#echo -e " Verificando software necesario:"
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
            #echo -e " ${amarillo}NO se ha podido instalar ${rojo}$paquete${amarillo}.${borra_colores}"
            #echo -e " ${amarillo}Intentelo usted con las ordenes: (${borra_colores}sudo apt update y sudo apt install $paquete ${amarillo})${borra_colores}"
            zenity --warning --title="Verificando sofMegatools" --text="No se ha podido instalar $paquete\nIntentelo usted con las ordenes sudo apt update y sudo apt install $paquete" --width=650

            echo -e ""
            #echo -e " ${rojo}No se puede ejecutar el script sin el software necesario.${borra_colores}"
            zenity --warning --title="Megatools - ( Diseñado por SIKIGSX )" --text="No se puede ejecutar el script sin el software necesario." --width=650
            read pause
            exit
        else #intenta instalar
            echo " Instalando $paquete. Intento $contador/3."
            sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null | zenity --text-info --title="instalando - MegaTools" --width=350 --height=200 --cancel-label="Salir sin preguntar" --ok-label="Atras" --width=650
            let "contador=contador+1" #incrementa la variable contador en 1
            which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
            sino=$? ##recojemos el 0 o 1 del resultado de which
        fi
    done
echo -e " [ok] $paquete." | zenity --text-info --title="instalando - MegaTools" --width=350 --height=200 --cancel-label="Salir sin preguntar" --ok-label="Atras" --width=650
var_software="SI"
done
}

software_necesario
