#!/usr/bin/expect

# Set variables
# set timeout 30
set ip_address # ip or alias
set port 22
set password # password
set username # username

set local_folder # dist
set remote_folder # /home/billbear/web

set container_id # container id
set container_path # path in container

# Copy folder to remote server
spawn scp -r $local_folder "$username@$ip_address:$remote_folder"
expect {
"password:" { send "$password\r" }
}
expect eof

# Connect to remote server
spawn ssh $ip_address -p $port -l $username
expect {
"password:" { send "$password\r" }
}
expect -re "\](\$|#) "
# Copy folder to docker container
send "sudo docker cp $remote_folder/$local_folder/. $container_id:$container_path\r"
expect {
"password" { send "$password\r" }
}
expect eof
