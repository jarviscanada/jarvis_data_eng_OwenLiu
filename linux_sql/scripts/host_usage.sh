#save hostname to a variable
hostname=$(hostname -f)

#save number of CPU to a variable
lscpu_out=`lscpu`

cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)

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
total_mem=$((l2_cache+L1d_cache+L1i_cache+L3_cache))
timestamp= $(date +%F_%T)

#current timestamp in `2019-11-26 14:40:19` format

#usage
memory_free= $(awk '/MemFree/ { printf "%.3f \n", $2/1024/1024 }' /proc/meminfo)

#NO IDEA
cpu_idle=
cpu_kernel=
disk_io=
disk_available=
