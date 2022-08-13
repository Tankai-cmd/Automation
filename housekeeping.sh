#!/bin/bash

# declaring target_location and final_location
cd 
target_location="Downloads/"
final_location=".Trash/"

echo "Initiate cleaning up of downloads and bin ..."
# summarise number of files to be cleaned
NUM=`find "$target_location" -type f -mtime +7 | wc -l`
if [ "$NUM" > 0 ];
then
	echo "Moving "$NUM" of files to Trash"
	# {} is used to take in all files in the find directory
	# \; appends each selected file to execute the command
	find "$target_location" -mtime +7 -exec mv {} "$final_location" \;
	emptydir=`find "$target_location" -empty -type d | wc -l`	 
	echo ""$emptydir" Empty folders present in directory"
	if [ "$emptydir" > 0 ];
	then
		echo "Removing"$emptydir" from "$target_location""
		find "$target_location" -empty -type d -delete
		echo "Removed successfully"
	else
		echo "No empty folders"
		exit 0
	fi
else	
	echo "No files/directories older than 7 days"
	exit 0
fi

# clearing all files in the Trash directory
count=`ls -a "$final_location" | wc -l`
echo ""$count" Files will be cleared"
if [ -z "$(ls -a "$final_location")" ];
then
	echo "Trash is empty"
else
	echo "Begin to remove"$count" file from Trash..."
	rm -r "$final_location"
	echo "All "$count" files have been removed"
	exit 0
fi
