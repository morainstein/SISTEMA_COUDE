<?php
namespace SistemaCoude\Model;

require_once __DIR__ . "/database-handler/Handlers/SQL_CRUD.php"; 
use Handlers\SQL_CRUD;

class Usuarios extends SQL_CRUD{

    private string $table="usuarios";

    public function insert($dados){
        $response = parent::execInsert($this->table,$dados);
        return $response;
    }
    public function select($columns, $conditions = null, $group_by = null, $order_by = null, $order_direction = null, $limit_min = null, $limit_max = null){
        $response = parent::execSelect($this->table, $columns, $conditions, $group_by, $order_by, $order_direction, $limit_min, $limit_max);

        return $response;
    }

    public function update($dados, $conditions){
        $response = parent::execUpdate($this->table, $dados, $conditions);

        return $response;
    }

    public function delete($id){
        $dados = [
            "visibilidade" => 0
        ];

        $conditions = [
            ['id', $id]
        ];

        $response = $this->update($dados, $conditions);

        return $response;
    }
}
