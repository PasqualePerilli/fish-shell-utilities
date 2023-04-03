function explain-alias
	echo "Which alias do you want me to explain?"
	read -l -P "Type in the alias name: " alias_name
	set -l fish_extension ".fish"
	set -l fish_function_folder "/home/$USER/.config/fish/functions/"
	set -l alias_file $fish_function_folder$alias_name$fish_extension
	if test -e $alias_file
		cat $alias_file
	else
		echo "Alias does not exist. Check your spelling and try again"
	end
end