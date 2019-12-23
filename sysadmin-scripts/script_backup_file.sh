#!/bin/bash

USERNAME=""
IPADDR=""
PSSWD=""
green=$(tput setaf 2)
reset=$(tput sgr0)
Path_NFS_Directory="/mnt/Backup_Rigboxes_wits_files"
Path_backup_dir="/mnt"
Path_File_storage="/mnt/connectedwell_data/file-storage"






for IPADDR in ${HOSTSIP} ; do
    echo '#### UPDATE VMS '${green}${USERNAME}@${HOSTNAME}${reset}



	

	echo '#### GET HOSTNAME FROM RIGBOX :   '${green}${USERNAME}@${IPADDR}${reset}
	export export_hostname=$(sshpass -p $PSSWD ssh -T  ${USERNAME}@${IPADDR} <<\HERE
	hostname=$(cat /etc/hostname)
	echo "$hostname"
HERE
	)	
	echo "Hostname Export : $export_hostname";


	echo '#### GET DATE FROM RIGBOX :  '${green}${USERNAME}@${IPADDR}${reset}
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



	echo '#### ACCESS SSH : '${green}${USERNAME}@${IPADDR}${reset}
	sshpass -p $PSSWD ssh  ${USERNAME}@${IPADDR} '

		date_yesterday=$(date -d "yesterday" '+%Y-%m-%d')
		Path_File_storage="/mnt/connectedwell_data/file-storage"
		hostname=$(cat /etc/hostname)
		Path_backup_dir="/mnt"

			echo "Rigbox Hostname : $hostname"
			echo "$hostname Yesterday Date : $date_yesterday"
			echo "$hostname Storage Files Path : $Path_File_storage"
			echo "$hostname Storage backup dir : $Path_backup_dir"
			

			
			mkdir -p "$Path_backup_dir"/backup_compressed/
			cd "$Path_File_storage"
			
			if [ ! -f "$Path_backup_dir"/backup_compressed/"$hostname""_""$date_yesterday"".xz" ]

			                then
			                        echo "Info : Files that will be compressed : "
			                        echo "$(find . -daystart -mtime 1 -ls)"


			                        find . -depth -type f -daystart -mtime 1 -print0 | tar -Jcvf  "$Path_backup_dir"/backup_compressed/"$hostname""_""$date_yesterday"".xz" --null -T -
			                        echo "Success : [ "$Path_backup_dir"/backup_compressed/"$hostname""_""$date_yesterday"".xz" ] Files Compressed"


			        else

			                        echo "Warning : [ "$Path_backup_dir"/backup_compressed/"$hostname""_""$date_yesterday"".xz" ] File exist "

			fi

		exit		
		';



	echo "$Path_backup_dir"/backup_compressed/"$export_hostname";

	if rsync -a --ignore-existing ${USERNAME}@${IPADDR}:"$Path_backup_dir"/backup_compressed/"$export_hostname""_""$export_date"".xz" "$Path_NFS_Directory/$export_hostname/"  >&/dev/null ;

		then echo "Success : File [ "$export_hostname""_""$export_date"".xz" ] Transfer done to [ "$Path_NFS_Directory/$export_hostname/"  ]" ; 
		else echo "Error   : File [ "$export_hostname""_""$export_date"".xz" ] Transfer failed to [ "$Path_NFS_Directory/$export_hostname/"  ]" ; 
	fi	


	


	#echo '#### ACCESS SSH : '${green}${USERNAME}@${IPADDR}${reset}
        #sshpass -p $PSSWD ssh  ${USERNAME}@${IPADDR} '
	
	#date_yesterday=$(date -d "yesterday" '+%Y-%m-%d')
        #Path_File_storage="/mnt/connectedwell_data/file-storage"
        #hostname=$(cat /etc/hostname)


	#rm -rf "$Path_File_storage"/backup_compressed/"$hostname""_""$date_yesterday"".xz";
	#echo "Success : File [ "$Path_File_storage"/backup_compressed/"$hostname""_""$date_yesterday"".xz" ] removed ";
	#exit

	#';

done;













