# fish-shell-utilities
This repository holds my .fish files

## update-pdf-keywords

This script allows you to change the keywords of a PDF file. Simply run this command, and you will be prompted to enter the full path to the pdf file (which also can be done via drag-and-drop) and the keywords you want to add. The script will execute via `pdftk` (and will alert the user if the utility is not installed) and create a brand new pdf file (in the same folder as the input pdf file and with the same filename, but with an added suffix of `-updated`). The script *DOES NOT* remove nor overwrite the original pdf file.

## software-update

This script is written for Debian-based Linux distributions (Debian, Ubuntu, Zorin, Mint, Pop!_OS, etc.) and updates the packages of the system by updating the native ones (from apt), the ones installed via flatpak and the ones installed via snap. It also removes unused packages.

## compress-pdf

This script requires `ghostscript` to be installed (will automatically install it on Debian-based Linux distributions if it cannot find it). Example usage:
`compress-pdf --input "/path/to/file.pdf" --quality medium --output "/path/to/compressed_file.pdf"` or `compress-pdf -i "/path/to/file.pdf" -q medium -o "/path/to/compressed_file.pdf"`. It can also be run as `compress-pdf` and the user is prompted to type the full path to the input pdf file, the full path to the output compressed pdf file and the quality. Quality can be picked between `low`, `medium` and `high`. The only mandatory parameter is the input pdf file. If not specified, the output compressed pdf file will be located in the same folder as the original, with the same file name but having the `-compressed` suffix. If not specified, the compression quality will be set to `medium`.

## convert-mp3

This script uses ffmpeg to convert audio files to mp3. Example usage: `convert-mp3 \path\to\audio.file`. This will generate an mp3 file with a frequency of 192k.
`ffmpeg` can be installed via `sudo apt install -y ffmpeg`.

## change-extension

This script manipulates an input string to produce a new string. Should be used like shown in the following two examples: `change-extension --input /path/to/file.pdf --extension doc` or alternatively `change-extension -i /path/to/file.pdf -e doc` and the output will be *a string* having value: `/path/to/file.doc`. *NOTE:* this command does *NOT* alter the file system. Use `change-file-extension` to do that instead.

## change-file-extension

This script renames a file at the file system level. Usage example: `change-file-extension -i /path/to/file.pdf -e doc` or `change-file-extension --input /path/to/file.pdf --extension doc`. Result is the input file renamed to `/path/to/file.doc`

## download-yt-audio

This script allows you to download an mp3 file from YewTube/Piped/youtube. Example of usage: `download-yt-audio --url "https://piped.video/watch?v=BW0gXbEVYgA" --output $HOME/Desktop` or alternatively `download-yt-audio --u "https://piped.video/watch?v=BW0gXbEVYgA" --o $HOME/Desktop`. If the `--output` \ `-o` is unspecified, the `$PWD` (current terminal folder) is used instead. This script relies on `yt-dlp` to be installed. If it isn't, then please execute the following: `sudo apt install -y python3 python-is-python3 && pip install yt-dlp` (on Debian-based Linux distributions such as Ubuntu, Zorin, Mint, Pop!_OS, etc.). Also relies on `ffmpeg` so please install it via `sudo apt install -y ffmpeg`.

## download-yt-video

This script allows you to download an mp3 file from YewTube/Piped/youtube. Example of usage: `download-yt-video --url "https://piped.video/watch?v=BW0gXbEVYgA" --output $HOME/Desktop` or alternatively `download-yt-video --u "https://piped.video/watch?v=BW0gXbEVYgA" --o $HOME/Desktop`. If the `--output` \ `-o` is unspecified, the `$PWD` (current terminal folder) is used instead. This script relies on `yt-dlp` to be installed. If it isn't, then please execute the following: `sudo apt install -y python3 python-is-python3 && pip install yt-dlp` (on Debian-based Linux distributions such as Ubuntu, Zorin, Mint, Pop!_OS, etc.). Also relies on `ffmpeg` so please install it via `sudo apt install -y ffmpeg`.

