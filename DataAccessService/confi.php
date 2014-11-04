<?php
$conn = mysql_connect("servidor", "usuario", "contraseña");
mysql_select_db('base de datos', $conn);

mysql_query("SET character_set_results = 'utf8', character_set_client = 'utf8', character_set_connection = 'utf8', character_set_database = 'utf8', character_set_server = 'utf8'", $conn);