function switch-python
	set -l python_path (dirname (which python))
	set -l active_version (python --version)
	echo "Current active version is: $active_version"
	echo "You have the following Python versions installed:"
	set -l available_pythons (ls -1 /usr/bin/python* | grep '.*[2-3]\(.[0-9]\+\)\?$' | grep -v '.*[2-3]\\(.[0-9]\\*\\)\\?$')
	set available_pythons (string split \n -- $available_pythons)
	set -l howmany_pythons (count $available_pythons)
	for i in (seq $howmany_pythons)
		echo "[$i]: $available_pythons[$i]"
	end
	echo "Which python version would you like to set as active?"
	read -l -P "Type in one of the [numbers] above only: " user_choice
	if test $user_choice -ge 1 -a $user_choice -le $howmany_pythons
	   	sudo rm "$python_path/python" && sudo ln -s "$available_pythons[$user_choice]" "$python_path/python"
	   	set -l new_python_version (string sub --start=8 (python --version))
	   	echo "Python version set to: $new_python_version"
	else
		echo "Your selection ($user_choice) is not valid. Please choose a number between 1 and $howmany_pythons"
	end
end
