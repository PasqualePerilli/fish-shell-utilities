# fish-shell-utilities
This repository holds my .fish files

## update-pdf-keywords

This script allows you to change the keywords of a PDF file. Simply run this command, and you will be prompted to enter the full path to the pdf file (which also can be done via drag-and-drop) and the keywords you want to add. The script will execute via `pdftk` (and will alert the user if the utility is not installed) and create a brand new pdf file (in the same folder as the input pdf file and with the same filename, but with an added suffix of `-updated`). The script *DOES NOT* remove nor overwrite the original pdf file.

## software-update

This script is written for Debian-based Linux distributions (Debian, Ubuntu, Zorin, Mint, Pop!_OS, etc.) and updates the packages of the system by updating the native ones (from apt), the ones installed via flatpak and the ones installed via snap. It also removes unused packages.

## compress-pdf

This script requires `ghostscript` to be installed (will automatically install it on Debian-based Linux distributions if it cannot find it). Usage is like this:
`compress-pdf --input "/path/to/file.pdf" --quality medium --output "/path/to/compressed_file.pdf"` or `compress-pdf -i "/path/to/file.pdf" -q medium -o "/path/to/compressed_file.pdf"`. It can also be run as `compress-pdf` and the user is prompted to type the full path to the input pdf file, the full path to the output compressed pdf file and the quality. Quality can be picked between `low`, `medium` and `high`. The only mandatory parameter is the input pdf file. If not specified, the output compressed pdf file will be located in the same folder as the original, with the same file name but having the `-compressed` suffix. If not specified, the compression quality will be set to `medium`.

## convert-mp3

This script uses ffmpeg to convert audio files to mp3. Usage is simple: `convert-mp3 \path\to\audio.file`. This will generate an mp3 file with a frequency of 192k.
