#!/bin/bash

# Definir colores
GREEN='\033[38;2;0;255;0m'
ROJO='\033[38;5;160m'
MAGENTA='\033[1;33m'
NC='\033[0m' # Sin color

echo "Github: https://github.com/yeeiisi" >> /dev/null

# Función para escanear puertos usando netcat
scan_port() {
  local IP=$1
  local PORT=$2
  local LOCKFILE="/tmp/scan_lock"

  # Intentar conectarse al puerto
  nc -z -v -w 1 $IP $PORT 2>/dev/null

  # Si el puerto está abierto
  if [ $? -eq 0 ]; then
    {
      echo -e "${GREEN}[+] Puerto $PORT está abierto${NC}"

      # Mostrar un servicio típico si es reconocido
      case $PORT in
        21) echo -e "${MAGENTA}[-] Servicio: FTP${NC}" ;;
        22) echo -e "${MAGENTA}[-] Servicio: SSH${NC}" ;;
        23) echo -e "${MAGENTA}[-] Servicio: Telnet${NC}" ;;
        25) echo -e "${MAGENTA}[-] Servicio: SMTP${NC}" ;;
        80) echo -e "${MAGENTA}[-] Servicio: HTTP${NC}" ;;
        443) echo -e "${MAGENTA}[-] Servicio: HTTPS${NC}" ;;
        3306) echo -e "${MAGENTA}[-] Servicio: MySQL${NC}" ;;
        3389) echo -e "${MAGENTA}[-] Servicio: RDP${NC}" ;;
        53) echo -e "${MAGENTA}[-] Servicio: DNS${NC}" ;;
        8080) echo -e "${MAGENTA}[-] Servicio: HTTP (Proxy)${NC}" ;;
        *) echo -e "${MAGENTA}[-] Servicio: Desconocido${NC}" ;;
      esac
    } >> /tmp/scan_output.log
  fi
}

# Función principal para escanear múltiples puertos
port_scan() {
  local IP=$1
  local START_PORT=$2
  local END_PORT=$3
  local PROCESSES=10 # Número de procesos paralelos

  echo -e "${ROJO}Escaneando la IP: $IP desde el puerto $START_PORT hasta el puerto $END_PORT...${NC}"

  # Crear una lista de puertos
  local PORTS=()
  for ((PORT=START_PORT; PORT<=END_PORT; PORT++)); do
    PORTS+=($PORT)
  done

  scan_ports_in_parallel() {
    local PORTS=("${!1}")
    local IP=$2
    local TOTAL=${#PORTS[@]}
    local CURRENT=0

    for PORT in "${PORTS[@]}"; do
      scan_port $IP $PORT &
      ((CURRENT++))
      # Controlar el número de procesos paralelos
      if (( $(jobs -r | wc -l) >= PROCESSES )); then
        wait -n
      fi
    done
    wait
    cat /tmp/scan_output.log
    rm /tmp/scan_output.log
  }

  # Dividir los puertos en bloques para controlar el número de procesos
  local BLOCK_SIZE=50
  for ((i=0; i<${#PORTS[@]}; i+=BLOCK_SIZE)); do
    local PORT_BLOCK=("${PORTS[@]:i:BLOCK_SIZE}")
    scan_ports_in_parallel PORT_BLOCK[@] $IP
  done
}

# Validar parámetros
if [ $# -ne 3 ]; then
  echo -e "${ROJO}Uso: $0 <IP> <PUERTO_INICIAL> <PUERTO_FINAL>${NC}"
  exit 1
fi

# Ejecutar escaneo de puertos
port_scan $1 $2 $3
