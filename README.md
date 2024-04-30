
             - MEGATOOLS -


INFORMACION GENERAL

Esta utilidad presenta un menú interactivo utilizando Zenity, una herramienta para crear interfaces gráficas en shell scripts.
Aquí está la descripción de cómo funciona:

Menú Principal: El script muestra un menú con varias opciones organizadas en dos secciones:
    "UTILIDADES PARA EL SISTEMA"
    "INFORMACION DE TU SISTEMA"

Contenido del Menú: Cada opción del menú está asociada a una tarea específica que el usuario puede realizar. Por ejemplo:

    "Crear lanzadores": Permite al usuario crear lanzadores en el escritorio.
    "Instalacion de software": Ejecuta un script para instalar programas en el sistema.
    "Informacion general": Proporciona información importante del sistema.
    "Web Sukigsx": Abre una ventana del navegador con la página web del diseñador del programa.
    "Ayuda": Muestra información de ayuda sobre el uso del programa.

Interacción del Usuario:
El usuario puede seleccionar una opción del menú haciendo clic en ella.
Dependiendo de la opción seleccionada, se ejecuta una tarea específica.

Manejo de Opciones:
El script utiliza un bucle infinito (while :) para mantener el menú visible hasta que el usuario decida salir.
Se utiliza zenity --list para mostrar el menú y capturar la opción seleccionada por el usuario.

Gestión de Acciones:
Según la opción seleccionada, se ejecuta un bloque de código correspondiente utilizando una estructura case.
Por ejemplo, si el usuario elige "Crear lanzadores", se ejecuta un script para manejar esta tarea específica.

Salida del Programa:
El usuario puede elegir salir del programa en cualquier momento seleccionando la opción "Salir" o cerrando la ventana.
El script maneja esta salida con mensajes de confirmación para asegurarse de que el usuario realmente desea salir.

En resumen, esta utilidad proporciona una forma conveniente para que el usuario interactúe con el programa.
Seleccionando opciones del menú y realizando diferentes tareas relacionadas con la gestión del sistema y la obtención de información.

        INFORMACION MAS DETALLADA
Este código es un script de shell (bash) que parece ser una herramienta de automatización y gestión llamada "MegaTools".
A continuación, te proporcionaré un resumen de lo que hace el código:

Definición de variables:
Se definen algunas variables al principio del script, como la versión del programa.
El software necesario para su ejecución, y códigos de colores para mejorar la salida en la terminal.

Funciones:
Se definen varias funciones que realizan tareas específicas:
    conexion: Comprueba si hay conexión a Internet.
    software_necesario_zenity: Verifica y, si es necesario instala el software necesario utilizando la interfaz gráfica de Zenity.
    software_necesario: Similar a la función anterior, pero realiza la verificación e instalación del software necesario en la terminal.
    software_necesario_sino: Recorre el software para comprobar si está instalado.
    actualizar_script: Actualiza el script desde un repositorio remoto si hay una nueva versión disponible.
    comprobar_actualizacion_sino: Comprueba si hay una actualización disponible del script.

Lógica principal:

Se comprueba si el software necesario está instalado.
Si no lo está, se verifica la conexión a Internet y se intenta instalar utilizando diferentes métodos dependiendo de si se tiene Zenity disponible o no.

Si hay una conexión a Internet y el software está instalado, se verifica si hay una actualización del script. Si hay una actualización disponible, se descarga y se reemplaza el script actual.
Luego, se muestra un menú principal utilizando Zenity que proporciona opciones para diferentes funciones del programa, como la instalación de software, la creación de lanzadores, y la obtención de información del sistema.
Dependiendo de la opción seleccionada en el menú, se ejecutan diferentes partes del script para realizar las tareas correspondientes.

Interfaz de usuario:
Se utiliza Zenity para proporcionar una interfaz de usuario gráfica para interactuar con el script. Esto incluye la presentación de mensajes, la selección de opciones del menú y la visualización de información.

En resumen:
El script es una herramienta que automatiza varias tareas relacionadas con la gestión de software, la verificación de actualizaciones y la obtención de información del sistema, todo ello presentado en una interfaz gráfica para una mejor experiencia del usuario.

    INSTALACION DE SOFTWARE

Este script es un instalador de software interactivo para sistemas Linux que utiliza Zenity para crear una interfaz gráfica de usuario.
El script presenta al usuario una lista de categorías de software para elegir y luego ejecuta scripts específicos de cada categoría según la elección del usuario.

Aquí hay una descripción general de cómo funciona el script:

Utiliza Zenity para mostrar un cuadro de diálogo de lista que presenta al usuario una serie de categorías de software para elegir, organizado en categorias, que son las siguientes:

  NAVEGADORES: Los principales navegadores para internet.
  AUDIO - VIDEO: Software relacionado con el Audio y el Video.
  ENTORNOS GRAFICOS LINUX: Los principales entornos gráficos para Linux basados en Debian.
  UTILIDADES: Una variedad de utilidades.
  OFIMATICA: Software dedicado a la ofimática.
  SERVIDORES: Servidores para tu sistema, como ssh, ftp, smb, etc.
  GESTOR DE PAQUETES: Software para el control de paquetes, como snap, apt, etc.
  PARA TU TERMINAL: Software pensado para la terminal de Linux.
  DISCOS: Software de control de discos duros y unidades en general.
  JUEGOS: Software de entretenimiento, juegos.
  SEGURIDAD: Software destinado a la seguridad del equipo.
  MENSAJERIA: Software de mensajería en red.
  PAQUETES INDEPENDIENTES: Permite descargar e instalar paquetes .deb manualmente.


