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
L1d_cache=$(echo "$lscpu_out"  | egrep "^L1d cache:" | awk '{print $2}' | xargs)
L1i_cache=$(echo "$lscpu_out"  | egrep "^L1i cache:" | awk '{print $2}' | xargs)
L3_cache=$(echo "$lscpu_out"  | egrep "^L3 cache:" | awk '{print $2}' | xargs)
total_mem=$(echo "mem_info"  | egrep "MemTotal:" | awk '{print $2}' |xargs)
timestamp= $(vmstat -t | tail -1 | awk '{print $18}' | xargs)

#- construct the INSERT statement


#- execute the INSERT statement through psql CLI tool