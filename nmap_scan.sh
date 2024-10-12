#!/bin/bash

# Función para mostrar el menú
show_menu() {
    echo "Seleccione el tipo de escaneo que desea realizar:"
    echo "1. Escaneo de puertos estándar"
    echo "2. Escaneo de servicios y versiones"
    echo "3. Escaneo de sistemas operativos"
    echo "4. Escaneo de scripts NSE"
    echo "5. Escaneo de vulnerabilidades con NSE"
    echo "6. Escaneo de puertos UDP"
    echo "7. Escaneo agresivo"
    echo "8. Escaneo de trazado de red"
    echo "9. Todos los escaneos"
    echo "0. Salir"
    read -rp "Ingrese el número de la opción deseada: " option
}

# Verificar si se ha proporcionado una dirección IP
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <dirección_ip>"
    exit 1
fi

ip="$1"
output_dir="./nmap_scan_results"
mkdir -p "$output_dir"

while true; do
    show_menu

    case $option in
        1)
            echo "Iniciando escaneo de puertos estándar..."
            nmap -sS -p- "$ip" -oN "$output_dir/standard_ports.txt"
            echo "Escaneo de puertos estándar completado."
            ;;
        2)
            echo "Iniciando escaneo de servicios y versiones..."
            nmap -sV "$ip" -oN "$output_dir/services_versions.txt"
            echo "Escaneo de servicios y versiones completado."
            ;;
        3)
            echo "Iniciando escaneo de sistemas operativos..."
            nmap -O "$ip" -oN "$output_dir/os_detection.txt"
            echo "Escaneo de sistemas operativos completado."
            ;;
        4)
            echo "Iniciando escaneo de scripts NSE..."
            nmap -sC "$ip" -oN "$output_dir/nse_scripts.txt"
            echo "Escaneo de scripts NSE completado."
            ;;
        5)
            echo "Iniciando escaneo de vulnerabilidades con scripts NSE..."
            nmap --script vuln "$ip" -oN "$output_dir/nse_vuln.txt"
            echo "Escaneo de vulnerabilidades completado."
            ;;
        6)
            echo "Iniciando escaneo de puertos UDP..."
            nmap -sU -p- "$ip" -oN "$output_dir/udp_ports.txt"
            echo "Escaneo de puertos UDP completado."
            ;;
        7)
            echo "Iniciando escaneo agresivo..."
            nmap -A "$ip" -oN "$output_dir/aggressive_scan.txt"
            echo "Escaneo agresivo completado."
            ;;
        8)
            echo "Iniciando escaneo de trazado de red..."
            nmap --traceroute "$ip" -oN "$output_dir/traceroute.txt"
            echo "Escaneo de trazado de red completado."
            ;;
        9)
            echo "Iniciando todos los escaneos..."
            echo "1. Escaneo de puertos estándar..."
            nmap -sS -p- "$ip" -oN "$output_dir/standard_ports.txt"
            echo "Escaneo de puertos estándar completado."
            echo "2. Escaneo de servicios y versiones..."
            nmap -sV "$ip" -oN "$output_dir/services_versions.txt"
            echo "Escaneo de servicios y versiones completado."
            echo "3. Escaneo de sistemas operativos..."
            nmap -O "$ip" -oN "$output_dir/os_detection.txt"
            echo "Escaneo de sistemas operativos completado."
            echo "4. Escaneo de scripts NSE..."
            nmap -sC "$ip" -oN "$output_dir/nse_scripts.txt"
            echo "Escaneo de scripts NSE completado."
            echo "5. Escaneo de vulnerabilidades con NSE..."
            nmap --script vuln "$ip" -oN "$output_dir/nse_vuln.txt"
            echo "Escaneo de vulnerabilidades completado."
            echo "6. Escaneo de puertos UDP..."
            nmap -sU -p- "$ip" -oN "$output_dir/udp_ports.txt"
            echo "Escaneo de puertos UDP completado."
            echo "7. Escaneo agresivo..."
            nmap -A "$ip" -oN "$output_dir/aggressive_scan.txt"
            echo "Escaneo agresivo completado."
            echo "8. Escaneo de trazado de red..."
            nmap --traceroute "$ip" -oN "$output_dir/traceroute.txt"
            echo "Escaneo de trazado de red completado."
            ;;
        0)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción inválida. Inténtelo de nuevo."
            ;;
    esac

    # Preguntar si el usuario desea realizar otro escaneo
    read -rp "¿Desea realizar otro escaneo? (s/n): " continue
    if [ "$continue" != "s" ] && [ "$continue" != "S" ]; then
        echo "Saliendo..."
        exit 0
    fi
done
