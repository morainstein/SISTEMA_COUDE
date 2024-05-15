<?php

namespace Handlers;

use Handlers\ReturnFormat;
use Handlers\Connection;

use Exception;

class SQL_CRUD extends Connection{

  private function returnProcessedData($v){
    if(empty($v) && is_string($v) && $v != 0){
      return "NULL";
    } else {
      return $v;
    }
  }

  private function checksIfIsArrayAndReturns(Array|String|Int|Float|Null $data, String $implode_separator = ", ") : String|Int|Float|Null {
    echo "<br>";
    if(is_array($data)){
      return implode($implode_separator, $data);
    } else {
      return $data;
    }
  }

  private function checksIfIsNotEmptyAndReturns($data, String $prefix = '') : String{
    $new_value = !empty($data) ? $prefix . $data : "";

    return $new_value;
  }

  private function returnsValuesSyntax(Array $array) : String|Bool{
    if(is_numeric($array[0])){
      $values = false;
    } else {
      $new_array = array_map(function($v){
        return '?';
      }, $array);

      $values = implode(", ", $new_array);
    }

    return $values;
  }

  private function prepareConditions(Array|Null $conditions) : String|Array|Bool{
    if(!empty($conditions)){
      if(is_array($conditions)){
        $processed_data = array_map(function($v){
          if (is_array($v)) {
            $column = $v[0];
            return "$column = '".$v[1]."'";
          } else {
            return $v;
          }
        },$conditions);
    
        return implode(" AND ", $processed_data);
      } else {
        return $conditions;
      }
    } else {
      return false;
    }
  }

  private function returnsOderBySyntax(String|Null $order_by, String|Null $order_direction) : String{
    $desc_array = [">", "DESC"];
  
    if(!empty($order_by)){
      $order_direction = array_search($order_direction, $desc_array) !== false ? " DESC " : " ASC ";
      $order_by = " ORDER BY " . $order_by . " " . $order_direction;
    } else {
      $order_by = "";
    }

    return $order_by;
  }

  private function prepareLimitClause(String|Int|Null $limit_min, String|Int|Null $limit_max) : String{
    if(empty($limit_max) && (!empty($limit_min) && $limit_min != 0)){
      $limit = "LIMIT $limit_min";
    } else if ((!empty($limit_min) || $limit_min === 0) && (!empty($limit_max) || $limit_max === 0)){
      $limit = "LIMIT $limit_min, $limit_max";
    } else {
      $limit = "";
    }

    return $limit;
  }

  private function prepareTable($table){
    if(is_array($table)){
      $new_table_value = [];

      foreach($table as $key => $values){
        if(is_array($values)){
          $on_txt = $this->prepareConditions($values);
  
          if($on_txt && !empty($on_txt)){
            array_push($new_table_value, $key . ' ON ' . $on_txt);
          } else {
            array_push($new_table_value, $key);
          }
        } else {
            array_push($new_table_value, $values);
        }
      }
    } else {
      $new_table_value = $table;
    }

    return $new_table_value;
  }
  
  protected function SQL_insert(String $table, Array $data) : Array|Bool{
    if(is_array($data)){
      $processed_data = array_map(function($v){return $this->returnProcessedData($v);}, $data);
  
      $array_keys = array_keys($processed_data);
      
      $values = $this->returnsValuesSyntax($array_keys);
  
      $columns = implode("`, `", $array_keys);
  
      $sql = "INSERT INTO `$table`(`$columns`) VALUES ($values);";
      return ["SQL" => $sql, "VALUES" => $processed_data];
    } else {
      return false;
    }
  }
  
  public function SQL_select(String|Array $table, String|Array|Null $columns = "*", Array|Null $conditions = null, Array|String|Null $group_by = null, Array|String|Null $order_by = null, String|Null $order_direction = "<", String|Int|Null $limit_min = null, String|Int|Null $limit_max = null) : String|Bool{
    try{
      $columns_txt    = $this->checksIfIsArrayAndReturns($columns)  ?? '*';
      $conditions_txt = $this->prepareConditions($conditions);
      $group_by_txt   = $this->checksIfIsArrayAndReturns($group_by);
      $order_by_txt   = $this->checksIfIsArrayAndReturns($order_by);
  
      $conditions_txt = $this->checksIfIsNotEmptyAndReturns($conditions_txt, " WHERE ");
      $group_by_txt   = $this->checksIfIsNotEmptyAndReturns($group_by_txt, " GROUP BY ");
  
      $order_by_txt   = $this->returnsOderBySyntax($order_by_txt, $order_direction);

      $limit          = $this->prepareLimitClause($limit_min, $limit_max);

      $table_prepared = $this->prepareTable($table);

      $table_txt      = $this->checksIfIsArrayAndReturns($table_prepared, " INNER JOIN ");
  
      return "SELECT $columns_txt FROM $table_txt $conditions_txt $group_by_txt $order_by_txt $limit;";
    } catch (Exception $e){
      return false;
    }    
  }
  
