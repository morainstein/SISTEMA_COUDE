<?php 

function returnPath(String $path) : String{

  $formated_path = str_replace(',', DIRECTORY_SEPARATOR , $path);

  $final_path = $_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . $formated_path;

  return $final_path;

}


?>