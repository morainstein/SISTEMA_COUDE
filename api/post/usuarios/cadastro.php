<?php 
session_start();
include_once __DIR__ . "/../../vendor/autoload.php";

use \SistemaCoude\Controller\Usuarios;

$user = new Usuarios();

$user->cadastrar($_POST['nome'], $_POST['email'], $_POST['senha']);

//bloco de criação do usuário no backend
$nome = $post['nome'];
$email = $POST['email'];
$senha  = $POST['senha'];
$cpf = $POST['cpf'];
$endereco = $POST['endereco'];

$sql = "INSERT INTO usuarios (nome, email, senha, cpf, endereco) 
        VALUES ('$nome', '$email', '$senha', '$cpf', '$endereco')";

if ($sql === true){
    var_dump('O usuário foi cadastrado com sucesso');
} else {
    echo "Erro: Cadastre novamente";
};



?>

