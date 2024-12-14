#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import subprocess
from distutils.dir_util import copy_tree
import argparse

### ------------------
### App Icon
### ------------------
def setAppIcon(projectPath, icon, iconPath):
    p = subprocess.Popen(['python', 'icon.py'])
    p.wait()
    print('- Generated Release icons')
    
    iconsDebugPath = defaultIconPath + '/AppIcon-Debug.appiconset'
    iconsDemoPath = defaultIconPath + '/AppIcon-Demo.appiconset'
    iconsReleasePath = defaultIconPath + '/AppIcon-Release.appiconset'
    
    # Copy contents to Debug and Demo folder
    copy_tree(iconsReleasePath, iconsDebugPath)
    copy_tree(iconsReleasePath, iconsDemoPath)
    
    # Add badge to Debug
    p = subprocess.Popen(['badge', '--dark', '--alpha', '--glob', './**/*-Debug.appiconset/*.{png,PNG}'], cwd=projectPath)
    p.wait()
    print('- Generated Debug icons')
    
    # Add badge to Demo
    p = subprocess.Popen(['badge', '--dark', '--glob', './**/*-Demo.appiconset/*.{png,PNG}'], cwd=projectPath)
    p.wait()
    print('- Generated Demo icons')

### ------------------
### Parameters
### ------------------
defaultCodePath = '../Code/Project'
defaultIconPath = defaultCodePath + '/Project/Images.xcassets'
defaultIcon = "AppIcon.png"

parser = argparse.ArgumentParser(description = 'Unifies code style')
parser.add_argument('-p', '--projectPath',
					action = 'store',
					dest = 'codePath',
					default = defaultCodePath,
                    help = 'Path to main code folder')

parser.add_argument('-ip', '--iconPath',
					action = 'store',
					dest = 'iconPath',
					default = defaultIconPath,
                    help = 'File path to configuration file')

parser.add_argument('-if', '--icon',
					action = 'store',
					dest = 'icon',
					default = defaultIcon,
                    help = 'File path to configuration file')

args = parser.parse_args()

setAppIcon(args.codePath, args.icon, args.iconPath)