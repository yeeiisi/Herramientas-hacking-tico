#Definir los colores
GREEN='\033[38;2;0;255;0m'
ROJO='\033[38;5;160m'
BLUE='\033[38;2;0;0;255m'
NC='\033[0m' # Sin color (reset)
echo -e "${ROJO}====================================${NC}"
echo -e "${ROJO}Información del sistema${NC}"
echo -e "${ROJO}====================================${NC}"

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