  protected function SQL_update(String $table, Array $data, Array|String|Null $conditions = null) : Array|Bool{
    if(is_array($data) && $conditions && !empty($conditions)){
      $processed_data = array_map(function($v){return $this->returnProcessedData($v);}, $data);
      $conditions_txt = $this->prepareConditions($conditions);
  
      $conditions_txt = $this->checksIfIsNotEmptyAndReturns($conditions_txt, " WHERE ");

      $columns_values = [];

      foreach($processed_data as $k => $v){
        $column_value = "`$k` = ?";
        array_push($columns_values, $column_value);
      }
  
      $columns_values_txt = $this->checksIfIsArrayAndReturns($columns_values);
  
      $sql = "UPDATE `$table` SET $columns_values_txt $conditions_txt;";
      return ["SQL" => $sql, "VALUES" => $processed_data];
    } else {
      return false;
    }
  }
  
  protected function SQL_delete(String $table, Array|String|Null $conditions = null) : String|Bool{
    $conditions_prepared = $this->prepareConditions($conditions);
  
    $conditions_txt = $this->checksIfIsNotEmptyAndReturns($conditions_prepared, " WHERE ");

    return "DELETE FROM $table $conditions_txt";
  }

  public function execInsert(String $table, Array $data) : Object{
    try{
      $response = $this->SQL_insert($table, $data);
  
      if($response !== false){
        return $this->executeSQL($response['SQL'], ...$response["VALUES"]);
      } else {
        return new ReturnFormat(false, "SQL could not be mounted. Please check the data provided and try again", $response);
      }
    } catch (Exception $e) {
      return new ReturnFormat(false, $e->getMessage(), false);
    }
  }

  public function execSelect(String|Array $table, String|Array|Null $columns = "*", Array|Null $conditions = null, Array|String|Null $group_by = null, Array|String|Null $order_by = null, String|Null $order_direction = "<", String|Int|Null $limit_min = 100, String|Int|Null $limit_max = null) : Object{
    try{
      $response = $this->SQL_select($table, $columns, $conditions, $group_by, $order_by, $order_direction, $limit_min, $limit_max);

      if($response !== false){
        return $this->executeSQL($response);
      } else {
        return new ReturnFormat(false, "SQL could not be mounted. Please check the data provided and try again", $response);
      }
    } catch (Exception $e) {
      return new ReturnFormat(false, $e->getMessage(), false);
    }
  }

  public function execUpdate(String $table, Array $data, Array|String|Null $conditions = null) : Object{
    if(!empty($conditions)){
      try{
        $response = $this->SQL_update($table, $data, $conditions);
  
        if($response !== false){
          return $this->executeSQL($response['SQL'], ...$response['VALUES']);
        } else {
          return new ReturnFormat(false, "SQL could not be mounted. Please check the data provided and try again", $response);
        }
      } catch (Exception $e) {
        return new ReturnFormat(false, $e->getMessage(), false);
      }
    } else {
      return new ReturnFormat(false, "The operation was blocked as it would have been applied to all records in the table", false);
    }
  }

  public function execDelete(String $table, Array|String|Null $conditions = null) : Object{
    if(!empty($conditions)){
      try{
        $response = $this->SQL_delete($table, $conditions);
  
        if($response !== false){
          return $this->executeSQL($response);
        } else {
          return new ReturnFormat(false, "SQL could not be mounted. Please check the data provided and try again", $response);
        }
      } catch (Exception $e) {
        return new ReturnFormat(false, $e->getMessage(), false);
      }
    } else {
      return new ReturnFormat(false, "The operation was blocked as it would have been applied to all records in the table", false);
    }
  }
}