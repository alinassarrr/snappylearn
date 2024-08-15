<?php
require 'config.php';

$userId = $_POST['user_id'];
$courseName = $_POST['course_name'];
$points = $_POST['points'];


$checkQuery = "SELECT * FROM points WHERE user_id = $userId AND course_name = '$courseName'";
$checkResult = $conn->query($checkQuery);

if ($checkResult->num_rows > 0) {
    $updateQuery = "UPDATE points SET total_points = total_points + $points WHERE user_id = $userId AND course_name = '$courseName'";
    $conn->query($updateQuery);
} else {
    $insertQuery = "INSERT INTO points (user_id, course_name, total_points) VALUES ($userId, '$courseName', $points)";
    $conn->query($insertQuery);
}

$conn->close();
?>
