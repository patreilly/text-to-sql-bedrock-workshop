#!/usr/bin/env python3
"""
MySQL Schema Cleanup Utility

This script first removes all foreign key constraints, then drops all tables and schemas 
in a safe order, preserving only specified system schemas.
"""

import argparse
import mysql.connector
from mysql.connector import Error
import sys
import getpass


def cleanup_database(host, user, password, database=None, dry_run=False, 
                     interactive=False, excluded_schemas=None):
    """
    Clean up a MySQL database by first removing all foreign key constraints,
    then dropping all tables, and finally dropping the schemas themselves.
    
    Args:
        host (str): MySQL server hostname
        user (str): MySQL username
        password (str): MySQL password
        database (str, optional): Database name. If None, affects all databases
        dry_run (bool): If True, only prints the actions without executing them
        interactive (bool): If True, asks for confirmation before operations
        excluded_schemas (list): List of schemas to exclude from dropping
    """
    if excluded_schemas is None:
        excluded_schemas = []
    
    # Always exclude system schemas
    system_schemas = ['mysql', 'information_schema', 'performance_schema', 'sys']
    excluded_schemas.extend(system_schemas)
    
    connection = None
    cursor = None
    
    try:
        print(f"Connecting to MySQL server at {host} as {user}...")
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )
        
        if connection.is_connected():
            print("Connected successfully!")
            cursor = connection.cursor(dictionary=True)
            
            # Step 1: Get all schemas
            if database:
                cursor.execute("SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = %s", (database,))
            else:
                cursor.execute("SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA")
            
            schemas = [row['SCHEMA_NAME'] for row in cursor.fetchall() 
                      if row['SCHEMA_NAME'] not in excluded_schemas]
            
            if not schemas:
                print("No eligible schemas found for cleanup.")
                return
            
            print(f"Found {len(schemas)} schemas to clean up: {', '.join(schemas)}")
            
            if interactive:
                confirm = input(f"Proceed with cleanup of these schemas? (y/n): ")
                if confirm.lower() != 'y':
                    print("Operation cancelled.")
                    return
            
            # Step 2: Find all tables and their foreign keys
            print("\n" + ("=" * 50))
            print("IDENTIFYING FOREIGN KEY CONSTRAINTS")
            print("=" * 50)
            
            all_constraints = []
            for schema in schemas:
                # Get all tables with foreign key constraints
                cursor.execute("""
                    SELECT 
                        tc.TABLE_SCHEMA, 
                        tc.TABLE_NAME, 
                        tc.CONSTRAINT_NAME
                    FROM 
                        INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
                    WHERE 
                        tc.CONSTRAINT_TYPE = 'FOREIGN KEY' 
                        AND tc.TABLE_SCHEMA = %s
                """, (schema,))
                
                constraints = cursor.fetchall()
                all_constraints.extend(constraints)
                print(f"  Schema {schema}: {len(constraints)} foreign key constraints found")
            
            # Step 3: Remove all foreign key constraints
            print("\n" + ("=" * 50))
            print("REMOVING FOREIGN KEY CONSTRAINTS" if not dry_run else "WOULD REMOVE FOREIGN KEY CONSTRAINTS")
            print("=" * 50)
            
            for constraint in all_constraints:
                schema = constraint['TABLE_SCHEMA']
                table = constraint['TABLE_NAME']
                constraint_name = constraint['CONSTRAINT_NAME']
                
                action = f"ALTER TABLE `{schema}`.`{table}` DROP FOREIGN KEY `{constraint_name}`"
                
                print(f"{'Would execute: ' if dry_run else 'Executing: '}{action}")
                
                if not dry_run:
                    try:
                        cursor.execute(action)
                        connection.commit()
                    except Error as e:
                        print(f"Error removing constraint {constraint_name}: {e}")
            
            # Step 4: Get all tables in each schema
            print("\n" + ("=" * 50))
            print("IDENTIFYING TABLES FOR REMOVAL")
            print("=" * 50)
            
            all_tables = []
            for schema in schemas:
                cursor.execute("""
                    SELECT TABLE_SCHEMA, TABLE_NAME
                    FROM INFORMATION_SCHEMA.TABLES
                    WHERE TABLE_SCHEMA = %s
                    AND TABLE_TYPE = 'BASE TABLE'
                """, (schema,))
                
                tables = cursor.fetchall()
                all_tables.extend(tables)
                print(f"  Schema {schema}: {len(tables)} tables found")
            
            # Step 5: Drop all tables
            print("\n" + ("=" * 50))
            print("DROPPING TABLES" if not dry_run else "WOULD DROP TABLES")
            print("=" * 50)
            
            for table_info in all_tables:
                schema = table_info['TABLE_SCHEMA']
                table = table_info['TABLE_NAME']
                
                action = f"DROP TABLE IF EXISTS `{schema}`.`{table}`"
                
                if interactive and not dry_run:
                    confirm = input(f"Drop table {schema}.{table}? (y/n): ")
                    if confirm.lower() != 'y':
                        print(f"Skipping {schema}.{table}")
                        continue
                
                print(f"{'Would execute: ' if dry_run else 'Executing: '}{action}")
                
                if not dry_run:
                    try:
                        cursor.execute(action)
                        connection.commit()
                    except Error as e:
                        print(f"Error dropping table {schema}.{table}: {e}")
            
            # Step 6: Drop all schemas
            print("\n" + ("=" * 50))
            print("DROPPING SCHEMAS" if not dry_run else "WOULD DROP SCHEMAS")
            print("=" * 50)
            
            for schema in schemas:
                action = f"DROP SCHEMA IF EXISTS `{schema}`"
                
                if interactive and not dry_run:
                    confirm = input(f"Drop schema {schema}? (y/n): ")
                    if confirm.lower() != 'y':
                        print(f"Skipping schema {schema}")
                        continue
                
                print(f"{'Would execute: ' if dry_run else 'Executing: '}{action}")
                
                if not dry_run:
                    try:
                        cursor.execute(action)
                        connection.commit()
                    except Error as e:
                        print(f"Error dropping schema {schema}: {e}")
            
            print("\n" + ("=" * 50))
            if dry_run:
                print("Dry run completed. No changes were made to the database.")
            else:
                print("Database cleanup completed successfully!")
            
    except Error as e:
        print(f"Error: {e}")
        return False
    finally:
        if cursor:
            cursor.close()
        if connection and connection.is_connected():
            connection.close()
            print("MySQL connection closed")
    
    return True


def main():
    parser = argparse.ArgumentParser(description='MySQL Schema Cleanup Utility')
    
    # Connection parameters
    parser.add_argument('--host', default='localhost', help='MySQL server hostname')
    parser.add_argument('-u', '--user', required=True, help='MySQL username')
    parser.add_argument('-p', '--password', action='store_true', help='Prompt for password')
    parser.add_argument('-d', '--database', help='Database name (optional)')
    
    # Execution options
    parser.add_argument('--dry-run', action='store_true', help='Show what would be done without executing')
    parser.add_argument('-i', '--interactive', action='store_true', help='Ask for confirmation before operations')
    parser.add_argument('-e', '--exclude', nargs='+', help='Schemas to exclude from dropping')
    
    args = parser.parse_args()
    
    password = ''
    if args.password:
        password = getpass.getpass("Enter MySQL password: ")
    
    success = cleanup_database(
        host=args.host,
        user=args.user,
        password=password,
        database=args.database,
        dry_run=args.dry_run,
        interactive=args.interactive,
        excluded_schemas=args.exclude
    )
    
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()

# example call: python ./wipe_all_schemas.py --host txt2sql-rdsinstance-8ezim05t0z6d.cirjka7tctxs.us-west-2.rds.amazonaws.com -u admin -p