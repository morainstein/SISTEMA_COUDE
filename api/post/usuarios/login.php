<?php 
session_start();
include_once __DIR__ . "/../../vendor/autoload.php";

use \SistemaCoude\Controller\Usuarios;

$user = new Usuarios();

if(!empty($_POST)){

  $email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);
  $senha = $_POST['senha'];

  $resposta = $user->logar($email, $senha);

  if($resposta){
    $_SESSION['status'] = $resposta;
    $_SESSION['status_msg'] = "Login efetuado com sucesso!";
    header('Location: /');
  }else{
    $_SESSION['status'] = $resposta;
    $_SESSION['status_msg'] = "Email ou senha inválidos!";
    header('Location: /login.php');
  }
}
?>