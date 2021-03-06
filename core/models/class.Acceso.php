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
		

	}

	public function Recuperar(){
		
	}

	public function Registrar(){
		try {
			if (!empty($_POST['user']) and !empty($_POST['pass']) and !empty($_POST['email'])) {
				$db = new Conexion();
				$this->user = $db->real_escape_string($_POST['user']);
				$this->email = $db->real_escape_string($_POST['email']);
				$this->pass = $this->Encrypt($_POST['pass']);

				$sql = $db->query("SELECT * FROM users WHERE user='$this->user' OR email='$this->email';");

				if ($db->rows($sql) == 0) {

					$sql2 = $db->query("INSERT INTO users (user,pass, email)
					VALUES ('$this->user','$this->pass','$this->email');");

					$sql3 = $db->query("SELECT MAX(id) AS id FROM users;");

					$id = $db->recorrer($sql3);
					$_SESSION['id'] = $id[0];
					$_SESSION['user'] = $this->user;
					$_SESSION['email'] = $this->email;

					echo 1;

					$db->liberar($sql2,$sql3);
					
				}else{
					$datos = $db->recorrer($sql);
					if (strtolower($this->user) == strtolower($datos['user'])) {
						throw new Exception(2);
						
					} else {
						throw new Exception(3);
						
					}
					
					
				}
				$db->liberar($sql);
				$db->close();
				
			} else {
				throw new Exception("Error: Datos vacios.");
				
			}
			
		} catch (Exception $reg) {
			echo $reg->getMessage();	
		}
	}
}

?>