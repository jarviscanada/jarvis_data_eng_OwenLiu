#Author: Owen Liu
#Email: zekeinberlin@gmail.com

# assign CLI arguments to variables
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

#check the number of CLI arguments
if [ $# -ne 5 ]; then
  echo 'Create requires host, port, database, username and password'
  exit 1
fi

#- parse host hardware specifications using bash cmds
##Save specs to variables
hostname=$(hostname -f)
lscpu_out=`lscpu`
mem_info=$(cat /proc/meminfo)
di_out=$(df -BM /)
cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out"  | egrep "^Architecture:" | awk '{print $2}' | xargs)
cpu_model=$(echo "$lscpu_out"  | egrep "^Model:" | awk '{print $2}' | xargs)
cpu_mhz=$(echo "$lscpu_out"  | egrep "^CPU MHz:" | awk '{print $2}' | xargs)
l2_cache=$(echo "$lscpu_out"  | egrep "^L2 cache:" | awk '{print $2}' | xargs)
total_mem=$(echo "mem_info"  | egrep "MemTotal:" | awk '{print $2}' |xargs)
timestamp= $(vmstat -t | tail -1 | awk '{print $18}' | xargs)

#Subquery to find matching id in host_info table
host_id="(SELECT id FROM host_info WHERE hostname='$hostname')";

#- construct the INSERT statement
insert_hardware="INSERT INTO host_info (id, hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, L2_cache, total_mem, total_mem, timestamp)
VALUES('$id', '$hostname', '$cpu_number', '$cpu_architecture', '$cpu_model', '$cpu_mhz', '$L2_cache', '$total_mem', '$total_mem', '$timestamp')"

#- execute the INSERT statement through psql CLI tool
#set up environment variable for pql cmd
export PGPASSWORD=$(psql_password)

#Insert data into a database
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_hardware"
exit $?