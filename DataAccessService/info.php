<?php
	// Include confi.php
	include_once('confi.php');
        header("Access-Control-Allow-Origin: *");
	
	$user = isset($_GET['user']) ? mysql_real_escape_string($_GET['user']) :  "";
	$password = isset($_GET['pass']) ? mysql_real_escape_string($_GET['pass']) :  "";
	if(!empty($user) and !empty($password) and $user == 'Admin' and $password == 'Admin123'){
		$qur = mysql_query("select * from PointCoord");
		$result =array();
		while($r = mysql_fetch_array($qur)){
			extract($r);
			$result[] = array("ID" => $ID, "Lat" => $Lat, 'Lon' => $Lon, 'Tipo' => $Tipo, 'Nombre' => $Nombre, 'Icon' => $Icon, 'Fecha' => $Fecha, 'Estado' => $Estado); 
		}
		$json = $result;
	}else{
		$json = null;
	}
	@mysql_close($conn);

	/* Output header */
	header('Content-type: application/json');
	echo json_encode($json);