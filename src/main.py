import psycopg2
import os
from dotenv import load_dotenv
import yaml
import json

load_dotenv()

# Create a connection
def _get_pg_creds():
    return {
        'user': os.environ.get('POSTGRES_USER'),
        'password': os.environ.get('POSTGRES_PASSWORD'),
        'port': os.environ.get('POSTGRES_PORT', '5433'), 
        'host': os.environ.get('POSTGRES_HOST', 'localhost'),
        'db_name': os.environ.get('POSTGRES_DB')  
    }

def _start_postgres_connection():
    creds = _get_pg_creds()
    connection = psycopg2.connect(dbname=creds['ecommerce'], 
                                  user=creds['alt_capstone_user'],
                                  host=creds['localhost'], 
                                  port=creds['5433']) 
    return connection

def query_database(connection, query_str):
    cursor = connection.cursor()
    cursor.execute(query_str)
    rows = cursor.fetchall()
    
    cursor.close()
    connection.close()  
    
    return rows

if __name__ == "__main__":
    conn = _start_postgres_connection()
    query = """
        SELECT count(*) as total_records
        FROM Olist_customer
    """
        
    result = query_database(connection=conn, query_str=query)
    
    print(result)


