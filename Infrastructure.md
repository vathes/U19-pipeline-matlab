# Server
A virtual machine running MariaDB [10.2], accessible as datajoint00.pni.princeton.edu is hosted by PNI.
Discspace totals 2 TB including backups.

# Server access
Access is allowed from wifi and cable connections on campus. From the outside: use vpn.
username/password are university-netid & password

# User roles
User management is performed within MariaDB. A list of all roles and their grants:
* U19_Dataowner: GRANT ALL PRIVILEGES on U19_%
* U19_Datamanager:  SELECT, INSERT, UPDATE, DELETE on U19_%
* U19_Technician:  GRANT SELECT, INSERT on U19_%
* U19_Reader: GRANT SELECT on U19_%

# Backups
Currently the backups are:
* 7 days of dailies
* 2 weeks of weeklies - captured on Friday of each week
* 2 months of monthlies - captured on the first of each month

# Configuration of database
Currently managed by puppet. A few key parameters:
port = 3306
socket =/var/lib/mysql/mysql.sock 
ssl = true 
ssl-cert = /opt/certs/mysql/client-cert.pem 
ssl-key = /opt/certs/mysql/client-key.pem
innodb_buffer_pool_size = 4G 
innodb_file_per_table = 1 
innodb_log_buffer_size = 8M 
innodb_log_file_size = 2G 
innodb_stats_on_metadata = 0 
key_buffer_size = 16M 
max_allowed_packet = 512M
max_binlog_size = 100M 
max_connections = 151 
query_cache_limit = 1M 
query_cache_size = 16M 
