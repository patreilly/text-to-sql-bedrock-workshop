# llm_config.py
import boto3
from crewai import LLM

# AWS Session Configuration
boto3_session = boto3.Session(region_name="us-east-1")
bedrock_runtime = boto3_session.client(service_name="bedrock-runtime")

# Embedder Configuration
MEMORY_EMBEDDER = {
    "provider": "bedrock",
    "config": {
        "session": boto3_session,
        "model": 'cohere.embed-english-v3',
        "dimension": 1024
    }
}

TOOLS_EMBEDDER = {
    "provider": "aws_bedrock",
    "config": {
        "session": boto3_session,
        "model": 'cohere.embed-english-v3',
        "dimension": 1024
    }
}

STUDENT_INFO_SEARCH = "logs/tasks/outputs/collection/"

# LLM Models Configuration
class LLMModels:
    @staticmethod
    def get_claude_sonnet_3_5_v2():
        return LLM(
            model="bedrock/us.anthropic.claude-3-5-sonnet-20241022-v2:0",
            max_tokens=4096,
            temperature=0.1,
        )
    
    @staticmethod
    def get_high_temp_claude_sonnet_3_5_v2():
        return LLM(
            model="bedrock/us.anthropic.claude-3-5-sonnet-20241022-v2:0",
            max_tokens=4096,
            temperature=0.7,
        )
    
    @staticmethod
    def get_claude_sonnet_3_7():
        return LLM(
            model="bedrock/us.anthropic.claude-3-7-sonnet-20250219-v1:0",
            max_tokens=4096,
            temperature=0.0,
        )
    
    @staticmethod
    def get_claude_haiku():
        return LLM(
            model="bedrock/anthropic.claude-3-5-haiku-20241022-v1:0",
            max_tokens=4096,
            temperature=0.1,
        )

    
    @staticmethod
    def get_nova_pro():
        return LLM(
            model="bedrock/us.amazon.nova-pro-v1:0",
            max_tokens=5119,
            temperature=0.1,
        )
    
    @staticmethod
    def get_nova_premier():
        return LLM(
            model="bedrock/converse/us.amazon.nova-premier-v1:0",
            # max_tokens=5119,
            temperature=0.1,
        )
    

    @staticmethod
    def get_nova_micro():
        return LLM(
            model="bedrock/us.amazon.nova-micro-v1:0",
            max_tokens=5119,
            temperature=0.1,
        )
    
    @staticmethod
    def get_nova_lite():
        return LLM(
            model="bedrock/us.amazon.nova-lite-v1:0",
            max_tokens=5119,
            temperature=0.1,
        )

# Default LLM
default_llm = LLMModels.get_nova_pro()