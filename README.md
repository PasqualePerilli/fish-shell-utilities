# fish-shell-utilities
This repository holds my .fish files

## update-pdf-keywords

This script allows you to change the keywords of a PDF file. Simply run this command, and you will be prompted to enter the full path to the pdf file (which also can be done via drag-and-drop) and the keywords you want to add. The script will execute via `pdftk` (and will alert the user if the utility is not installed) and create a brand new pdf file (in the same folder as the input pdf file and with the same filename, but with an added suffix of `-updated`). The script *DOES NOT* remove nor overwrite the original pdf file.
Usage:

```shell
update-pdf-keywords
```

## software-update

This script is written for Debian-based Linux distributions (Debian, Ubuntu, Zorin, Mint, Pop!_OS, etc.) and updates the packages of the system by updating the native ones (from apt), the ones installed via flatpak and the ones installed via snap. It also removes unused packages.
Usage:

```shell
software-update
```

## compress-pdf

This script requires `ghostscript` to be installed (will automatically install it on Debian-based Linux distributions if it cannot find it). Example usage:

```shell
compress-pdf --input "/path/to/file.pdf" --quality medium --output "/path/to/compressed_file.pdf"
``` 

or 

```shell
compress-pdf -i "/path/to/file.pdf" -q medium -o "/path/to/compressed_file.pdf"
```

It can also be run as `compress-pdf` and the user is prompted to type the full path to the input pdf file, the full path to the output compressed pdf file and the quality. Quality can be picked between `low`, `medium` and `high`. The only mandatory parameter is the input pdf file. If not specified, the output compressed pdf file will be located in the same folder as the original, with the same file name but having the `-compressed` suffix. If not specified, the compression quality will be set to `medium`.

## convert-mp3

This script uses ffmpeg to convert audio files to mp3. Example usage: 
```shell
convert-mp3 \path\to\audio.file
```
This will generate an mp3 file with a frequency of 192k.
`ffmpeg` can be installed via `sudo apt install -y ffmpeg`.

## change-extension

This script manipulates an input string to produce a new string. Should be used like shown in the following two examples: 
```shell
change-extension --input /path/to/file.pdf --extension doc
``` 
or alternatively 
```shell
change-extension -i /path/to/file.pdf -e doc
``` 
and the output will be *a string* having value: `/path/to/file.doc`. *NOTE:* this command does *NOT* alter the file system. Use `change-file-extension` to do that instead.

## change-file-extension

This script renames a file at the file system level. Usage example: 
```shell
change-file-extension -i /path/to/file.pdf -e doc
```
or 
```shell
change-file-extension --input /path/to/file.pdf --extension doc
```
Result is the input file renamed to `/path/to/file.doc`

## download-yt-audio

This script allows you to download an mp3 file from YewTube/Piped/youtube. Example of usage: 

```shell
download-yt-audio --url "https://piped.video/watch?v=BW0gXbEVYgA" --output $HOME/Desktop
``` 
or alternatively 

```shell
download-yt-audio --u "https://piped.video/watch?v=BW0gXbEVYgA" --o $HOME/Desktop
```

If the `--output` \ `-o` is unspecified, the `$PWD` (current terminal folder) is used instead. This script relies on `yt-dlp` to be installed. If it isn't, then please execute the following: `sudo apt install -y python3 python-is-python3 && pip install yt-dlp` (on Debian-based Linux distributions such as Ubuntu, Zorin, Mint, Pop!_OS, etc.). Also relies on `ffmpeg` so please install it via `sudo apt install -y ffmpeg`.

## download-yt-video

This script allows you to download an mp3 file from YewTube/Piped/youtube. Example of usage: 
```shell
download-yt-video --url "https://piped.video/watch?v=BW0gXbEVYgA" --output $HOME/Desktop
``` 
or alternatively 
```shell
download-yt-video --u "https://piped.video/watch?v=BW0gXbEVYgA" --o $HOME/Desktop
```
If the `--output` \ `-o` is unspecified, the `$PWD` (current terminal folder) is used instead. This script relies on `yt-dlp` to be installed. If it isn't, then please execute the following: `sudo apt install -y python3 python-is-python3 && pip install yt-dlp` (on Debian-based Linux distributions such as Ubuntu, Zorin, Mint, Pop!_OS, etc.). Also relies on `ffmpeg` so please install it via `sudo apt install -y ffmpeg`.

