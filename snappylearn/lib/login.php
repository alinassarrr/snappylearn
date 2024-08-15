<?php

require 'config.php';

$jsonData = file_get_contents('php://input');


$data = json_decode($jsonData, true);

if ($data !== null) {
    $username = addslashes(strip_tags($data['username']));
    $password = addslashes(strip_tags($data['password']));

$sql = "SELECT * From users where username='$username'";
if ($result = mysqli_query($con,$sql))
  {
   $emparray = array();
   while($row =mysqli_fetch_assoc($result))
       $emparray[] = $row;

  echo(json_encode($emparray));
  mysqli_free_result($result);
  mysqli_close($con);
}}

?>