<?php
    require_once __DIR__ . DIRECTORY_SEPARATOR . ".." . DIRECTORY_SEPARATOR . ".." . DIRECTORY_SEPARATOR . "vendor" . DIRECTORY_SEPARATOR . "autoload.php";

    session_start();
    verificaLogin();

    function verificaLogin(){
        $script_name_arr  = explode("/", $_SERVER['SCRIPT_NAME']);
        $script_full_name = $script_name_arr[count($script_name_arr)-1];
        $script_name      = explode('.', $script_full_name)[0];

        $logado = (bool)@$_SESSION['id_usuario'];

        if(!$logado && $script_name != "login" && !$GLOBALS['PERMITIDO']){
            header("Location: /login.php");
        } else if ($logado && $script_name == "login") {
            header("Location: /");
        }
    }
    
    function retornarCaminhoAPartirDoHost(...$parts) : String{
        $path = implode(DIRECTORY_SEPARATOR, $parts);

        return $_SERVER['ROOT_DIRECTORY'] . $path;
    }

    function returnsArrayConditions($conditions){
        if(is_array($conditions)){
            $new_conditions = array_filter($conditions, function($v){
                if(is_array($v) && !empty($v[0]) && !empty($v[1])){
                    return $v;
                } else if (!is_array($v) && !empty($v)) {
                    return $v;
                }
            });

            return $new_conditions;
        } else {
            return null;
        }
    }

    function printHide($val, $id){
        echo '<div id="'. $id .'" style="display:none;">';
        var_dump($val);
        echo '</div>';
    }

    function dumpDie($pre_format, ...$val){
        foreach($val as $v){
            if($pre_format){
                echo "<pre>";
            }

            var_dump($v);

            if($pre_format){
                echo "</pre>";
            } else {
                echo "\n";
            }
        }

        die('');
    }