import sqlalchemy
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError
from typing import Dict, Any, Optional, ClassVar, List
from crewai.tools.base_tool import BaseTool
import pandas as pd
import json

class SQLExecutionTool(BaseTool):
    """
    A tool for executing SQL queries using SQLAlchemy.

    Attributes:
        name (str): Name of the tool.
        description (str): Description of the tool.
    """

    name: str = "SQL Query Execution Tool"
    description: str = "Execute SQL queries on a database. Pass a valid SQL query as input."
    
    def __init__(self, host: str, user: str, password: str, database: Optional[str] = None, **kwargs):
        """
        Initialize the SQL Execution Tool with connection parameters.

        Args:
            host (str): Database server host.
            user (str): Database user.
            password (str): Database password.
            database (Optional[str]): Database name. If not provided, connection will be made without selecting a database.
            **kwargs: Additional arguments to pass to the base tool.
        """
        super().__init__(**kwargs)
        # Store as private attributes to avoid Pydantic validation issues
        self._host = host
        self._user = user
        self._password = password
        self._database = database
        self._engine = None
        self._initialize_connection()

    def _initialize_connection(self) -> None:
        """Initialize a connection to the database using SQLAlchemy."""
        try:
            # Create connection URL using mysql-connector-python
            if self._database:
                connection_string = f"mysql+mysqlconnector://{self._user}:{self._password}@{self._host}/{self._database}"
            else:
                connection_string = f"mysql+mysqlconnector://{self._user}:{self._password}@{self._host}/"
            
            # Create engine
            self._engine = create_engine(connection_string)
            
            # Test connection
            with self._engine.connect() as connection:
                connection.execute(text("SELECT 1"))
            
            db_name = self._database if self._database else "default instance"
            print(f"Successfully connected to database: {db_name}")
        except SQLAlchemyError as e:
            print(f"Error connecting to database: {e}")
            self._engine = None

    def _format_results(self, rows: List[Dict], max_rows: int = 20) -> str:
        """
        Format query results in a way that's easy for AI agents to understand.
        
        Args:
            rows (List[Dict]): Query result rows as dictionaries
            
        Returns:
            str: Formatted result string
        """
        if not rows:
            return "Query executed successfully but returned no data."
        
        # Convert to pandas DataFrame for easier manipulation
        df = pd.DataFrame(rows)
        
        # Get summary information
        num_rows = len(df)
        num_cols = len(df.columns)
        columns = list(df.columns)
        
        # Format output
        result_parts = []
        result_parts.append(f"Query results: {num_rows} rows and {num_cols} columns.")
        result_parts.append(f"Columns: {', '.join(columns)}")
        
        # Add data preview with clean tabular format
        if num_rows > 0:
            # Convert DataFrame to formatted table string
            if num_rows <= max_rows:  # Show all rows if less than max_rows
                table_str = df.to_string(index=False)
                result_parts.append("Full result set:")
            else:  # Show preview of first 10 rows if more than max_rows
                table_str = df.head(max_rows).to_string(index=False)
                result_parts.append(f"Preview of first 10 rows (out of {num_rows} total rows):")
            
            result_parts.append(table_str)
            
            # Add JSON representation for structured data access
            result_parts.append("\nStructured data (JSON format):")
            json_str = json.dumps(rows[:max_rows] if num_rows > max_rows else rows, indent=2, default=str)
            result_parts.append(json_str)
        
        # Statistical summary for numeric columns
        numeric_cols = df.select_dtypes(include=['number']).columns
        if len(numeric_cols) > 0:
            result_parts.append("\nSummary statistics for numeric columns:")
            stats = df[numeric_cols].describe().to_string()
            result_parts.append(stats)
        
        return "\n\n".join(result_parts)

    def _run(self, query: str) -> str:
        """
        Execute a SQL query on the database and return formatted results.

        Args:
            query (str): SQL query to execute.

        Returns:
            str: Formatted query results or error message.
        """
        if not self._engine:
            self._initialize_connection()
            if not self._engine:
                return "Error: Failed to connect to the database."

        try:
            with self._engine.connect() as connection:
                # Execute the query
                result = connection.execute(text(query))
                
                # Check if this is a SELECT query or a data manipulation query
                if query.strip().upper().startswith("SELECT"):
                    # Fetch all results as dictionaries
                    rows = [dict(row._mapping) for row in result]
                    return self._format_results(rows)
                else:
                    # For non-SELECT queries, commit the transaction
                    connection.commit()
                    return f"Query executed successfully. Affected rows: {result.rowcount}"
                    
        except SQLAlchemyError as e:
            return f"Error executing query: {str(e)}"

    def set_database(self, database: str) -> str:
        """
        Change the current database.

        Args:
            database (str): Name of the database to use.

        Returns:
            str: Status message of the operation.
        """
        try:
            self._database = database
            self._initialize_connection()
            return f"Successfully switched to database: {database}"
        except SQLAlchemyError as e:
            return f"Error switching database: {str(e)}"

    def __del__(self):
        """Dispose of the engine when the object is deleted."""
        if hasattr(self, '_engine') and self._engine:
            self._engine.dispose()
            print("Database connection disposed.")