Según la opción seleccionada por el usuario, el script ejecuta un script específico para esa categoría.
Cada script de categoría (Navegadores, AudioVideo, EntornosGraficosLinux, etc.) instala software relacionado con esa categoría.

Estos scripts de categoría están ubicados en una carpeta ($ruta_ejecucion) y se ejecutan utilizando el comando bash.

Si el usuario selecciona "Ayuda instalación de software", se muestra una ventana de texto con información de ayuda (Esta ventana).

Si el usuario selecciona "Ver software para instalar", el script verifica si se ha seleccionado algún software.
  Si se ha seleccionado software, muestra una lista de este y ofrece la opción de instalarlo. Si el usuario elige continuar, el script inicia la instalación de software en segundo plano utilizando konsole.

Durante la instalación de software en segundo plano, el script permite al usuario cancelar la instalación o esperar a que termine.

Después de que la instalación haya terminado, el script verifica el software instalado y muestra los resultados en una ventana de texto.

Si el usuario selecciona una opción no válida o cancela la operación en cualquier momento, el script finaliza.

Al final, el script elimina los archivos temporales utilizados durante el proceso.

En resumen, este script proporciona una interfaz de usuario gráfica para seleccionar, instalar y verificar software en un sistema Linux. Es útil para simplificar el proceso de instalación de software para usuarios que prefieren una interfaz gráfica en lugar de trabajar en la línea de comandos.

      PAQUETES INDEPENDIENTES

Este script maneja la instalación de paquetes .deb de forma interactiva y ofrece opciones para descargar, instalar y administrar dichos paquetes. Para ello primero tienes que seleccionar un navegador para poder cargar la paquina web de dicho paquete a instalar.
Aquí está el resumen de las opciones en el menú:

Seleccionar Navegador: Permite al usuario elegir un navegador que se utilizará para descargar los paquetes .deb. Las opciones incluyen google-chrome-stable, chromium, firefox, opera, brave, y vivaldi-stable.

Ayuda: Muestra información de ayuda relacionada con la instalación de paquetes independientes (Esta ventana).

Descargar Paquetes Independientes: Muestra una lista de paquetes .deb disponibles para instalar y permite al usuario elegir cuál descargar.
  Este menu se ira actualizando segun las necesidades y software nuevo que considere que es de utilidad.

Al seleccionar un paquete, se abrirá el navegador seleccionado y se dirigirá a la página de descarga correspondiente.
  El usuario tendra que descargar el paquete *.deb para su sistema linux basado en debian y lo MAS IMPORTANTE, DESCARGARLO EN LA CARPETA DESCARGAS, sino es asi el script no lo encontrara para poder instalarlo.
  En la ventana de Paquetes independientes se ira mostrando los paquetes descargados, para posterior mente instalarlos todos de golpe.

Borrar paquetes descargados: Permite al usuario eliminar todos los archivos .deb descargados previamente en la carpeta de descargas.

Instalar paquetes deb: Instala automáticamente todos los paquetes .deb descargados previamente en la carpeta de descargas.
  El proceso de instalación se realiza en segundo plano y se utiliza el gestor de paquetes dpkg. Si hay dependencias faltantes, se intentará resolverlas automáticamente usando apt. Después de la instalación, se eliminarán los archivos .deb descargados.

Además de estas opciones de menú, también hay opciones específicas de instalación para algunos paquetes:

  Franz: Abre el navegador seleccionado en la página web de Franz para descargar el cliente de escritorio multiprotocolo.
  Debreate: Abre el navegador seleccionado en la página web de Debreate, una herramienta para crear paquetes .deb.
  Genymotion: Abre el navegador seleccionado en la página de descarga de Genymotion, un emulador de Android.
  VirtualBox: Abre el navegador seleccionado en la página de descarga de VirtualBox, un software gratuito para crear máquinas virtuales.
  Script de Sukigsx: Clona un repositorio de GitHub que contiene scripts de instalación desarrollados por Sukigsx. Los scripts se instalan automáticamente después de la descarga.

En resumen, este script facilita la descarga, instalación y gestión de paquetes .deb en sistemas Linux utilizando una interfaz interactiva basada en Zenity y navegadores web seleccionados por el usuario.

Tambien hay que tener en cuenta que no todo el software se instala desde un .deb, en ocasiones hay que ejecutar un binario de instalacion o cosas similares, en esos casos el script decidira su forma de instalacion del mismo, el el menu de Paquetes independientes en la descripcion de informa de ello, como es el ejemplo de:
  Genymotion Emulador de Android en la nube y para PC con integraciones para marcos de prueba. (al dar a Descargar se instala solo)

      INSTALACION

De dos maneras:
  1- Utilizando mi script de (ejecutar scripts)
    git clone https://github.com/sukigsx/ejecutar_scripts.git
  2- Clonando el repositorio
    git clone https://github.com/sukigsx/MegaTools_gui.git

ESPERO OS GUSTE................

