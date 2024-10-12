# Herramientas de Hacking Ético

Este repositorio contiene herramientas para hacking ético, diseñadas para facilitar el análisis y la evaluación de sistemas de manera segura y responsable. Las herramientas aquí publicadas combinan recopilación de información de Internet con personalización y/o creación específica.

## Herramientas Incluidas

### `info_sistemas.sh`

Esta herramienta ha sido adaptada del canal de YouTube de [@ElPinguinoDeMario](https://www.youtube.com/@ElPinguinoDeMario). Está diseñada para recopilar información sobre sistemas de manera eficiente.

### `escaneo_puertos.sh`

Utiliza `netcat` junto con una serie de ajustes para realizar el escaneo de múltiples puertos simultáneamente. Este método agiliza el proceso y lo hace menos detectable (pero no invisible).

### `escaneo_red.sh`

Este script realiza un escaneo de una red local, revisando si los puertos 22 (SSH) y 80 (HTTP) están abiertos en cada IP del rango proporcionado. Usa `netcat` para hacer comprobaciones rápidas de los puertos, mostrando si están abiertos.

## Uso
```bash ./escaneo_red.sh <RED_LOCAL>```
Asegúrate de tener los permisos necesarios antes de usar estas herramientas en cualquier sistema. El uso indebido de estas herramientas puede ser ilegal y contra las políticas de la plataforma en la que operes.

## Contribuciones

Si deseas contribuir a mejorar estas herramientas o añadir nuevas funcionalidades, siéntete libre de abrir un issue o enviar una solicitud de extracción (pull request).

## Copyright

© 2024 [Y3i$i]. Todos los derechos reservados.

