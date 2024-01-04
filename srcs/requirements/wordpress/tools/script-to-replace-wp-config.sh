#!/bin/sh

# Copy the wp-config.php file from the wordpress folder to set the changes
cp wordpress/wp-config-sample.php wp-config.php

# Reading the template file line by line
while IFS= read -r line
do
	# Check if the line starts with `define`
	case "$line" in
		define*)
			# Extract the variable name from the line
			pattern=$(echo "$line" | cut -d"," -f1)

			#echo "[sh script] ptrn:[$pattern] line:[$line]"

			# Use sed to replace the line in the original file
			sed -i "/$pattern/c\\$line" wp-config.php
		;;
	esac

done < wp-config-to-replace.php

# Put the wp-config.php file back into the wordpress folder
cp wp-config.php wordpress/wp-config.php

echo "[sh script] wp-config.php ready."
