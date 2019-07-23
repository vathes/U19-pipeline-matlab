== Server ==
A virtual machine running MariaDB [10.2], accessible as datajoint00.pni.princeton.edu is hosted by PNI.
Discspace totals 2 TB including backups.

== Server access ==
Access is allowed from wifi and cable connections on campus. From the outside: use vpn.
username/password are university-netid & password

== User roles ==
User management is performed within MariaDB. A list of all roles and their grants:

U19_Dataowner: GRANT ALL PRIVILEGES on U19_%
U19_Datamanager:  SELECT, INSERT, UPDATE, DELETE on U19_%
U19_Technician:  GRANT SELECT, INSERT on U19_%
U19_Reader: GRANT SELECT on U19_%

