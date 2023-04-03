function is-null-or-empty
	if not set -q argv[1]
		echo 0
		return 0
	else if not string length -q -- "$argv[1]"
		echo 0
		return 0
	else
		echo 1
		return 1
	end
end