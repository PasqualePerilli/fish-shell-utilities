function update-value-in-string
	set -l array_length (echo $argv | wc -w)
	set -l next_index 1
	set -l line_to_modify ''
	set -l characters_to_replace ''
	set -l new_characters ''
	set -l found_index -1
	set -l updated_line ''
	
	if test $array_length -gt 0
		for index in (seq 1 $array_length)
			set next_index (math  $next_index + 1)
			#echo 'Index ' $index ', value: ' $argv[$index] ' and next index is ' $next_index
			switch "$argv[$index]"
				case -f --file
					set file_to_modify $argv[$next_index]
				case -l --line
					set line_to_modify $argv[$next_index]
				case -o --original
					set characters_to_replace $argv[$next_index]
				case -n --new
					set new_characters $argv[$next_index]
				case -h --help
					echo 'Use the update-value-in-string command as follows'
					echo 'update-value-in-string --line "There are many characters to replace in this line." --original "characters to replace" --new "new characters"'
			end
		end
		
		set found_index (index-of --string $line_to_modify --character $characters_to_replace)
		set updated_line $line_to_modify
		set -l temp_line ''
		while test $found_index -gt 0
			#Line should be modified...
			#echo "Updating line [$line_to_modify] to remove these characters: [$characters_to_replace] in favor of these [$new_characters]"
			set found_index (index-of --string $updated_line --character $characters_to_replace)
			set -l end_index (math $found_index - 1)
			set -l prefix (string sub --end=$end_index $updated_line)
			#echo "Prefix is [$prefix]"
			set temp_line $prefix
			set temp_line $temp_line$new_characters
			set -l old_length (count (string split '' $characters_to_replace))
			#echo "The length of the characters to replace is $old_length"
			set -l start_index (math $found_index + $old_length)
			set -l suffix (string sub --start=$start_index $updated_line)
			#echo "Suffix is [$suffix]"
			set temp_line $temp_line$suffix
			set updated_line $temp_line
			#echo "Updated line is: [$updated_line]"
			set found_index (index-of --string $updated_line --character $characters_to_replace)
		end
		echo $updated_line
		
	else
		echo 'Use the update-value-in-string command as follows'
		echo 'update-value-in-string --line "There are many characters to replace in this line." --original "characters to replace" --new "new characters"'		
	end	
	
end
