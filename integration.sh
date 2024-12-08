#!/bin/bash

#directories
data_hub_dir="./data-hub"
db_dir="./db"

#output files
output_files="$db_dir/integrated_data.csv"

#check if data and db directories exist
if [[ ! -d $data_hub_dir ]]; then
	echo "Error: $data_ub_dir does not exist."
	exit 1
fi 

if [[ ! -d $db_dir ]]; then
	echo "Error: $db_dir does not exist. Creating it now..."
	mkdir -p $db_dir
fi

#initialize the output file
echo "Creating the integrated data file: $output_files" > "$output_files"

#combine datasets
echo "Integrating datasets..." 
for FILE in "$data_hub_dir"/*.csv; do
	if [[ -f $FILE ]]; then 
		#Append file content to the output file
		#skip header if it's not the first file
		if [[ $(wc -l < "$output_files") -eq 0 ]]; then 
			cat "$FILE" >> "$output_files"
		else
			tail -n +2 "$FILE" >> "$output_files"
		fi
		echo "Added $FILE to $output_files"
	fi
done

#confirm success
if [[ -f $output_files ]]; then
	echo "Integration completed successfully. Output saved to $output_files"
else
	echo "Error: Failed to create the integrated data file"
	exit 1 
fi

