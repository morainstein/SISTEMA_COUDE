# database-handler-php
A set of files that deliver database manipulation functionality

## Database
```SQL
  CREATE DATABASE IF NOT EXISTS `test_db_handler` COLLATE utf8mb3_general_ci;

  USE  `test_db_handler`;

  CREATE TABLE IF NOT EXISTS `people` (
    `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `job` varchar(100) DEFAULT NULL,
    `hobbie` varchar(100) DEFAULT NULL
  );

  INSERT INTO `people`(`name`, `job`, `hobbie`) VALUES
  ('Zerrai Mundo','doctor','Swiming'),
  ('Joma Theus',NULL,'Chess'),
  ('Maria Lisse','NULL',NULL);

  CREATE TABLE IF NOT EXISTS `type_people` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`)
  );

  INSERT INTO `type_people`(`name`) VALUES
  ('p1'),
  ('p2'),
  ('p3');

  CREATE TABLE IF NOT EXISTS `type_has_people` (
    `id_type` int DEFAULT NULL,
    `id_person` int DEFAULT NULL,
    CONSTRAINT `type_has_people_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `type_people` (`id`),
    CONSTRAINT `type_has_people_ibfk_2` FOREIGN KEY (`id_person`) REFERENCES `people` (`id`)
  );

  INSERT INTO `type_has_people` VALUES
  (1,1),
  (2,2),
  (3,3);
```

## Test Values
```php
  <?php
    # connect_values.php
    define('DB_HOST', 'localhost');
    define('DB_USER', 'root');
    define('DB_PASS', '');
    define('DB_NAME', 'test_db_handler');
```

## Connection
```php
  <?php
    # connect_use_connection.php
    use Handlers\Connection;

    $PDO = new Connection(DB_HOST, DB_USER, DB_PASS, DB_NAME);
```

## Connection whith SQL functionality
```php
  <?php
    # connect_use_sql_crud.php
    use Handlers\SQL_CRUD;

    $crud = new SQL_CRUD(DB_HOST, DB_USER, DB_PASS, DB_NAME);
```

## General SQL CRUD Functionality
### Insert
```php
  <?php
    # crud.php
    $data_insert = [
      "id" => 20,
      "name" => "Claris Pector",
      "job" => "Web Developer",
      "hobbie" => 'soccer'
    ];

    $response = $crud->execInsert("people", $data_insert);
    var_dump($response);
```

### Select
```php
  <?php
    # crud.php
    $response = $crud->execSelect("people");
    var_dump($response);

    echo "<br><br>";

    $response = $crud->execSelect("people", null, null, null, 'id', '>');
    var_dump($response);
    
    echo "<br><br>";
   
    $tables = [
      " people P " => [],
      " type_has_people THP " => [["THP.id_person", "P.id"]],
      " type_people TP " => [["TP.id", "THP.id_type"]]
    ];

    $columns = [
      " COUNT(*) `repeat` ",
      " P.job ",
      " TP.name name_type "
    ];

    $conditions = [
      ['P.id', 20],
      " P.job LIKE '%doctor%' "
    ];

    $group_by = [
      " P.job ",
      " THP.id_type "
    ];

    $response = $crud->execSelect($tables, $columns, $conditions, $group_by, '`repeat`', '>', 0, 100);
    var_dump($response);
```

### Update
```php
  <?php
    # crud.php
    $data_update = [
      "job" => "doctor of codes"
    ];

    $conditions = [
      ['id', 20]
    ];

    $response = $crud->execUpdate("people", $data_update, $conditions);
    var_dump($response);
```

### Delete
```php
  <?php
    # crud.php
    $response = $crud->execDelete("people", [["id", 20]]);
    var_dump($response);
```