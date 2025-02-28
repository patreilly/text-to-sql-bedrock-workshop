from crewai import Agent, Crew, Process, Task
from crewai.project import CrewBase, agent, crew, task
from crewai.memory import LongTermMemory, ShortTermMemory
from crewai.memory.entity.entity_memory import EntityMemory
from crew_config.proj_tools import ProjectTools
from crew_config.llm_config import MEMORY_EMBEDDER, LLMModels
import crew_config.crew_helpers as crew_helpers
from crew_config.logger import CustomLogger 

# variables
AGENTS_CONFIG_FILE = "crew_config/question_gen_agents.yaml"
TASKS_CONFIG_FILE = "crew_config/question_gen_tasks.yaml"
CREW_NAME = "question_generation_crew"


# initialize logger
logger = CustomLogger(CREW_NAME).get_logger()

@CrewBase
class QuestionGenerationCrew():


    crew_name = CREW_NAME
    data_dir = f"data_dir/{crew_name}"
    agents_config = AGENTS_CONFIG_FILE
    tasks_config = TASKS_CONFIG_FILE

    def __init__(self, host=None, user=None, password=None):
        logger.info(f"Initializing {self.crew_name}")
        logger.info(f"Tasks config file: {self.tasks_config}")
        self.TOOLS = ProjectTools(
            host=host,
            user=user,
            password=password
            )
    
    @agent
    def question_generator(self) -> Agent:
        config = self.agents_config['question_generator']
        return Agent(
            config=config,
            verbose=True,
            step_callback=crew_helpers._step_callback,
            llm=LLMModels.get_claude_sonnet_3_5_v2(),
            function_calling_llm=LLMModels.get_nova_pro(),

        )
    @task
    def task_generate_business_question(self) -> Task:
        task_name = 'task_generate_business_question'
        return Task(
            name=task_name,
            config=self.tasks_config[task_name]
        )

    @task
    def task_ground_business_question(self) -> Task:
        task_name = 'task_ground_business_question'
        return Task(
            name=task_name,
            config=self.tasks_config[task_name]
        )
    
    @task
    def task_refine_business_question(self) -> Task:
        task_name = 'task_refine_business_question'
        return Task(
            name=task_name,
            config=self.tasks_config[task_name]
        )
    
    @crew
    def crew(self) -> Crew:
        crew = Crew(
            name=self.crew_name,
            agents=[
                self.question_generator()
            ],
            tasks=[
                self.task_generate_business_question(),
                self.task_ground_business_question(),
                self.task_refine_business_question(),

            ],
            process=Process.sequential,
            # step_callback=crew_helpers._step_callback,
            max_rpm=crew_helpers.AGENT_RPM,
            max_iter=2,
            cache=True,
            # verbose=True,
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