function find-and-replace-all-values
	set -l array_length (echo $argv | wc -w)
	set -l next_index 1
	set -l file_to_read ''
	set -l string_to_search ''
	set -l replacement_value
	if test $array_length -gt 0
		for index in (seq 1 $array_length)
			set next_index (math  $next_index + 1)
			#echo 'Index ' $index ', value: ' $argv[$index] ' and next index is ' $next_index
			switch "$argv[$index]"
				case -f --file
					set file_to_read $argv[$next_index]
				case -e --existing
					set string_to_search $argv[$next_index]
				case -r --replacement
					set replacement_value $argv[$next_index]
				case -h --help
					echo 'Use the find-and-replace-all-values command as follows'
					echo 'find-and-replace-all-values --file "/path/to/file" --line "(Beginning of ) line to search" --replacement "Replacement line"'
			end
		end
		
		
		set -l lines_to_modify (find-lines-in-file --file $file_to_read --line "$string_to_search")
		
		if test $lines_to_modify != ''
			set lines_to_modify (string split " " -- $lines_to_modify)
			set -l howmany_lines (count $lines_to_modify)
			echo "There are $howmany_lines lines to modify."
			for index in (seq $howmany_lines)
				#echo "Updating line $lines_to_modify[$index]" 
				update-value-in-line --file $file_to_read --line $lines_to_modify[$index] --existing $string_to_search --value $replacement_value
			end
		else
			echo "There are no lines to modify in $file_to_read"
		end
		
		
	else
		echo 'Use the find-and-replace-all command as follows'
		echo 'find-and-replace-all --file "/path/to/file" --line "(Beginning of ) line to search" --replacement "Replacement line"'	
	end
end
