#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
@Time    : 2023/5/5 22:59
@Author  : alexanderwu
@File    : __init__.py
"""

try:
    from metagpt.provider.google_gemini_api import GeminiLLM
    HAS_GEMINI = True
except ImportError:
    # google-generativeai is not compatible with protobuf 6.x
    HAS_GEMINI = False

from metagpt.provider.ollama_api import OllamaLLM
from metagpt.provider.openai_api import OpenAILLM
from metagpt.provider.zhipuai_api import ZhiPuAILLM
from metagpt.provider.azure_openai_api import AzureOpenAILLM
from metagpt.provider.metagpt_api import MetaGPTLLM
from metagpt.provider.human_provider import HumanProvider
from metagpt.provider.spark_api import SparkLLM
from metagpt.provider.qianfan_api import QianFanLLM
from metagpt.provider.dashscope_api import DashScopeLLM
from metagpt.provider.anthropic_api import AnthropicLLM
from metagpt.provider.bedrock_api import BedrockLLM
from metagpt.provider.ark_api import ArkLLM
from metagpt.provider.openrouter_reasoning import OpenrouterReasoningLLM

__all__ = [
    "OpenAILLM",
    "ZhiPuAILLM",
    "AzureOpenAILLM",
    "MetaGPTLLM",
    "OllamaLLM",
    "HumanProvider",
    "SparkLLM",
    "QianFanLLM",
    "DashScopeLLM",
    "AnthropicLLM",
    "BedrockLLM",
    "ArkLLM",
    "OpenrouterReasoningLLM",
]

if HAS_GEMINI:
    __all__.append("GeminiLLM")
