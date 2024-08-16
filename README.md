# DE_Capstone_Project


## The objective of the project is to build an ELT (Extract, Load and Transform) pipeline that will move data from a source system to a target system, which is BigQuery. Once the data is in the target system, you will have to model and transform it using dbt for analytics purpose ##

##### Tools used for the project ######
PostgresSQL
Docker
Docker Compose
Airflow
dbt
Bigquery

### Project Initialization ###
* downloaded the brazilian ecommerce dataset from Kaggle
* Move the data from my system to the PostgreSQL server: 
 - a database 'ecommerce' was created
 - table schema 'capstone_project'
 - postgres user and password were also created using SQL shell

### How Postgres server was set up
- I used Docker to set up my Postgres server
- Docker was also used to set up my Airflow
- This was done in order to move the CSV from PostgresSQL to Big Query using Airflow
 
 ### Airflow Set up - for Orchestration ###
 - The Airflow has operators which acts as a building blocks used in defining tasks
 - The Airflow Operator was what was used in creating DAGs (Directed Acyclic Graphs)
 - With the creation of the DAGs the flow of the task was defined in the Airflow pipeline.
 - The Operators move the data from the PostgreSQL server to Big Query using Google Cloud Storage (GCS) as a staging area, transferring the raw data without any transformation

 ### Data Modelling And Transformation ###
 - The data was transformed and model into the Data warehouse - BigQuery using DBT

### DBT Installation and Initialization with model
- dbt was installed and initialized
- pip install dbt-bigquery
- dbt init alt_cap
- proiles.yml configured/created
- Models were created: transitional, mart, staging

#### Summary ####
The Braziliam E-Commerce dataset was successfully ingested into PostgreSQL, orchestrated an ETL process with Airflow, loading the data into BigQuery, and transformed using dbt to answer key analytical question.