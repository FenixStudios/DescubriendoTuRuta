Servicio Web
====================

Este repositorio contiene los archivos necesarios para el funcionamiento del servicio web responsable de la consulta y captura de información para el prototipo de mejora de Mappir.

<h2>Instalación</h2>

<h3>Software Base</h3>
El presente servicio web requiere de la instalación de software base como son: <a href=http://www.mysql.com/>MySQL</a> y <a href=http://php.net/>Php</a>.

Por lo cual es necesario de un servidor o un host en linea que permita la instalación y configuración de los mismos.

Para instalar y configurar estos programas siga las instrucciones correspondientes para cada uno ubicadas en los sitios web de cada producto o en la ayuda de su proveedor de hospedaje.

Otra opción para la configuración del entorno base es utilizar <a href=https://www.apachefriends.org/es/index.html>XAMPP</a>.

<h3>Servicio Web</h3>
Una vez configurado el software base. Ejecute el contenido del archivo base.sql para crear las tablas necesarias para el funcionamiento del webservice dentro de su programa administrador de MySQL (ej. <a href=http://www.phpmyadmin.net/>phpMyAdmin</a>).

Una vez creada la estructura de datos, modifique el archivo confi.php y reemplace los datos de "servidor", "usuario", "contraseña" y "base de datos" por los datos correspondientes a su configuración.

Finalmente copie los archivos con extension php a un directorio web de su servidor de aplicaciones.