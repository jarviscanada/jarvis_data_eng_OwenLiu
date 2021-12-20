hostname=$(hostname -f)
lscpu_out=`lscpu`
mem_info=$(cat /proc/meminfo)
di_out=$(df -BM /)

#hardware
hostname=$(hostname -f)
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

#usage
memory_free=$(echo "mem_info"  | egrep "MemFree:" | awk '{print $2}' |xargs)
cpu_idle=$(vmstat -t | tail -4 | awk '{print $15}' | xargs)
cpu_kernel=$(vmstat -t | tail -6 | awk '{print $13}' | xargs)
disk_io= $(vmstat -d | tail -1 | awk '{print $10}' | xargs)
disk_available=$(echo "di_out"  | tail -3 | awk '{print $3}' |xargs)
