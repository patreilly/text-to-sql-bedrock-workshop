from crewai.tools import tool
from langchain_community.utilities import SearchApiAPIWrapper
from crew_config.llm_config import TOOLS_EMBEDDER, STUDENT_INFO_SEARCH
from sqlalchemy import create_engine, text
import pandas as pd

DB_HOST=None
DB_USER=None
DB_PASSWORD=None

class ProjectTools:


    def __init__(self, host: str = None, user: str = None, password: str = None):
        DB_HOST = host # crew doesn't support use self references inside  their class :( 
        DB_USER = user
        DB_PASSWORD = password

    # search api tool
    @tool("Google Search API Tool")
    def google_search(question: str) -> str:
        """Use this tool to research any information about a given question"""
        search = SearchApiAPIWrapper(engine="google")
        return search.run(question)


    @tool("Google News Search Tool")
    def google_news_search(news_topic: str, locale: str) -> str:
        """Use this tool to find news articles about a given locale"""
        search = SearchApiAPIWrapper(engine="google_news", sort_by='most_recent')
        return search.run(query=news_topic, location=locale)


    @tool("Question Tool")
    def ask_questions(questions: list) -> dict:
        """Use this tool to collect answers for 1 to many questions from the user. Include an explanation for why this question is important, and some examples."""
        responses = {}
        try:
            print("\nPlease answer the following questions:")
            for question in questions:
                response = input(f"\n{question}\nYour response: ")
                responses[question] = response
            return responses
        except Exception as e:
            return f"Error collecting user input: {str(e)}"
        

    @tool("SQL Execution Tool")
    def sql_execution(sql_query_string: str, database: str = None) -> str:
        """
        Use this tool to execute a SQL query against a database and return the results.
        
        Args:
            sql_query_string:   SQL query to execute
            database:           (Optional) database to execute the query against (default: "hr_core")
        """
        # Default connection details can be set here or from environment variables
        database = database or "hr_core"  # Default to hr_core database
        
        try:
            # Create connection URL
            connection_url = f"mysql+mysqlconnector://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{database}"

            # Create engine
            engine = create_engine(connection_url)
            
            # Execute query using a context manager to handle connections
            with engine.connect() as connection:
                try:
                    # Execute the query
                    result = connection.execute(text(sql_query_string))
                    
                    # Format results
                    if result.returns_rows:
                        # Convert to pandas DataFrame for easier handling
                        df = pd.DataFrame(result.fetchall(), columns=result.keys())
                        
                        if df.empty:
                            return "Query executed successfully. No rows returned."
                        
                        # Format the output
                        return df.to_string(index=False)
                    else:
                        rowcount = result.rowcount
                        return f"Query executed successfully. {rowcount} rows affected."
                        
                except Exception as e:
                    return f"SQL Error: {str(e)}"
                    
        except Exception as e:
            return f"Connection Error: {str(e)}"
