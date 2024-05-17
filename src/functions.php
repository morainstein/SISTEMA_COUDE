<?php 
session_start();
verifyLogin();
 include_once returnPath('vendor,autoload.php');

 function returnPath(String $path) : String{

  $formated_path = str_replace('/', DIRECTORY_SEPARATOR , $path);

  $final_path = $_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . $formated_path;

  return $final_path;

}

function verifyLogin() : void{
  if(!isset($_SESSION['id']) &&
   mb_strpos($_SERVER["SCRIPT_NAME"], "login.php")  === false){  
    header('Location: login.php');
  }else if(isset($_SESSION['id']) && mb_strpos($_SERVER["SCRIPT_NAME"], "login.php")  !== false){
    header('Location: index.php');
  }
}


?>