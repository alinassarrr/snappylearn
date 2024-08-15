<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

require 'config.php';

// Retrieve data from the request
$data = json_decode(file_get_contents('php://input'), true);

$username = $data['username'];
$password = $data['password'];

// Hash the password
$hashedPassword = password_hash($password, PASSWORD_DEFAULT);

// Insert new user into the users table
$stmt = mysqli_prepare($con, "INSERT INTO users (username, password) VALUES (?, ?)");
mysqli_stmt_bind_param($stmt, "ss", $username, $hashedPassword);
$result = mysqli_stmt_execute($stmt);

if ($result) {
    echo json_encode(array('message' => 'Signup successful'));
} else {
    echo json_encode(array('error' => 'Error during signup: ' . mysqli_error($con)));
}

mysqli_stmt_close($stmt);
mysqli_close($con);
?>
