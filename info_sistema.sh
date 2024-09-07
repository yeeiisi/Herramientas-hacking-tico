# Definir colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Sin color

echo -e "${BLUE}====================================${NC}"
echo -e "${YELLOW}Información del sistema${NC}"
echo -e "${BLUE}====================================${NC}"

echo -e "${GREEN}Sistema Operativo:${NC}"
uname -a

echo ""
echo -e "${GREEN}Distro de Linux:${NC}"
lsb_release -a 2>/dev/null || echo "lsb_release no disponible"

echo ""
echo -e "${GREEN}Versión del Kernel:${NC}"
uname -r

echo ""
echo -e "${GREEN}Tiempo de Actividad del sistema:${NC}"
uptime

echo ""
echo -e "${GREEN}Espacio en Disco:${NC}"
df -h

echo ""
echo -e "${GREEN}Información de la Red:${NC}"
ip a

echo ""
echo -e "${GREEN}Conexiones de Red Activas:${NC}"
ss -tuln

echo ""
echo -e "${GREEN}Archivos de Configuración de Red:${NC}"
cat /etc/hosts
cat /etc/resolv.conf

echo ""
echo -e "${GREEN}Binarios con Permisos SUID:${NC}"
find / -perm -4000 2>/dev/null

echo ""
echo -e "${GREEN}Comandos que se pueden ejecutar como SUDO:${NC}"
sudo -l
