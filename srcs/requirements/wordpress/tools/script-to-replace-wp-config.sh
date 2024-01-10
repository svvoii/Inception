#!/bin/sh

# After extracting the wordpress archive, the wp-config.php file is missing.
# So we first make a copy of the given `wp-config-sample.php`
cp wp-config-sample.php wp-config.php
 
# Reading the template file line by line and replacing corresponding lines in 
# `wp-config.php` with lines from the template file
while IFS= read -r line
do
	# Check if the line starts with `define`
	case "$line" in
		define*)
			# Extract the variable name from the line
			pattern=$(echo "$line" | cut -d"," -f1)

			# DEBUG PURPOSE
			#echo "[sh script] ptrn:[$pattern] line:[$line]"

			# Use sed to replace the line in the original file
			sed -i "/$pattern/c\\$line" wp-config.php
		;;
	esac

done < wp-config-to-replace.php

echo "[sh script] wp-config.php ready."

rm wp-config-to-replace.php script-to-replace-wp-config.sh

## This manipulation is necessary for future access to the database from the
## wordpress container. The wordpress container will use the environment
## variables defined in the docker-compose.yml file to connect to the database.
## In this case MariaDB, which is running in the mariadb container on the same
## network as the wordpress container.