<?php
require 'config.php';

$userId = $_GET['user_id'];
$courseName = $_GET['course_name'];

$retrieveQuery = "SELECT total_points FROM points WHERE user_id = '$userId' AND course_name = '$courseName'";
$result = $conn->query($retrieveQuery);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $totalPoints = $row['total_points'];
    echo $totalPoints;
} else {
    echo "0";
}

$conn->close();
?>
