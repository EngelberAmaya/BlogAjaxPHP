<?php

class Conexion extends mysqli
{
 
    public function __construct()
    {
        parent::__construct('localhost','root','','phpavanzado');
        $this->query("SET NAMES utf8;");
        $this->connect_error ? die('Error: Conexión a la base de datos fallida.') : null;
        //se utiliza para evitar generar una x cada vez que se instancie una Conexion
        //$this->set_charset("utf8");
    }

    public function rows($x){
        return mysqli_num_rows($x);
    }

    public function liberar($x){
        return mysqli_free_result($x);
    }

    public function recorrer($x){
        return mysqli_fetch_array($x);
    }

    /* octavo video tutorial-para cerrar la sesion
    public function __destruct(){
        $this->close();
    }
    */
}


 ?>
