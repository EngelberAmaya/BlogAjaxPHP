<?php 

$template = new Smarty();
$type = isset($_GET['type']) ? $_GET['type'] : null;

if (isset($_GET['pag']) and is_numeric($_GET['pag']) and $_GET['pag'] >= 1) {
	$pagina = $_GET['pag'];
} else {
	$pagina = 1;
}

$db = new Conexion();

$paginado = 8;
$inicio = ($pagina - 1) * $paginado;

switch ($type) {
	case 'tops':
		$cantidad = $db->query("SELECT COUNT(*) FROM posts;");
		$sql = $db->query("SELECT * FROM posts ORDER BY puntos DESC LIMIT $inicio,$paginado;");		
		$template->assign('titulo','Los mejores');
		break;

	case '1':
		$cantidad = $db->query("SELECT COUNT(*) FROM posts WHERE categoria='1';");		
		$sql = $db->query("SELECT * FROM posts WHERE categoria='1' ORDER BY puntos DESC LIMIT $inicio,$paginado;");	
		$template->assign('titulo','Categoria 1');
		break;

	case '2':
		$cantidad = $db->query("SELECT COUNT(*) FROM posts WHERE categoria='2';");
		$sql = $db->query("SELECT * FROM posts WHERE categoria='2' ORDER BY puntos DESC LIMIT $inicio,$paginado;");
		$template->assign('titulo','Categoria 2');
		break;

	case '3':
		$cantidad = $db->query("SELECT COUNT(*) FROM posts WHERE categoria='3';");
		$sql = $db->query("SELECT * FROM posts WHERE categoria='3' ORDER BY puntos DESC LIMIT $inicio,$paginado;");
		$template->assign('titulo','Categoria 3');
		break;	
	
	default:
		$cantidad = $db->query("SELECT COUNT(*) FROM posts;");
		$sql = $db->query("SELECT * FROM posts ORDER BY id DESC LIMIT $inicio,$paginado;");
		$template->assign('titulo','Inicio');
		break;
}


$result = $db->recorrer($cantidad);
$result = $result[0];
$paginas = ceil($result / $paginado);


if ($db->rows($sql) > 0) {
	// Preparada
	$psql = "SELECT user FROM users WHERE id=?;";
	$prepare_sql = $db->prepare($psql);
	$prepare_sql->bind_param('i',$id);

	while ($x = $db->recorrer($sql)) {

		$id = $x['dueno'];
		$prepare_sql->execute();
		$prepare_sql->bind_result($autor);
		$prepare_sql->fetch(); // es equivalente al recorrer
			// Termina sentencia Preparada
		$posts[] = array(
			'id' => $x['id'],
			'titulo' => $x['titulo'],
			'content' => $x['content'],
			'dueno' => $autor,
			'id_dueno' => $id,
			'puntos' => $x['puntos']
		);
	}
	$prepare_sql->close();
	//asignandolo a travez de smarty
	$template->assign('posts',$posts);
}


$db->liberar($sql, $cantidad);
$db->close();
$template->assign('pags',$paginas);
$template->display('home/index.tpl');



?>


