function find-lines-in-file
	set -l array_length (echo $argv | wc -w)
	set -l next_index 1
	set -l file_to_read ''
	set -l regex_to_search ''
	set -l found_index -1

	
	if test $array_length -gt 0
		for index in (seq 1 $array_length)
			set next_index (math  $next_index + 1)
			#echo 'Index ' $index ', value: ' $argv[$index] ' and next index is ' $next_index
			switch "$argv[$index]"
				case -f --file
					set file_to_read $argv[$next_index]
				case -l --line
					set regex_to_search $argv[$next_index]
				case -h --help
					echo 'Use the find-lines-in-file command as follows'
					echo 'find-lines-in-file --file "/path/to/file" --line "(Beginning of ) line to search"'
			end
		end
		
		if test -f $file_to_read
		
			set -l line_index 0
			set -l string_match ''
			set -l matches ''
		
			while read -l line
				set line_index (math $line_index + 1)
				set string_match (string match -r "$regex_to_search" "$line")
				set is_null (is-null-or-empty $string_match)
				if test $is_null -eq 1
					set matches "$matches $line_index"
					set matches (string trim $matches)
				end
			end < $file_to_read
			echo $matches
			return 0 > /dev/null 2>&1
		end
		
		
	else
		echo 'Use the find-lines-in-file command as follows'
		echo 'find-lines-in-file --file "/path/to/file" --line "(Beginning of ) line to search"'
	end
	
	echo $found_index
	return $found_index
	
	
end
