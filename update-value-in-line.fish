function update-value-in-line
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
	set -l existing_value ''
	
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
				case -e --existing
					set existing_value $argv[$next_index]
				case -h --help
					echo 'Use the update-value-in-line command as follows'
					echo 'update-value-in-line --file "/path/to/file" --line 51 --existing "Characters to replace" --value "New characters"'
			end
		end
		
		set -l new_file (change-extension --input $file_to_modify --extension 'modified')
		
		set -l line_index 0
		#echo "Applying modifications...."
		if test -f $file_to_modify
			if test $line_to_modify -gt 0 #If line already exists, replace line
				#echo "Creating $new_file"
				touch $new_file
				while read -l line
					set line_index (math $line_index + 1)
					if test $line_index -eq $line_to_modify
						set -l modified_line (update-value-in-string --line $line --original $existing_value --new $new_value)
						echo $modified_line >> $new_file
					else
						echo $line >> $new_file
					end
				end < $file_to_modify
				rm $file_to_modify && mv $new_file $file_to_modify	
			else #Otherwise just append to the existing file
				#echo "Appending to file..."
				echo "$new_value" >> $file_to_modify
			end
			echo "Updated file $file_to_modify"
		else
			echo "File [$file_to_modify] does not exist. Cannot update it"
			exit
		end
		
	else
		echo 'Use the update-value-in-line command as follows'
		echo 'update-value-in-line --file "/path/to/file" --line 51 --existing "Characters to replace" --value "New characters"'
		exit
	end
	
	
	
end
