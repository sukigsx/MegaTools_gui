# Capturar el ID del proceso del script 2.sh
konsole -e bash 2.sh &

pid_1=$(ps -ef | grep "2.sh" | grep -v grep | awk '{print $2}')

# Capturar el ID del proceso de zenity
pid_2=$(ps -ef | grep "zenity" | grep -v grep | awk '{print $2}')

read p

echo "este es el 1=$pid_1 y este es el 2=$pid_2"

kill $pid_1
