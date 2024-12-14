#!/usr/bin/env python3
# -*- coding: utf-8 -*-

### Readme
# Generates the .xcodeproj file using XcodeGen

### Sample Use
# ```
# ./generateProject.py
# ```

### ------------------
### Imports
### ------------------

import os
import sys
import subprocess
import argparse
import time
# Make sure to execute in a terminal if needed
# export PYTHONIOENCODING=UTF-8

### ------------------
### Default variables
### ------------------


### ------------------
### Arguments
### ------------------
def parseArguments():
	parser = argparse.ArgumentParser(description = 'Generates the .xcodeproj file')
	parser.add_argument('--projectPath',
                    action = 'store',
                    dest = 'projectPath',
                    help = 'Project path',
					default = '../../Code/Project',
                    required=False)
	parser.add_argument('--spec',
                    action = 'store',
                    dest = 'spec',
                    help = 'Spec path',
					default = '../../Code/Project/project.yml',
                    required=False)
	parser.add_argument('--verbose',
                    action = 'store_true',
                    dest = 'verbose',
                    help = 'Verbose mode')
	args = parser.parse_args()
	return args

### ------------------
### Method Definition
### ------------------
def myPrint(string):
    print(string.encode('ascii', 'ignore').decode('ascii'))

def run(params):
    if os.system(params):
    	raise RuntimeError('Script failed - ' + params)

### ------------------
### Main entry point
### ------------------
startTime = time.time()

# Arguments parsing
args = parseArguments()

# Print current directory
if args.verbose:
	pwd = os.getcwd()
	myPrint('Current directory: ' + pwd)

## Generate the project based on configuration
myPrint('Generating .xcodeproj file with XcodeGen')
generateXcodeproj = './xcodegen-2.42.0 generate --project ' + args.projectPath + ' --spec ' + args.spec
myPrint('Running: ' + generateXcodeproj)
run(generateXcodeproj)

# Calculate processing time
endTime = time.time()
runTime = endTime - startTime
myPrint('')
myPrint('Project was generated and configured in %0.1f seconds' % runTime)
myPrint('')
