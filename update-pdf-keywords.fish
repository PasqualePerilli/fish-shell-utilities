function update-pdf-keywords
	#check if pdktk is installed via where or which
	set -l pdftk_path (which pdftk)
	if test $pdftk_path = '' 
		echo "Please install pdftk before proceeding"
		echo "On Debian/Ubuntu-based distros, please execute sudo apt install -y pdftk"
		exit
	end
	read -p 'echo "Please type the full path to the pdf file and press enter: "' -l input_file
	read -p 'echo "Please enter the new keywords: "' -l new_keywords
	set -l input_folder ''
	set -l input_folder ''
	set -l info_file ''
	set -l output_file ''
	set input_folder (dirname $input_file)
	set info_file (string trim (echo $input_file | sed 's/\.[^.]*$//'))
	set info_file "$info_file.info"
	
	set output_file (string trim (echo $input_file | sed 's/\.[^.]*$//'))
	set output_file "$output_file-updated.pdf"

	
	set -l first_character ''
	set first_character (string sub --length 1 $input_folder)
	
	
	
	if test $first_character = "'"
		set input_file (string sub --start=2 --end=-1 $input_file)
		set info_file (string sub --start=2 $info_file)
		set input_folder (string sub --start=2 $input_folder)
		set output_file (string sub --start=2 $output_file)
	end
	
	#Update the info_file to account for the new keywords....
	
	#There are two scenarios: either keywords already exist (and we need to overwrite them) or they don't (and we need to add them)...
	
	pdftk $input_file dump_data > $info_file 
	set -l info_metadata (cat $info_file)
	#echo "Printing metadata: $info_metadata"
	switch "$info_metadata"
	case "*InfoKey: Keywords*"
		#echo "Keywords are in need to be overwritten"
		#Loop over info file, and create secondary info file 
		set -l skip_line false
		set -l info_file_temp "$info_file.temp"
		while read -la line
			#echo "Analyzing line $line"
			if test "$line" = "InfoKey: Keywords"
				#echo "Setting skip_line to true"
				set skip_line true
				continue
			end
			if test $skip_line = false
				#echo "Appending $line to temp file"
				echo "$line" >> $info_file_temp
			else
				#echo "Appending updated keywords line to file"
				echo "InfoKey: Keywords" >> $info_file_temp
				echo "InfoValue: $new_keywords" >> $info_file_temp
				set skip_line false
				#echo "Set skip_line to false"
			end
		end < $info_file
		#Rename info_file_temp to info_file
		rm "$info_file"
		mv "$info_file_temp" "$info_file"
	case "*"
		#echo "Keywords are not present."
		#Append to info file...
		echo "InfoBegin" >> $info_file
		echo "InfoKey: Keywords" >> $info_file
		echo "InfoValue: $new_keywords" >> $info_file
	end
	
	#echo "Input file is $input_file"
	#echo "Input folder is $input_folder" 
	#echo "Info file is $info_file"
	#echo "Output file is $output_file"
	
    
	pdftk $input_file update_info $info_file output $output_file
	#Remove info file
	rm "$info_file"
	echo "Done!"
end