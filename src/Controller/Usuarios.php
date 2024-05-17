<?php 

namespace SistemaCoude\Controller;

require_once __DIR__ . "/../Model/Usuarios.php";

use SistemaCoude\Model\Usuarios as ModelUsuarios;

class Usuarios {
    private $model = "";

    public function __construct()
    {
        $this->model = new ModelUsuarios(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    }

    public function cadastrar($nome, $login, $senha){
        $dados = [
            "nome" => $nome,
            "email" => $login,
            "senha" => password_hash($senha, PASSWORD_DEFAULT) 
        ];

        return $this->model->insertUsuario($dados)->result;
    }

    public function logar($email, $senha){
        $conditions = [
            ['email', $email], 
        ];

        $response = $this->model->selectUsuario('*',$conditions)->result;

        if($response !== false){
            $user_info = $response[0];

            if(password_verify($senha, $user_info['senha'])){
                $_SESSION['id_user'] = $user_info['id'];

                $response = true;
            } else {
                $response = false;
            }
        }

        return $response;
    }
}