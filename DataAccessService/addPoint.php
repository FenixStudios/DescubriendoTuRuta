<?php

// Include confi.php
include_once('confi.php');

if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data
	$lat = isset($_POST['lat']) ? mysql_real_escape_string($_POST['lat']) : "";
	$lon = isset($_POST['lon']) ? mysql_real_escape_string($_POST['lon']) : "";
	$nombre = isset($_POST['nombre']) ? mysql_real_escape_string($_POST['nombre']) : "";
	$tipo = isset($_POST['tipo']) ? mysql_real_escape_string($_POST['tipo']) : "";
        $icon = isset($_POST['icon']) ? mysql_real_escape_string($_POST['icon']) : "";
        $fecha = isset($_POST['fecha']) ? mysql_real_escape_string($_POST['fecha']) : "";
        $estado = isset($_POST['estado']) ? mysql_real_escape_string($_POST['estado']) : "";
        $user = isset($_POST['user']) ? mysql_real_escape_string($_POST['user']) : "";

	// Insert data into data base
	$sql = "INSERT INTO `PointCoord` (`ID`, `Lat`, `Lon`, `Nombre`, `Tipo`, `Icon`, `Fecha`, `Estado`, `User`) VALUES (NULL, '$lat', '$lon', '$nombre', '$tipo', '$icon', '$fecha', '$estado', '$user');";
	$qur = mysql_query($sql);
	if($qur){
		$json = array("status" => 1, "msg" => "Done Point added!");
	}else{
		$json = array("status" => 0, "msg" => "Error adding point!");
	}
}else{
	$json = array("status" => 0, "msg" => "Request method not accepted");
}

@mysql_close($conn);

/* Output header */
	header('Content-type: application/json');
	echo json_encode($json);