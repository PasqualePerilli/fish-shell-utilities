function change-extension
	set -l array_length (echo $argv | wc -w)
	set -l input_file ''
	set -l new_extension ''
	set -l output_file
	set -l next_index 1
	if test $array_length -gt 0
		for index in (seq 1 $array_length)
			set next_index (math  $next_index + 1)
			switch "$argv[$index]"
				case -i --input
					set input_file $argv[$next_index]
				case -e --extension
					set new_extension $argv[$next_index]
				case -h --help
					echo 'Use the change-extension command as follows'
					echo 'change-extension --input /path/to/file.pdf --extension doc'
					echo 'Or alternatively:'
					echo 'change-extension -i /path/to/file.pdf -e doc'
			end
		end
		if test $input_file != ""
			if test $new_extension != ""
				set output_file (string trim (echo $input_file | sed 's/\.[^.]*$//'))
				set output_file "$output_file.$new_extension"
				mv $input_file $output_file
			else
				echo 'Use the change-extension command as follows'
				echo 'change-extension --input /path/to/file.pdf --extension doc'
				echo 'Or alternatively:'
				echo 'change-extension -i /path/to/file.pdf -e doc'
			end
		else
			echo 'Use the change-extension command as follows'
			echo 'change-extension --input /path/to/file.pdf --extension doc'
			echo 'Or alternatively:'
			echo 'change-extension -i /path/to/file.pdf -e doc'
		end
	else
		echo 'Use the change-extension command as follows'
		echo 'change-extension --input /path/to/file.pdf --extension doc'
		echo 'Or alternatively:'
		echo 'change-extension -i /path/to/file.pdf -e doc'
	end

end