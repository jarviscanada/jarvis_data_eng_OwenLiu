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

#Convert system specs into variables
hostname=$(hostname -f)
mem_info=$(cat /proc/meminfo)
di_out=$(df -BM /)

#usage specs refinement
memory_free=$(echo "mem_info"  | egrep "MemFree:" | awk '{print $2}' |xargs)
cpu_idle=$(vmstat -t | tail -4 | awk '{print $15}' | xargs)
cpu_kernel=$(vmstat -t | tail -6 | awk '{print $13}' | xargs)
disk_io= $(vmstat -d | tail -1 | awk '{print $10}' | xargs)
disk_available=$(echo "di_out"  | tail -3 | awk '{print $3}' |xargs)
timestamp= $(vmstat -t | tail -1 | awk '{print $18}' | xargs)
total_mem=$(echo "mem_info"  | egrep "MemTotal:" | awk '{print $2}' |xargs)

#Subquery to find matching id in host_info table
host_id="(SELECT id FROM host_usage WHERE hostname='$hostname')";

#Construct insert command into a variable
insert_usage="INSERT INTO host_usage (timestamp, host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available)
VALUES('$timestamp','$host_id','$memory_free','$cpu_idle','$cpu_kernel','$disk_io','$disk_available')"

#set up environment varriable for pql cmd
export PGPASSWORD=$psql_password

#Insert data into a database
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_usage"
exit $?

#Crontab Job Trial:
#* * * * * bash /home/centos/dev/jarvis_data_eng_OwenSLiu/linux_sql/scripts/host_usage.sh localhost 5432 host_agent postgres password > /tmp/host_usage.log