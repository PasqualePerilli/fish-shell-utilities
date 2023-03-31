# fish-shell-utilities
This repository holds my .fish files

## update-pdf-keywords

This script allows you to change the keywords of a PDF file. Simply run this command, and you will be prompted to enter the full path to the pdf file (which also can be done via drag-and-drop) and the keywords you want to add. The script will execute via `pdftk` (and will alert the user if the utility is not installed) and create a brand new pdf file (in the same folder as the input pdf file and with the same filename, but with an added suffix of `-updated`). The script *DOES NOT* remove nor overwrite the original pdf file.

## software-update

This script is written for Debian-based Linux distributions (Debian, Ubuntu, Zorin, Mint, Pop!_OS, etc.) and updates the packages of the system by updating the native ones (from apt), the ones installed via flatpak and the ones installed via snap. It also removes unused packages.

