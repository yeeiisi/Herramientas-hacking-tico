#!/bin/bash

clear

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

echo -e "\e[34m"
echo "Bienvenid@ a la herramienta para vagos."
echo "A continuación, se aplicará un nmap a una dirección ip y un gobuster a la misma..."
echo -e "\e[35m"
echo

# Pedir la dirección IP de la máquina objetivo
read -e -p "Introduce la IP de la máquina a escanear: " ip_target

# Verificar si se ha introducido una IP válida
if [[ -z "$ip_target" ]]; then
    echo -e "\e[38;5;196m"
    echo "No has introducido una IP válida. Saliendo..."
    echo -e "\e[0m"
    exit 1
fi

# Identificar el SO de la ip objetivo

echo -e "\e[35m"
echo "Identificando el SO de la víctima..."
echo
echo -e "\e[38;5;196m"

ping_output=$(ping -c 1 $ip_target)

# Mostrar la salida del ping
echo "Salida del ping:"
echo -e "\e[32m"
echo "$ping_output"

# Extraer el TTL
ttl_value=$(echo "$ping_output" | grep 'ttl=' | awk -F 'ttl=' '{print $2}' | awk '{print $1}')

# Mostrar el valor TTL
if [ -n "$ttl_value" ]; then
    echo
    echo -e "\e[38;5;196m"
    echo "TTL detectado: $ttl_value"
    # Convertir el TTL a un número entero para comparación
    ttl_number=$(echo "$ttl_value" | sed 's/[^0-9]//g')

    case $ttl_number in
        [6][0-9]|[7][0-9]|[8][0-9]|[9][0-9]|1[0-2][0-9])
            echo "Posible sistema operativo: Linux o Unix."
            ;;
        1[2][0-9]|1[3-9][0-9]|[2-9][0-9][0-9])
            echo "Posible sistema operativo: Windows."
            ;;
        2[5][5])
            echo "Posible sistema operativo: Cisco o algunos dispositivos de red."
            ;;
        *)
            echo "TTL no reconocido, es posible que el sistema operativo esté utilizando un TTL personalizado o que esté detrás de un firewall."
            ;;
    esac
else
    echo "No se pudo determinar el TTL."
fi
echo -e "\e[0m"

# Escaneo sigiloso y rápido con nmap
echo -e "\e[35m"
echo "Iniciando escaneo sigiloso con nmap en la IP $ip_target..."
nmap_result=$(nmap -sS -sV -p- --min-rate=1000 -T2 -Pn $ip_target)

# Mostrar resultados del escaneo
echo -e "\e[32m"
echo "$nmap_result" | awk '/open/{print $1 " " $3}' | sort -u
echo -e "\e[0m"

# Obtener la URL redirigida del encabezado Location
redirect_url=$(curl -sI http://$ip_target | grep -i 'Location:' | awk '{print $2}' | tr -d '\r')

if [[ -z "$redirect_url" ]]; then
    echo "No se pudo obtener la URL de redirección."
    exit 1
fi

# Verificar si el puerto 80 está abierto
if echo "$nmap_result" | grep -q "80/tcp open"; then
    echo -e "\e[32m"
    echo "Puerto HTTP (80) abierto."
    echo -e "\e[35m"
    echo "Realizando fuzzing de directorios con Gobuster..."
    # Ejecutar gobuster en el puerto 80
    gobuster dir -u $redirect_url -w /usr/share/wordlists/dirb/common.txt
    echo -e "\e[32m"
    echo "$gobuster_output" | grep -E "^[0-9]+/"
    echo -e "\e[0m"
else
    echo -e "\e[38;5;196m"
    echo "Puerto HTTP (80) no abierto o inaccesible."
    echo -e "\e[0m"
fi

# Finalizar
echo -e "\e[35m"
echo "Escaneo finalizado."
echo -e "\e[0m"
