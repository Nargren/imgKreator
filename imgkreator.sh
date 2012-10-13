#!/bin/bash

#This script was written by:
# _   _                                
#| \ | |                               
#|  \| | __ _ _ __ __ _ _ __ ___ _ __  
#| . ` |/ _` | '__/ _` | '__/ _ \ '_ \ 
#| |\  | (_| | | | (_| | | |  __/ | | |
#\_| \_/\__,_|_|  \__, |_|  \___|_| |_|
#                  __/ |               
#                 |___/   
# 13 oct, 2012
# Script to create .img files
# Nargren | ubuntuhak.blogspot.com

#The script creates an empty img file with the specified filename, size and filesystem
#Output file name is <givenname>.img

#Defining functions
function main {
echo "Specify Filesystem to be used:"
echo "1. Fat32"
echo "2. NTFS"
echo "3. Ext2"
echo "4. Ext3"
echo "5. Ext4"
read choice

if [ $choice -le 5 ] && [ $choice -ge 0 ]; then

	if [ $choice -eq 1 ]; then
	filetype=Fat32
	sudo dd if=/dev/zero of=$imgname bs=1M count=$size
	sudo mkfs fat32 -F $imgname
	fi
	if [ $choice -eq 2 ]; then
	filetype=NTFS
	sudo dd if=/dev/zero of=$imgname bs=1M count=$size
	sudo mkfs ntfs -F $imgname
	fi
	if [ $choice -eq 3 ]; then
	filetype=Ext2
	sudo dd if=/dev/zero of=$imgname bs=1M count=$size
	sudo mkfs ext2 -F $imgname
	fi
	if [ $choice -eq 4 ]; then
	filetype=Ext3
	sudo dd if=/dev/zero of=$imgname bs=1M count=$size
	sudo mkfs ext3 -F $imgname
	fi
	if [ $choice -eq 5 ]; then
	filetype=Ext4
	sudo dd if=/dev/zero of=$imgname bs=1M count=$size
	sudo mkfs ext4 -F $imgname
	fi
else
echo "PEBKAC"
echo ""
	main
fi
		}

function existence {
	imgname=$name.img
	if [ -e $imgname ]; then
	echo "$(tput setaf 1)Warning$(tput sgr0) : File '$name' already exists!"	
	
	
			function decision {
			echo "Overwrite? (Y/N)"
			read answer
			if [ $answer == n ] || [ $answer == N ]; then
			echo "Please choose another name:"
			read name
			existence
			
			elif [ $answer == y ] || [ $answer == Y ]; then
			echo "Overwriting '$name'..."
			
			else
			echo "Try again."
			decision
			fi
					}
	decision
	else
	echo ""
	fi
	
		  }

#Main
echo "Welcome to imgKreator!"
echo ""
echo "Specify output filename:"
read name	
existence
echo ""
echo "Specify size of '$imgname' (MB):"
read size
echo ""
main
sudo chmod 777 $imgname
echo "$(tput bold)$(tput setaf 4)Img container $imgname ($size MB) was successfully created and formatted to $filetype $(tput sgr0)"

