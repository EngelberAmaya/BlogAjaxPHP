<?php 

if ($_POST or ($_SESSION['busqueda'] and isset($_GET['pag']))) {
	
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
	
	if (isset($_SESSION['busqueda']) and !isset($_POST['busqueda'])) {
		$busqueda = $_SESSION['busqueda'];
	} else {
		$busqueda = $_POST['busqueda'];
	}
	
	$_SESSION['busqueda'] = $busqueda;

	$cantidad = $db->query("SELECT COUNT(*) FROM posts WHERE titulo LIKE '%$busqueda%';");
	$sql = $db->query("SELECT * FROM posts WHERE titulo LIKE '%$busqueda%' ORDER BY id DESC LIMIT $inicio,$paginado;");

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

	$template->assign('titulo','Resultado de la busqueda');
	$template->assign('pags',$paginas);
	$template->display('home/index.tpl');

}


?>