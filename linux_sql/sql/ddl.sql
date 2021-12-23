-- Author: Owen Liu
-- Email @ zekeinberlin@gmail.com

-- Connection to the psql instance
psql -h localhost -U postgres -W

-- Show all databases
postgres=# /l

-- create a database
postgres=# CREATE DATABASE host_agent;

-- connect to the new database;
postgres=# \c host_agent;

-- Declare Vars for hardware specs
id,hostname,cpu_number,cpu_architecture,cpu_model,cpu_mhz,L2_cache,total_mem,timestamp

-- Declare default values for hardware specs
id=1      #auto-increment
hostname=spry-framework-236416.internal  #fully qualified hostname
cpu_number=1
cpu_architecture=x86_64
cpu_model=Intel(R) Xeon(R) CPU @ 2.30GHz
cpu_mhz=2300.000
L2_cache=256     --in kB
total_mem=601324 --in kB
timestamp=2019-05-29 17:49:53 #Current time in UTC time zone

-- DDL SQL Script Creation
CREATE TABLE PUBLIC.host_info
  (
     id               SERIAL NOT NULL PRIMARY KEY,
     hostname         VARCHAR NOT NULL UNIQUE,
     cpu_number       INTEGER NOT NULL,
     cpu_architecture VARCHAR NOT NULL,
     cpu_model        VARCHAR NOT NULL,
     cpu_mhz          FLOAT NOT NULL,
     L2_cache         INTEGER NOT NULL,
     total_mem        INTEGER NOT NULL,
     timestamp        TIMESTAMP NOT NULL
  );

-- Declare Vars for usage specs.
timestamp,host_id,memory_free,cpu_idle,cpu_kernel,disk_io,disk_available

-- Declare default values for usage specs.
timestamp=2019-05-29 16:53:28 --UTC time zone
host_id=1                     --host id from `hosts` table
memory_free= 256              --in MB
cpu_idle=95                   --in percentage
cpu_kernel=0                  --in percentage
disk_io=0                     --number of disk I/O
disk_available=31220          --in MB. root directory avaiable disk

-- Create DDL table for usage specs
CREATE TABLE PUBLIC.host_usage
  (
     "timestamp"    TIMESTAMP NOT NULL,
     host_id        SERIAL NOT NULL,
     memory_free    INTEGER NOT NULL,
     cpu_idle       INTEGER NOT NULL, --not sure if it's int here
     cpu_kernel     INTEGER NOT NULL,
     disk_io        INTEGER NOT NULL,
     disk_available INTEGER NOT NULL,
     FOREIGN KEY(host_id) REFERENCES host_info(id) --Foreign key declaration that refers back to host_info's pr key.
  );


switch to `host_agent`

create `host_info` table if not exist

create `host_usage` table if not exist

-- Execute ddl.sql script on the host_aget database againse the psql instance
psql -h localhost -U postgres -d host_agent -f sql/ddl.sql