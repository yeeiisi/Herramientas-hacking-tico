# Herramientas de Hacking Ético

Este repositorio contiene herramientas para hacking ético, diseñadas para facilitar el análisis y la evaluación de sistemas de manera segura y responsable. Las herramientas aquí publicadas combinan recopilación de información de Internet con personalización y/o creación específica.

## Herramientas Incluidas

### `info_sistemas.sh`

Esta herramienta ha sido adaptada del canal de YouTube de [@ElPinguinoDeMario](https://www.youtube.com/@ElPinguinoDeMario). Está diseñada para recopilar información sobre sistemas de manera eficiente.

### `escaneo_puertos.sh`

Utiliza `netcat` junto con una serie de ajustes para realizar el escaneo de múltiples puertos simultáneamente. Este método agiliza el proceso y lo hace menos detectable (pero no invisible).

### `escaneo_red.sh`

Este script realiza un escaneo de una red local, revisando si los puertos 22 (SSH) y 80 (HTTP) están abiertos en cada IP del rango proporcionado. Usa `netcat` para hacer comprobaciones rápidas de los puertos, mostrando si están abiertos.

### `nmap_gobuster.sh`

Esta herramienta combina el uso de `nmap` y `gobuster` para realizar un análisis exhaustivo de una máquina objetivo. Primero, realiza un escaneo sigiloso de todos los puertos usando `nmap` y, en caso de que el puerto 80 esté abierto, utiliza `gobuster` para realizar fuzzing de directorios en la URL detectada.

#### Características:
- Detecta el sistema operativo de la máquina objetivo basándose en el valor TTL.
- Realiza un escaneo rápido de todos los puertos utilizando `nmap`.
- Ejecuta un fuzzing de directorios en el puerto 80, en caso de estar abierto, con la herramienta `gobuster`.


## Uso
```bash ./escaneo_red.sh <RED_LOCAL>``` (se le deben dar permisos de ejecución a los archivos ```chmod +x archivo.sh```)
Asegúrate de tener los permisos necesarios antes de usar estas herramientas en cualquier sistema. El uso indebido de estas herramientas puede ser ilegal y contra las políticas de la plataforma en la que operes.

## Contribuciones

Si deseas contribuir a mejorar estas herramientas o añadir nuevas funcionalidades, siéntete libre de abrir un issue o enviar una solicitud de extracción (pull request).

## Copyright

© 2024 [Y3i$i]. Todos los derechos reservados.

