#!/bin/bash

USERNAME=""
IPADDR=""
PSSWD=""
green=$(tput setaf 2)
reset=$(tput sgr0)
Path_NFS_Directory=""
Path_File_storage=""










	echo "Path File Storage : $Path_File_storage"

	echo '#### UPDATE VMS '${green}${USERNAME}@${IPADDR}${reset}
	export export_hostname=$(sshpass -p $PSSWD ssh -T  ${USERNAME}@${IPADDR} <<\HERE
	hostname=$(cat /etc/hostname)
	echo "$hostname"
HERE
	)	
	echo "Hostname Export : $export_hostname";


	echo '#### UPDATE VMS '${green}${USERNAME}@${IPADDR}${reset}
	export export_date=$(sshpass -p $PSSWD ssh -T  ${USERNAME}@${IPADDR} <<\HERE
	date_yesterday=$(date -d "yesterday" '+%Y-%m-%d')
	echo "$date_yesterday"
HERE
	)
	echo "Date Yesterday Export : $export_date";







	echo "Info : Creating Well [ $export_hostname ]  Directory :"
	if [ ! -d "$Path_NFS_Directory/$export_hostname" ]
		then
		mkdir -p  "$Path_NFS_Directory/$export_hostname"
		echo "Success : [ $Path_NFS_Directory/$export_hostname ] Wits Files backup directory created" 

		else

		echo "Warning : [ $Path_NFS_Directory/$export_hostname ] Wits Files backup directory exist you can't create a new one"
	fi



	echo '#### UPDATE VMS '${green}${USERNAME}@${IPADDR}${reset}
	sshpass -p $PSSWD ssh  ${USERNAME}@${IPADDR} '

		date_yesterday=$(date -d "yesterday" '+%Y-%m-%d')
		Path_File_storage="/mnt/connectedwell_data/file-storage"
		hostname=$(cat /etc/hostname)

			echo "Rigbox Hostname : $hostname"
			echo "$hostname Yesterday Date : $date_yesterday"
			echo "$hostname Storage Files Path : $Path_File_storage"

			cd "$Path_File_storage"
			mkdir -p "$Path_File_storage"/backup_compressed/

			if [ ! -f "$Path_File_storage"/backup_compressed/"$hostname""_""$date_yesterday"".xz" ]

			                then
			                        echo "Info : Files that will be compressed : "
			                        echo "$(find . -daystart -mtime 1 -ls)"


			                        find . -daystart -mtime 1 -ls -print0 | tar -Jcvf  "$Path_File_storage"/backup_compressed/"$hostname""_""$date_yesterday"".xz" --null -T -
			                        echo "Success : [ "$Path_File_storage"/backup_compressed/"$hostname""_""$date_yesterday"".xz" ] Files Compressed"


			        else

			                        echo "Warning : [ "$Path_File_storage"/backup_compressed/"$hostname""_""$date_yesterday"".xz" ] File exist "

			fi

		exit		
		';



	if rsync -a --ignore-existing rsdh@10.205.60.60:/mnt/connectedwell_data/file-storage/backup_compressed/ENF51_DJBA-11_2019-12-20.xz "$Path_NFS_Directory$export_hostname/"  >&/dev/null ; 
		then echo "transfer OK" ; 
		else echo "transfer failed" ; 
	fi	

















