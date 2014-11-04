App Web
====================

Este repositorio contiene los archivos necesarios para el funcionamiento de la app web que permite la consulta, análisis y exportación de información para el prototipo de mejora de Mappir.

<h2>Instalación</h2>

<h3>Software Base</h3>
El presente servicio web requiere de la instalación de software base como son: <a href=http://www.mysql.com/>MySQL</a> y <a href=http://php.net/>Php</a>.

Por lo cual es necesario de un servidor o un host en linea que permita la instalación y configuración de los mismos.

Para instalar y configurar estos programas siga las instrucciones correspondientes para cada uno ubicadas en los sitios web de cada producto o en la ayuda de su proveedor de hospedaje.

Otra opción para la configuración del entorno base es utilizar <a href=https://www.apachefriends.org/es/index.html>XAMPP</a>.

<h3>App Web</h3>
Una vez configurado el software base, abra en modo de edición el archivo app.js localizado dentro de la carpeta scripts y ubiquese en la linea 214 (url: 'http://<servidor>/info.php',) y reemplace el texto "<servidor>" por la ruta correspondiente al Servicio Web del prototipo.

Finalmente copie el contenido de la carpeta "Mappir" al directorio de su servidor de aplicaciones deseado.