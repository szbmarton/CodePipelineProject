#!/usr/bin/python
import psycopg2
import os

def connect():
    """ Connect to the PostgreSQL database server """
    conn = None
    try:

        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(host=os.environ.get('HOST'),
                                database=os.environ.get('DB'),
                                user=os.environ.get('USER'),
                                password=os.environ.get('PASSWD'))
                                
        # create a cursor
        cur = conn.cursor()
        
       # execute a statement
        print('PostgreSQL database version:')
        cur.execute('SELECT version()')

        # display the PostgreSQL database server version
        db_version = cur.fetchone()
        print(db_version)
        
        # display the connection details
        print(conn.dsn)
       
        # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')


if __name__ == '__main__':
    connect()