
# Overview
This is a data pipeline, constructed in datajoint, used across Princeton's U19.
It specifies a number of tables and their relational structure to organizes all metadata to
* mouse mangament,
* training management,
* microscope management,
* und recording

in one coherent framework.

# Backend
The backend is a SQL server [MariaDB].

# Integration into rigs.
The rigs talk to the database directly [SSL, wired connection].


# To run an ingestion from scratch
run script `scripts/ingest_all.m`
Before running the script, the user needs to put one `.mat` file with the task information into the directory `data`
