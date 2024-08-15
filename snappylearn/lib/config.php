<?php
define("DB_SERVER", "localhost");
define("DB_USER", "id21760709_snappy");
define("DB_PASSWORD", "Ali@000webhost1");
define("DB_DBNAME", "id21729332_snappylearn");

$mysqli = new mysqli(DB_SERVER, DB_USER, DB_PASSWORD, DB_DBNAME);

if ($mysqli->connect_error) {
    die("Error connecting to the server: " . $mysqli->connect_error);
}

if (!$mysqli->set_charset("utf8")) {
    echo "Error setting character set: " . $mysqli->error;
    exit();
}


?>
