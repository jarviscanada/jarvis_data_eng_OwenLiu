# Linux Cluster Monitoring Agent

# Introduction
This project anchors on providing the Jarvis LCA team of the linux hardware specifications of the 
nodes/centOS that Jarvis uses. These specifications are retrieved through linux bash scripts
including static ones and dynamic ones. The developers put the specs into two tables, one static table, 
and one dynamic table with crontab continuously inserting tuples every minute. These tables are prepared 
for further business purposes introduced by several query tasks. Overall a psql instance was initialized
through docker to persist all the data.


# Implementation on Scripts
The developers implemented 5 docs including psql_docker.sh, ddl.sql,host_info.sh, and host_usage.sh.

- The developers start a psql instance using psql_docker.sh
- The developers connect to the psql instance, create a database agent and create two tables 
using ddl.sql. Two tables are named host_info and host_usage with their schema specified after.
- The developers retrieve hardware specs data through Linux CLI commands, developers run the bash scripts
to insert the stored variables into the table host_info created through ddl.sql using host_info.sh
- The developers retrieve hardware specs dynamic data through Linux CLI commands, 
developers run the bash scripts to insert the stored variables into the table host_usage every one minute
with crontab. This is achieved through host_usage.sh.

## Database Modeling
The first schema in the database has columns hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, 
l2_cache, total_mem, timestamp.
The second schema in the database has columns memory_free, cpu_idle, cpu_kernel, disk_io, disk_available.

## Three business problems for future insights
The developers investigated 3 problems.
1. Find the memory size of each CPU number
2. Find the average memory usage every 5 mins for each host.
3. Detect host failures for dynamic insertions every 5 mins.




# Test
The developers tested the bash scripts with bash commands (filled in the command after $ sign)
The developers tested the queries with sample data with 100% success rate.

# Deployment
The 4 scripts were pushed to Github for further review.

# Improvements
The developers think we can improve docker cleaner and more thorough implementation and understanding.