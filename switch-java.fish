function switch-java
	set -l java_installation_path '/usr/lib/jvm' #Change me if your installation directory is different...
	set -l processor_architecture 'amd64' #Change me if your processor architecture is different
	#The above path is the one that Debian-based distributions use when issuing commands like sudo apt install openjdk-11-jdk
	set -l all_relative_paths ''
	set -l chosen_version ''
	set all_relative_paths (ls -1r $java_installation_path | grep --invert-match "java-1\." | grep --invert-match "default-")
	set all_relative_paths (string split \n -- $all_relative_paths)
	
	set -l available_versions 'You have the following JDK versions installed on your system: '
	set -l found_versions 0
	
	for i in (seq (count $all_relative_paths))
		#echo "$all_relative_paths[$i]"
		set -l end_character_index (index-of --string $all_relative_paths[$i] --character "-" --occurrence 2)
		#echo "End character index is $end_character_index"
		set -l length_value (math $end_character_index - 6)
		#echo "Length value is $length_value"
		set -l current_version (string sub --start=6 --length=$length_value $all_relative_paths[$i])
		#echo "Current version is $current_version"
		set found_versions (math $found_versions + 1)
		if test $found_versions -gt 1
			set available_versions "$available_versions, "
		end
		set available_versions "$available_versions$current_version"
	end
	
	echo "$available_versions"
	
	echo "Which OpenJDK Java version would you like to use (can only pick from above)?"
	read -p 'echo "Please type the full path to the pdf file and press enter: "' -l chosen_version
	set -l java_chosen_path "$java_installation_path/java-$chosen_version-openjdk-$processor_architecture"
	
	if test -d $java_chosen_path
		echo "Setting new java version..."
		set -l profile_file "/home/$USER/.profile"
		set -l new_line_java_home "export JAVA_HOME=$java_chosen_path"
		set -l java_home_line_index (find-line-in-file --file $profile_file --line "export JAVA_HOME")
		#echo "Need to update line $java_home_line_index"
		update-file --file $profile_file --line $java_home_line_index --value $new_line_java_home
		echo "Done. Reloading fish..."
		reload-environment-variables
	else
		echo "Invalid selection. Cannot continue."
		exit
	end
	
	

end