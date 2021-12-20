/*
Author: Owen Liu
#Email: zekeinberlin@gmail.com
*/

--TASK 1
--Description: Group hosts by CPU number and sort by their memory size in descending order(within each cpu_number group)

SELECT cpu_number,host_id,total_mem
FROM host_info
GROUP BY cpu_number
ORDER BY total_mem DESC

--Task 2
--Description: Average used memory in percentage over 5 mins interval for each host. (used memory = total memory - free memory).
CREATE FUNCTION roundmin(ts timestamp) RETURNS timestamp AS
$$

BEGIN
    RETURN date_trunc('hour', ts) + date_part('minute', ts):: int / 5 * interval '5 min';
END
;
$$
    LANGUAGE PLPGSQL;

-- verify rount5 function
SELECT host_id, timestamp, AVG(roundmin(timestamp))
FROM host_usage
GROUP BY host_id

--Task 3
--The cron job is supposed to insert a new entry to the host_usage table every minute when the server is healthy.
--We can assume that a server is failed when it inserts less than three data points within 5-min interval. Please write a query to detect host failures.

SELECT host_id, timestamp, COUNT(SELECT host_id FROM host_usage WHERE)
FROM host_usage
GROUP BY host_id
HAVING COUNT()<3

