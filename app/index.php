<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple PHP-MySQL App</title>
</head>
<body>

<h1>Users List</h1>

<?php
error_reporting(E_ALL);
ini_set('display_errors', 'On');

// Replace these with your MySQL database credentials
$servername = getcwd('DB_HOST');
$username = getcwd('DB_USER');
$password = getcwd('DB_PASSWORD');
$database = getcwd('DB_NAME');

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve and display users from the table
$sqlSelectUsers = "SELECT * FROM users";
$result = $conn->query($sqlSelectUsers);

if ($result->num_rows > 0) {
    echo "<ul>";
    while ($row = $result->fetch_assoc()) {
        echo "<li>ID: " . $row["id"] . " - Username: " . $row["username"] . " - Email: " . $row["email"] . "</li>";
    }
    echo "</ul>";
} else {
    echo "<p>No users found in the 'users' table.</p>";
}

// Close the database connection
$conn->close();
?>

</body>
</html>
