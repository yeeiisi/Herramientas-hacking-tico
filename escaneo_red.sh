#!/bin/bash

# Definir colores
GREEN='\033[38;2;0;255;0m'
ROJO='\033[38;5;160m'
MAGENTA='\033[1;33m'
RESET='\033[0m'

show_watermark() {
    echo -e "\e[38;5;196m"
    echo "==========================================="
    banner_text="Y3i\$i"

    banner_output=$(figlet -k "$banner_text")
    tabulation="        "
    echo "$banner_output" | while IFS= read -r line; do
        echo -e "${tabulation}${line}"
    done

    echo
    echo "Github: https://github.com/yeeiisi"
    echo "Telegram: @yeeiisi"
    echo
    echo "==========================================="

    echo -e "\e[0m"
}

# Mostrar marca de agua
show_watermark

# Verificar el uso del script
if [ "$#" -ne 1 ]; then
    echo -e "${ROJO}Uso: $0 <RED_LOCAL>${RESET}"
    exit 1
fi

RED_LOCAL="$1"
RANGO_INICIO=1
RANGO_FIN=254

# Escanea cada IP
for i in $(seq $RANGO_INICIO $RANGO_FIN); do
    IP="$RED_LOCAL.$i"
    echo -e "${MAGENTA}Escaneando $IP...${RESET}"

    # nc para comprobar si el puerto 22 está abierto
    nc -z -w 1 $IP 22 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Puerto 22 abierto en $IP${RESET}"
    fi

    # nc para comprobar si el puerto 80 está abierto
    nc -z -w 1 $IP 80 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Puerto 80 abierto en $IP${RESET}"
    fi

done

