<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$db_host = 'rds698-mydbinstance-qfjghsjrhrkc.cmtoeaqe4zjy.us-east-1.rds.amazonaws.com';
$db_name = 'cloudprojectdb';
$db_user = 'admin';
$db_pass = '*********';

$conn = new mysqli($db_host, $db_user, $db_pass, $db_name);

if ($conn->connect_error) {
    echo "Database connection failed: " . $conn->connect_error;
} else {
    echo "Database connection successful to database '$db_name' on '$db_host'.";
}

$conn->close();
?>
