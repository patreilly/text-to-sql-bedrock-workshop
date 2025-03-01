from crewai import Agent, Crew, Process, Task
from crewai.project import CrewBase, agent, crew, task
from crewai.memory import LongTermMemory, ShortTermMemory
from crewai.memory.entity.entity_memory import EntityMemory
from crew_config.SqlTools import SQLExecutionTool
from crew_config.llm_config import MEMORY_EMBEDDER, LLMModels
import crew_config.crew_helpers as crew_helpers
from crew_config.logger import CustomLogger 

# variables
AGENTS_CONFIG_FILE = "crew_config/sql_gen_agents.yaml"
TASKS_CONFIG_FILE = "crew_config/sql_gen_tasks.yaml"
CREW_NAME = "sql_generation_crew"


# initialize logger
logger = CustomLogger(CREW_NAME).get_logger()

@CrewBase
class SQLGenerationCrew():

    crew_name = CREW_NAME
    data_dir = f"data_dir/{crew_name}"
    agents_config = AGENTS_CONFIG_FILE
    tasks_config = TASKS_CONFIG_FILE

    def __init__(self, host=None, user=None, password=None):
        logger.info(f"Initializing {self.crew_name}")
        logger.info(f"Tasks config file: {self.tasks_config}")
        # self.TOOLS = ProjectTools(
        #     host=host,
        #     user=user,
        #     password=password
        #     )
        self.sql_execution_tool = SQLExecutionTool(
            host=host,
            user=user,
            password=password
        )
    
    @agent
    def sql_writer(self) -> Agent:
        config = self.agents_config['sql_writer']
        return Agent(
            config=config,
            verbose=True,
            step_callback=crew_helpers._step_callback,
            llm=LLMModels.get_claude_sonnet_3_5_v2(),
            function_calling_llm=LLMModels.get_claude_sonnet_3_7(),
            # tools=[self.TOOLS.sql_execution],
            tools=[self.sql_execution_tool]
        )
    
    @agent
    def query_performance_analyst(self) -> Agent:
        config = self.agents_config['query_performance_analyst']
        return Agent(
            config=config,
            verbose=True,
            step_callback=crew_helpers._step_callback,
            llm=LLMModels.get_claude_sonnet_3_5_v2(),
            function_calling_llm=LLMModels.get_claude_sonnet_3_7(),
            # tools=[self.TOOLS.sql_execution],
            tools=[self.sql_execution_tool]
        )
    
    @agent
    def results_evaluator(self) -> Agent:
        config = self.agents_config['results_evaluator']
        return Agent(
            config=config,
            verbose=True,
            step_callback=crew_helpers._step_callback,
            llm=LLMModels.get_claude_sonnet_3_5_v2(),
            # function_calling_llm=LLMModels.get_nova_pro(),
        )

    @task
    def task_identify_relevant_tables_and_columns(self) -> Task:
        config = self.tasks_config['task_identify_relevant_tables_and_columns']
        return Task(
            config=config,
            output_file=config.get('output_file'),
        )

    @task
    def task_draft_sql_query(self) -> Task:
        config = self.tasks_config['task_draft_sql_query']
        return Task(
            config=config,
            output_file=config.get('output_file'),
        )

    @task
    def task_execute_sql_query(self) -> Task:
        config = self.tasks_config['task_execute_sql_query']
        return Task(
            config=config,
            output_file=config.get('output_file'),
        )

    @task
    def task_handle_sql_errors(self) -> Task:
        config = self.tasks_config['task_handle_sql_errors']
        return Task(
            config=config,
            output_file=config.get('output_file'),
        )

    @task
    def task_analyze_query_performance(self) -> Task:
        config = self.tasks_config['task_analyze_query_performance']
        return Task(
            config=config,
            output_file=config.get('output_file'),
        )

    @task
    def task_analyze_query_performance(self) -> Task:
        config = self.tasks_config['task_analyze_query_performance']
        return Task(
            config=config,
            output_file=config.get('output_file'),
        )
    
    @crew
    def crew(self) -> Crew:
        crew = Crew(
            name=self.crew_name,
            agents=[
                self.sql_writer(),
                self.query_performance_analyst()
            ],
            tasks=[
                self.task_identify_relevant_tables_and_columns(),
                self.task_draft_sql_query(),
                self.task_execute_sql_query(),
                self.task_handle_sql_errors(),
                self.task_analyze_query_performance(),
            ],
            process=Process.hierarchical,
            manager_agent=self.results_evaluator(),  # Setting results_evaluator as manager
            step_callback=crew_helpers._step_callback,
            max_rpm=crew_helpers.AGENT_RPM,
            max_iter=3,
            cache=False,
            verbose=True,
            # memory=True,
            full_output=True,
            # long_term_memory=LongTermMemory(path=crew_helpers.ensure_dir_path(f"{self.data_dir}/long_term_memory_storage/") + "lts.db"),
            # short_term_memory=ShortTermMemory(
            #     path=crew_helpers.ensure_dir_path(f"{self.data_dir}/short_term_memory_storage/"),
            #     embedder_config=MEMORY_EMBEDDER,
            # ),
            # entity_memory=EntityMemory(
            #     path=crew_helpers.ensure_dir_path(f"{self.data_dir}/entity_memory_storage/"),
            #     embedder_config=MEMORY_EMBEDDER,
            # ),
        )
        logger.info(f"Successfully created crew: {self.crew_name}")
        return crew