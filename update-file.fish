function update-file
	#This function updates a text file.
	#Parameters: path to file, line to modify, modified line
	#If line to modify does not exist, then the modified line is appended at the bottom of the file
	#If line to modify does exist, then the modified line replaces the line to modify
	
	set -l array_length (echo $argv | wc -w)
	set -l next_index 1
	set -l file_to_modify ''
	set -l line_to_modify ''
	set -l new_value ''
	set -l new_file ''
	
	if test $array_length -gt 0
		for index in (seq 1 $array_length)
			set next_index (math  $next_index + 1)
			#echo 'Index ' $index ', value: ' $argv[$index] ' and next index is ' $next_index
			switch "$argv[$index]"
				case -f --file
					set file_to_modify $argv[$next_index]
				case -l --line
					set line_to_modify $argv[$next_index]
				case -v --value
					set new_value $argv[$next_index]
				case -h --help
					echo 'Use the update-file command as follows'
					echo 'update-file --file "/path/to/file" --line 51 --value "Modified line"'
			end
		end
		
		set -l new_file (change-extension --input $file_to_modify --extension 'modified')
		
		set -l line_index 0
		
		if test -f $file_to_modify
			if test $line_to_modify -gt 0 #If line already exists, replace line
				touch $new_file
				while read -l line
					set line_index (math $line_index + 1)
					if test $line_index -eq $line_to_modify
						echo $new_value >> $new_file
					else
						echo $line >> $new_file
					end
				end < $file_to_modify
				rm $file_to_modify && mv $new_file $file_to_modify	
			else #Otherwise just append to the existing file
				echo "$new_value" >> $file_to_modify
			end
			echo "Updated file $file_to_modify"
		else
			echo "File [$file_to_modify] does not exist. Cannot update it"
			exit
		end
		
	else
		echo 'Use the update-file command as follows'
		echo 'update-file --file "/path/to/file" --line 51 --value "Modified line"'
		exit
	end
	
	
	
end