## search-text

This function searches for text within all files in a directory (including subdirectories). This is especially useful for software developers, as they search for specific classes being initialized, or specific error messages in projects. Usage is like: 
```shell
search-text "my searched text"
```

## explain-alias

This function allows you to quickly look at the content of a custom fish function/alias file. Just issue 
```shell
explain-alias
``` 
and then hit enter. You will be prompted to type in the alias you are wanting to be explained. If the alias/function exists, the content will be printed in terminal via cat.

## starts-with

This is a simple string manipulation function. Given an input string and a pattern, it returns 0 if the input string starts with the pattern or 1 otherwise. Usage is like this: 
```shell
starts-with --string "My input string" --pattern "in"
```

## ends-with

This is a simple string manipulation function. Given an input string and a pattern, it returns 0 if the input string ends with the pattern or 1 otherwise. Usage is like this: 
```shell
ends-with --string "My input string" --pattern "in"
```

## is-null-or-empty

This is a simple function that returns 0 if the input argument variable is null or empty; 1 otherwise. Usage is like this: 
```shell
is-null-or-empty $myvariable
```
In a script, this can be used like this:

```shell
  set -l variable_is_null_or_empty (is-null-or-empty $myvariable)
  if test $variable_is_null_or_empty -eq 0
    echo "Is null or empty"
  else
    echo "Variable is not null nor empty"
```

## reload-environment-variables

Sometimes we have a need to make modifications to the `.profile` file in `/home/$USER`. When that happens, we need to reload the environment variables in our terminal. This is where this little neat function comes into action. Just use 
```shell
reload-environment-variables
``` 
after having made modifications to `/home/$USER/.profile`

## find-line-in-file

This function is useful when searching for text within a file. When executed, it will return the first occurrence of a line beginning with the input pattern. Usage is like this: 
```shell
find-line-in-file --file "/path/to/file" --line "(Beginning of ) line to search"
``` 

If found, the return will be the line number (say for example 50). If not found, the return will be -1.

## update-file

This function is useful when attempting to update a file.
Usage is like this: 
```shell
update-file --file "/path/to/file" --line 51 --value "Modified line"
```
 
This will result in the file being updated to have line 51 be "Modified line". 
If the line index value specified is 0 or negative, then the line will be appended at the bottom of the file.
This function is meant to be used in conjunction with `find-line-in-file`.

## switch-java

Many times we work on several different java projects that require different java versions being used. This script does just that.
First, it scans the java JDKs you have installed in your system (searches in `/usr/lib/jvm`, although this is configurable in the first line of code).
Then, it prompts the user to choose which Java version they want to be using.
Lastly, after validating the user's input, it updates the `/home/$USER/.profile` file and reloads the environment variables to apply the changes.
Usage is like this:
```shell
switch-java
```

## index-of

This function is useful with strings to know the index at which a substring begins in an input string. For example, if I wanted to know the index at which the substring `"mine"` is found in this input string `"As a young boy, he worked in a gold mine. One time, he saw the owner of the gold mine, while looking at all the gold he had: <<It's all mine>>"`, I would run this command and get the index of the first occurrence of the `mine` keyword (and more specifically the index of the first letter, `m`, which is 37).
The cool thing about this particular implementation of this function, is that we are not necessarily constrained to the first occurrence of the substring, but we can specify whichever occurrence we want.
If the substring is not found, then the result will be `-1`.
Usage is like this:
```shell
index-of --character "mine" --occurrence 3 --string "As a young boy, he worked in a gold mine. One time, he saw the owner of the gold mine, while looking at all the gold he had: <<It's all mine>>"
```
When `--occurrence` is not specified, the value is automatically implied to be `1`.

## last-index-of
This function is useful with strings to know the index at which a substring begins in an input string. For example, if I wanted to know the index at which the *LAST* substring `"mine"` is found in this input string `"As a young boy, he worked in a gold mine. One time, he saw the owner of the gold mine, while looking at all the gold he had: <<It's all mine>>"`, I would run this command and get the index of the last occurrence of the `mine` keyword (and more specifically the index of the first letter, `m`, which is 137).
If the substring is not found, then the result will be `-1`.
Usage is like this:
```shell
last-index-of --character "mine" --string "As a young boy, he worked in a gold mine. One time, he saw the owner of the gold mine, while looking at all the gold he had: <<It's all mine>>"
```
