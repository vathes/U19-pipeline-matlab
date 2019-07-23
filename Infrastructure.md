== Server ==
A virtual machine running MariaDB [10.2], accessible as datajoint00.pni.princeton.edu is hosted by PNI.
Discspace totals 2 TB including backups.

== Server access ==
Access is allowed from wifi and cable connections on campus. From the outside: use vpn.
username/password are university-netid & password

== User roles ==
User management is performed within MariaDB. A list of all roles and their grants:

MariaDB [(none)]> show grants for U19_Datamanager;
+-------------------------------------------------------------------------+
| Grants for U19_Datamanager                                              |
+-------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'U19_Datamanager'                                 |
| GRANT SELECT, INSERT, UPDATE, DELETE ON `U19\_%`.* TO 'U19_Datamanager' |
+-------------------------------------------------------------------------+
2 rows in set (0.00 sec)
MariaDB [(none)]> show grants for U19_Dataowner;
+-------------------------------------------------------+
| Grants for U19_Dataowner                              |
+-------------------------------------------------------+
| GRANT USAGE ON *.* TO 'U19_Dataowner'                 |
| GRANT ALL PRIVILEGES ON `U19\_%`.* TO 'U19_Dataowner' |
+-------------------------------------------------------+
2 rows in set (0.00 sec)
MariaDB [(none)]> show grants for U19_Reader;
+--------------------------------------------+
| Grants for U19_Reader                      |
+--------------------------------------------+
| GRANT USAGE ON *.* TO 'U19_Reader'         |
| GRANT SELECT ON `U19\_%`.* TO 'U19_Reader' |
+--------------------------------------------+
2 rows in set (0.00 sec)
MariaDB [(none)]> show grants for U19_Technician;
+--------------------------------------------------------+
| Grants for U19_Technician                              |
+--------------------------------------------------------+
| GRANT USAGE ON *.* TO 'U19_Technician'                 |
| GRANT SELECT, INSERT ON `U19\_%`.* TO 'U19_Technician' |
+--------------------------------------------------------+
2 rows in set (0.00 sec)
