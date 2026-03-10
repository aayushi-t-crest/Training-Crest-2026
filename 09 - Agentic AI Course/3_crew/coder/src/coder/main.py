#!/usr/bin/env python
import sys
import warnings
import os
from datetime import datetime

from coder.crew import Coder

warnings.filterwarnings("ignore", category=SyntaxWarning, module="pysbd")

# Create output directory if it doesn't exist
os.makedirs('output', exist_ok=True)

assignment = 'Write a function that groups anagrams together'

def run():
    """
    Run the crew.
    """
    inputs = {
        'assignment': assignment,
    }
    
    result = Coder().crew().kickoff(inputs=inputs)
    print(result.raw)




