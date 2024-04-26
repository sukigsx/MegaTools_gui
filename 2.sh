pid_1=$(ps -ef | grep "2.sh" | grep -v grep | awk '{print $2}')


password(){
# Inicializar el contador de intentos
    attempts=0

    # Bucle para solicitar la contraseña hasta tres intentos
    while [ $attempts -lt 3 ]; do
        # Solicitar la contraseña del usuario actual utilizando Zenity
        PASSWORD=$(zenity --entry --hide-text --text="Ingrese tu contraseña" --title="Contraseña de usuario. - MegaTools -" --width=450 --height=100)

        # Verificar si se ha cancelado la entrada de la contraseña
        if [ $? -ne 0 ]; then
            # Salir del script si se ha cancelado
            rm /tmp/software 2>/dev/null
            rm /tmp/ComprobarSoftware 2>/dev/null
            rm /tmp/comprobacion 2>/dev/null
            exit
        fi

        # Verificar la contraseña utilizando el comando sudo
        echo "$PASSWORD" | sudo -S ls /root >/dev/null 2>&1

        # Verificar el código de salida del comando sudo
        if [ $? -eq 0 ]; then
            # Contraseña correcta
            zenity --info --title="Contraseña de usuario. - MegaTools -" --text="La contraseña es correcta." --width=250 --height=100 --timeout 3
            break
        else
            # Contraseña incorrecta
            let "attempts+=1"
            if [ $attempts -lt 3 ]; then
                zenity --error --title="Contraseña de usuario. - MegaTools -" --text="La contraseña es incorrecta. Inténtelo de nuevo." --width=250 --height=100 --timeout 3
            else
                zenity --error --title="Contraseña de usuario. - MegaTools -" --text="Se han superado los tres intentos. Se regresa al menu principal." --width=250 --height=100 --timeout 7
                rm /tmp/software 2>/dev/null
                exit
            fi
        fi
    done
}

password

(sudo apt update; sudo apt update; sudo apt update; sudo apt update; sudo apt update; sudo apt update; sudo apt update; sudo apt update; sudo apt update) | zenity --text-info --width=600 --height=400 --title="Instalando software seleccionado. - MegaTools" --auto-scroll --font="DejaVu Sans Mono"

if [ $? = 1 ]; then
	kill $pid_1
else
	kill $pid_2
fi

