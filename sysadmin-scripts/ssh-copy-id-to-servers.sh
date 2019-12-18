#!/bin/bash



#You can use this script to copy your ssh key to all your servers

#your_servers_username
USERNAME=""
#your_servers_ip_addreses
HOSTS=""
#your_servers_password
PSSWD=""

#put color green into var $green
green=$(tput setaf 2)
#put color default into var $reset
reset=$(tput sgr0)


for HOSTS_IP in ${HOSTS} ; do
    echo '#### UPDATE VMS '${green}${USERNAME}@${HOSTNAME}${reset}
    
 # ssh-copy-id to username@ip_addreses
  sshpass -p $PSSWD ssh-copy-id -o "StrictHostKeyChecking no" -i /home/super_admin/.ssh/id_rsa.pub ${USERNAME}@${HOSTS_IP}

  


done;
