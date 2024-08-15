<?php

include 'config.php';

$data = json_decode(file_get_contents('php://input'), true);

$user_id = $data['user_id'];
$course_name = $data['course_name'];

$stmt = $mysqli->prepare("DELETE FROM favorite_courses WHERE user_id = ? AND course_name = ?");

if ($stmt === false) {
    echo "Error preparing statement";
    exit();
}

$stmt->bind_param("ss", $user_id, $course_name);

if ($stmt->execute()) {
    echo "1";
} else {
    echo "Error executing statement: " . $stmt->error;
}

$stmt->close();

$mysqli->close();
?>
