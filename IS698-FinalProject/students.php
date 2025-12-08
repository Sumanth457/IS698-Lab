<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$db_host = 'rds698-mydbinstance-qfjghsjrhrkc.cmtoeaqe4zjy.us-east-1.rds.amazonaws.com';
$db_name = 'cloudprojectdb';
$db_user = 'admin';
$db_pass = 'admin1234';

$conn = new mysqli($db_host, $db_user, $db_pass, $db_name);

if ($conn->connect_error) {
    die("Database connection failed: " . $conn->connect_error);
}

$sql = "SELECT id, name, major, year FROM students";
$result = $conn->query($sql);
?>
<!DOCTYPE html>
<html>
<head>
    <title>Student Records</title>
</head>
<body>
    <h1>Student Records from RDS</h1>

    <?php if ($result && $result->num_rows > 0): ?>
        <table border="1" cellpadding="8" cellspacing="0">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Major</th>
                <th>Year</th>
            </tr>
            <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $row['id']; ?></td>
                    <td><?php echo $row['name']; ?></td>
                    <td><?php echo $row['major']; ?></td>
                    <td><?php echo $row['year']; ?></td>
                </tr>
            <?php endwhile; ?>
        </table>
    <?php else: ?>
        <p>No student records found.</p>
    <?php endif; ?>

</body>
</html>
<?php
$conn->close();
?>
