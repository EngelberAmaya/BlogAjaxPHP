<?php 

session_start();

$view = isset($_GET['view']) ? $_GET['view'] : 'index';
require('core/libs/smarty/Smarty.class.php');
require('core/models/class.Conexion.php');

if (file_exists('core/controllers/'.$view.'Controller.php')) {
	include('core/controllers/'.$view.'Controller.php');
} else {
	# página de error
	include('core/controllers/indexController.php');
}


?>