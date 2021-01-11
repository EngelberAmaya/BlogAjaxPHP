<?php 

/**
 * 
 */
class Acceso
{
	private $email;
	private $user;
	private $pass;
	
	private function Encrypt($string){
		$sizeof = strlen($string) - 1;
		$result = '';
		// lo coloca alreves
		for($x = $sizeof; $x >= 0; $x--){
			$result .= $string[$x];
		}
		$result = md5($result);
		return $result;	
	}
	
	
	public function Login(){

		try {
			if (!empty($_POST['user']) and !empty($_POST['pass']) and !empty($_POST['session'])) {
				$db = new Conexion();
				$this->user = $db->real_escape_string($_POST['user']);
				$this->pass = $this->Encrypt($_POST['pass']);

				$sql = $db->query("SELECT * FROM users WHERE user='$this->user' AND pass='$this->pass';");

				if ($db->rows($sql) > 0) {

					$datos = $db->recorrer($sql);
					$_SESSION['id'] = $datos['id'];
					$_SESSION['user'] = $datos['user'];
					$_SESSION['email'] = $datos['email'];

					if ($_POST['session'] == true) {			// 2 dias la sesión
						ini_set('session.cookie_lifetime', time() + (60*60*24*2));
					}
					echo 1;
					echo 'mensaje por si acaso';
				}else{
					throw new Exception(2);
					
				}
				$db->liberar($sql);
				$db->close();
				
			} else {
				throw new Exception("Error: Datos vacios.");
				
			}
			
		} catch (Exception $e) {
			echo $e->getMessage();	
		}
		exit;

	}

	public function Recuperar(){
		
	}

	public function Registrar(){
		
	}
}

?>