<?php
include 'config.php';

$user_id = $_GET['user_id'];

$result = $mysqli->query("SELECT course_name FROM favorite_courses WHERE user_id = '$user_id'");

$courses = [];

while ($row = $result->fetch_assoc()) {
    $courses[] = $row['course_name'];
}

echo json_encode($courses);

$mysqli->close();
?>
