archivo_local="pipi.sh" # Nombre del archivo local
ruta_repositorio="https://github.com/sukigsx/MegaTools_gui.git" #ruta del repositorio para actualizar y clonar con git clone

# Obtener la ruta del script
descarga=$(dirname "$(readlink -f "$0")")
#descarga="/home/$(whoami)/scripts"
#git clone $ruta_repositorio /tmp/comprobar >/dev/null 2>&1

#diff $descarga/$archivo_local /tmp/comprobar/$archivo_local >/dev/null 2>&1


#if [ $? = 0 ]
#then
#    var_actualizado="SI"
#    chmod -R +w /tmp/comprobar
#    rm -R /tmp/comprobar
#else
#    var_actualizado="NO"
#    git fetch origin
#    git reset --hard origin/main
#    chmod -R +w /tmp/comprobar
#    rm -R /tmp/comprobar
3fi

echo "ruta de la variable descarga = $descarga"
