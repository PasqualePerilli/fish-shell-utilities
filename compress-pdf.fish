function compress-pdf
	set -l user_quality ''
	set -l gs_quality ''
	set -l input ''
	set -l output ''
	set -l array_length (echo $argv | wc -w)
	set -l next_index 1
	
	echo 'There are ' $array_length ' parameters'
	
	if test $array_length -gt 0
		echo 'Automated mode'
		for index in (seq 1 $array_length)
			set next_index (math  $next_index + 1)
			#echo 'Index ' $index ', value: ' $argv[$index] ' and next index is ' $next_index
			switch "$argv[$index]"
				case -q -quality
					set user_quality $argv[$next_index]
				case -i --input
					set input $argv[$next_index]
				case -o --output
					set output $argv[$next_index]
				case -h --help
					echo 'Use the compress-pdf command as follows'
					echo 'compress-pdf --quality medium --input /path/to/file.pdf --output /path/to/output.pdf'
					echo 'Quality can be medium (default), high and low'
			end
		end
	else
		echo 'Prompt mode'
		echo 'Interactive mode'
		#Interactive mode
		read -p 'echo "Please type the full path to PDF file that needs to be compressed (or drag it into the terminal) and then press ENTER: "' -l input
		read -p 'echo "Please type the full path to the PDF file that will be generated (followed by enter) OR press ENTER to use the default: "' -l output
		read -p 'echo "Please type the quality (case SENSITIVE) you wish to compress it to between low, medium, high and then press ENTER: "' -l output
	end
	
	if test $output = ''
		#If output isn't set yet, set it now
		set output (string replace .pdf _compressed.pdf $input)
	end
	
	if test $user_quality = ''
		#If quality isn't set yet, set it now
		set user_quality medium
	end
	
	switch "$quality"
		case high
			set gs_quality "/prepress"
		case medium
			set gs_quality "/ebook"
		case low
			set gs_quality "/screen"
		case \*
			set gs_quality "/ebook"
	end	
	
	echo 'Quality is ' $user_quality ', input is ' $input ' and output is ' $output
	
	
	#Whether interactive or automated, the variables have now been set. Proceed with checking if ghostscript is installed
	#If it isn't installed, automatically install it
	set -l installed (apt-cache pkgnames | grep -i ghostscript | wc -l)
	if test $installed -lt 1
		echo 'Ghostscript is not installed. Proceeding with installation now...'
		sudo apt-get -qq --force-yes install ghostscript >/dev/null
	end
	
	#Proceed with the compression of the pdf
	echo 'Starting conversion of file [' $input '] to file [' $output '] with ' $user_quality ' quality'
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=$gs_quality -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output $input

	
end