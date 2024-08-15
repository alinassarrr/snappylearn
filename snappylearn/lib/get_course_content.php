<?php
require 'config.php';

$courseName = $_GET['course_name'];

$result = $mysqli->query("SELECT front_text, back_text FROM course_content WHERE course_name = '$courseName'");

$content = [];

while ($row = $result->fetch_assoc()) {
    $content[] = [
        'front_text' => $row['front_text'],
        'back_text' => $row['back_text'],
    ];
}

echo json_encode($content);
?>
