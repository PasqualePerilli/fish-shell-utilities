function starts-with
	set -l array_length (echo $argv | wc -w)
	set -l next_index 1
	set -l starting_string ''
	set -l search_pattern ''
	set -l quiet 1
	if test $array_length -gt 0
		for index in (seq 1 $array_length)
			set next_index (math  $next_index + 1)
			#echo 'Index ' $index ', value: ' $argv[$index] ' and next index is ' $next_index
			switch "$argv[$index]"
				case -s --string
					set starting_string $argv[$next_index]
				case -p --pattern
					set search_pattern $argv[$next_index]
				case -q --quiet
					set quiet 0
				case -h --help
					echo 'Use the starts-with command as follows'
					echo 'starts-with --string "My input string" --pattern "in"'
			end
		end
		set -l input_pattern_length (count (string split '' $search_pattern))
		set -l sub_starting_string (string sub --start=1 --length=$input_pattern_length $starting_string)
		#echo "Comparing [$search_pattern] to [$sub_starting_string]. Length is [$input_pattern_length]"
		if test $sub_starting_string = $search_pattern
			if test $quiet -eq 1
				echo 0
			end
			return 0
		else
			if test $quiet -eq 1
				echo 1
			end
			return 1
		end
	else
		echo 'Use the starts-with command as follows'
		echo 'starts-with --string "My input string" --pattern "in"'
		exit
	end
end