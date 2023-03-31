function download-yt-audio
	#check if yt-dlp is installed via where or which
	set -l ytdlp_path (which yt-dlp)
	if test $ytdlp_path = '' 
		echo "Please install yt-dlp before proceeding"
		echo "Please execute: sudo apt install -y python3 python-is-python3 && pip install yt-dlp"
		exit
	end
	
	set -l array_length (echo $argv | wc -w)
	set -l next_index 1
	set -l url ''
	set -l output_folder "$PWD"
	
	if test $array_length -gt 0
		for index in (seq 1 $array_length)
			set next_index (math  $next_index + 1)
			switch "$argv[$index]"
				case -u --url
					set url $argv[$next_index]
				case -o --output
					set output_folder $argv[$next_index]
				case -h --help
					echo 'Use the download-yt-audio command as follows'
					echo 'download-yt-audio --url "https://piped.video/watch?v=BW0gXbEVYgA" --output $HOME/Desktop'
					exit
			end
		end
	end
	
	echo "Attempting to download audio from video at url $url. Audio file will be stored in this folder: $output_folder"
	
	set -l previous_working_dir $PWD
	
	set -l last_character ''
	set last_character (string sub --end -1 $output_folder)
	
	if test $last_character != '/'
		set output_folder "$output_folder/"
	end
	cd $output_folder
	yt-dlp -f bestaudio/best $url -q --restrict-filenames
	cd $previous_working_dir
	set -l full_path_webm ""
	set full_path_webm (yt-dlp --print filename $url --restrict-filenames)
	set full_path_webm "$output_folder$full_path_webm"
	#echo "$full_path_webm"
	
	#We need to use ffmpeg to convert to mp3
	convert-mp3 $full_path_webm
	rm $full_path_webm
	
end