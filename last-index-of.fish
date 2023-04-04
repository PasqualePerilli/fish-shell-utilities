function last-index-of
	set -l array_length (echo $argv | wc -w)
	set -l next_index 1
	set -l input_string ''
	set -l input_character ''
	if test $array_length -gt 0
		for index in (seq 1 $array_length)
			set next_index (math  $next_index + 1)
			#echo 'Index ' $index ', value: ' $argv[$index] ' and next index is ' $next_index
			switch "$argv[$index]"
				case -s --string
					set input_string $argv[$next_index]
				case -c --character
					set input_character $argv[$next_index]
				case -h --help
					echo 'Use the last-index-of command as follows'
					echo 'last-index-of --string "abcdecabcqwe" --character "abc"'
					exit
			end
		end
	end
	if test "$input_string" != ''
		if test "$input_character" != ''
			set -l input_string_length (count (string split '' $input_string))
			set -l input_character_length (count (string split '' $input_character))
			#echo "String length is $input_string_length. Character length is $input_character_length"
			
			set -l found_index -1
			
			for string_index in (seq $input_string_length)
				set -l current_character (string sub --start=$string_index --length=1 $input_string)
				#echo "Character at index $string_index is $current_character"
				if test $input_string_length -ge (math $string_index + $input_character_length - 1)
					set -l current_comparison (string sub --start=$string_index --length=$input_character_length $input_string)
					#echo "Testing $current_comparison against $input_character"
					if test "$current_comparison" = "$input_character"
						set found_index $string_index
						#echo "Updated found index to $found_index after having found $current_comparison which matches $input_character"
					end
				else
					continue
				end
			end
			
			echo $found_index
			return $found_index
			
		else
			echo "Input character was not specified..."
			echo 'Use the last-index-of command as follows'
			echo 'last-index-of --string "abcdecaqwe" --character "a"'
			exit			
		end
	else
		echo "Input string was not specified..."
		echo 'Use the last-index-of command as follows'
		echo 'last-index-of --string "abcdecaqwe" --character "a"'
		exit
	end
end