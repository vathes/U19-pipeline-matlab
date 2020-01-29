
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


# Go through Tutorial
Follow the steps to go through the tutorial:
1. Fork the repository to your own GitHub account
2. Clone from your own GitHub repository. 
3. Get into the directory of the current tutorial `tutorials/202001/`
4. Run `startup.m`
5. Put in the username and password when they prompt
6. Run live scripts session01 and session02

