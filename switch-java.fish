function switch-java
	set -l java_installation_path "/usr/lib/jvm"
	echo "You have the following java versions installed:"
	set -l available_javas (ls -1r $java_installation_path | grep --invert-match "java-1\." | grep --invert-match "default-")
	set available_javas (string split \n -- $available_javas)
	set -l howmany_javas (count $available_javas)
	for i in (seq $howmany_javas)
		echo "[$i]: $available_javas[$i]"
	end
	echo "Which java version would you like to set as active?"
	read -l -P "Type in one of the [numbers] above only: " user_choice
      	#echo "You chose [$user_choice]"
	if test $user_choice -ge 1 -a $user_choice -le $howmany_javas
            	set -l java_chosen_path "$java_installation_path/$available_javas[$user_choice]"
	   	set -l profile_file "/home/$USER/.profile"
		set -l new_line_java_home "export JAVA_HOME=$java_chosen_path"
		set -l java_home_line_index (find-line-in-file --file $profile_file --line "export JAVA_HOME")
		#echo "Need to update line $java_home_line_index"
		update-file --file $profile_file --line $java_home_line_index --value $new_line_java_home
		#Reload environment variables
		reload-environment-variables
	else
		echo "Your selection ($user_choice) is not valid. Please choose a number between 1 and $howmany_javas"
	end
end
