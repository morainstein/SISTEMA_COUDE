<?php

namespace Handlers;

use Exception;

class ReturnFormat {
  public $result;
  public String|Null $result_error;
  public String|Bool|Null $sql;

  function __construct($result, String|Null $result_error, String|Bool|Null $sql) {
    $this->result = $result;
    $this->result_error = $result_error;
    $this->sql = $sql;
  }
}

class Connection {
  public $connection = null;
  public $connection_error = null;

  public $sql_exec_result = null;
  public $sql_exec_result_error = null;

  protected String $db_host;
  protected String $db_user;
  protected String $db_pass;
  protected String $db_name;
  protected String $db_drive;

  public function __construct(String $host = null, String $db_user = null, String $db_pass = null, String $db_name = null, String $db_drive = 'mysql') {
    $this->db_host = $host;
    $this->db_user = $db_user;
    $this->db_pass = $db_pass;
    $this->db_name = $db_name;
    $this->db_drive = $db_drive;
  }

  private function connect() {
    try {
      $PDO = new \PDO("$this->db_drive:host=$this->db_host;dbname=$this->db_name", $this->db_user, $this->db_pass);

      $this->connection = $PDO;
    } catch(Exception $e) {
      $this->connection = false;
      $this->connection_error = $e->getMessage();
    }

    return $this->connection;
  }

  private function closeConnection(){
    $this->connection = null;
    $this->connection_error = null;
  }

  public function executeSQL(String $sql, ...$values) : Object {
    $this->connect();

    if($this->connection){
      try {

        $stmt = $this->connection->prepare($sql);

        $count = 1;
        foreach($values as $k => $v) {
          $stmt->bindParam($count, $values[$k]);
          
          $count++;
        }
        
        $stmt->execute();

        $sql_comand = strtolower(explode(" ", $sql)[0]);

        if($sql_comand == 'select'){
          $this->sql_exec_result = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        } else {
          $this->sql_exec_result = $stmt->rowCount();
        }
        $this->sql_exec_result_error = null;
      } catch (Exception $e) {
        $this->sql_exec_result = false;
        $this->sql_exec_result_error = $e->getMessage();
      }
    } else {
      $this->sql_exec_result = false;
      $this->sql_exec_result_error = "Connection is null.";
    }

    $this->closeConnection();

    return new ReturnFormat($this->sql_exec_result, $this->sql_exec_result_error, $sql);
  }
}
