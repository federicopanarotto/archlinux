# ARCHLINUX

Do-It-Yourself > the user build the system  
Architecture > x86_64  
Filesystem Hierarchy: https://man.archlinux.org/man/file-hierarchy.7

##
### SYSTEMD


**systemd** > init system  

Suite of basic building blocks. It provides system and service manager that runs as PID 1    
Suite di demoni > librerie e utilità di amministrazione progettate con lo scopo di centralizzare la gestione e la configurazione del sistema operativo

Rimpiazza l'init  
**INIT** > primo processo che il kernel manda in esecuzione dopo che il computer ha terminato la fase di bootstrap. Porta il sistema in uno stato operativo avviando i programmi e i servizi necessari. Per questo motivo ha PID 1.

File di configurazione /etc/inittab  
Unifica le configuarazioni base dei servizi della distribuzione linux  

base command > systemctl  
examining the system state and managing the system and services

``DOCUMENTATION``: https://wiki.archlinux.org/title/Systemd

##
### SYSLINUX

**syslinux** > collection of boot loaders capable of booting from drives  
It support variuous file systems  

``DOCUMENTATION``: https://wiki.archlinux.org/title/Syslinux

##
### PACMAN

**pacman** > package manager  

It combines a simple binary package format with an easy-to-use build system  
It takes packages from official repositories of archlinux  

This is a list o base pacman commands  
Install package  

	pacman -S package_name  

Remove package

	pacman -R package_name  

Update system

	pacman -Syu  

So with pacman you can managing the application install/unistall process and take update the system

``DOCUMENTATION``: https://wiki.archlinux.org/title/pacman

##