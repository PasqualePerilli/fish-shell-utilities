function convert-mp3
	set -l array_length (echo $argv | wc -w)
	set -l input_file ''
	set -l output_file ''
	echo 'There are ' $array_length ' parameters'
	if test $array_length -gt 0
		set input_file (string trim $argv[1])
		set output_file "$input_file".mp3
		echo 'Input file is ['$input_file']'
		echo 'Output file is ['$output_file']'
		echo 'ffmpeg -i ' '"'$input_file'"' ' -vn -ar 44100 -ac 2 -b:a 192k' '"'$output_file'"'
		ffmpeg -i "$input_file" -vn -ar 44100 -ac 2 -b:a 192k "$output_file"
		echo 'Conversion complete! Saved ['$output_file']'
	else
		echo 'Please re-run this command and add the input file location, such as: convert-mp3 /home/$USER/video.mp4'
	end
end