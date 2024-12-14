#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from PIL import Image
import sys
import argparse

def saveIconSize(out,file,size,scale,suffix=""):
    scaleString = ""
    if scale>1:
        scaleString = "@" + str(scale) + "x"
    
    name = "Icon-"+ str(size) + scaleString + suffix +".png"
    saveIcon(out,file,size,scale,name)    
    

def saveIcon(out,file,size,scale,name):
    im = openImage(file)
    
    destination = os.path.join(out,name)
    
    width = int(size*scale)
    print "Generating icon " + str(size) + " @" + str(scale) + "x" + " to " + destination
    im = im.resize((width,width),Image.ANTIALIAS)

    im.save(destination)

def isTransparent(color):
    if len(color) != 4:
        return false
    else:
        return color[3] < 255
        
def imageIsTransparent(im):
    return im.mode in ('RGBA', 'LA') or (im.mode == 'P' and 'transparency' in im.info)

def openImage(file):
    im = Image.open(file)
    return removeTransparency(fillTransparentAreas(im))


def fillTransparentAreasWithColor(im, bg_colour=(255, 255, 255)):
    # Only process if image has transparency (http://stackoverflow.com/a/1963146)
    if imageIsTransparent(im):

        # Need to convert to RGBA if LA format due to a bug in PIL (http://stackoverflow.com/a/1963146)
        alpha = im.convert('RGBA').split()[-1]

        # Create a new background image of our matt color.
        # Must be RGBA because paste requires both images have the same format
        # (http://stackoverflow.com/a/8720632  and  http://stackoverflow.com/a/9459208)
        bg = Image.new("RGBA", im.size, bg_colour + (255,))
        bg.paste(im, mask=alpha)
        return bg

    else:
        return im

def dominantColor(im, default=(255, 255, 255)):
    imR = im.convert('RGB')
    colors = imR.getcolors(maxcolors=1000000)
    
    if colors == None:
        return default
    
    dominant = sorted(colors, key=lambda c: c[0])[-1]
    return dominant[1]

def fillTransparentAreas(im, default=(255, 255, 255)):
    if imageIsTransparent(im):
        dominant = dominantColor(im, default)
        return fillTransparentAreasWithColor(im, dominant)
    else:
        return im

def removeTransparency(im):
    return fillTransparentAreas(im).convert('RGB') 


### ------------------
### Parameters
### ------------------
defaultCodePath = '../Code/Project'
defaultIconPath = defaultCodePath + '/Project/Images.xcassets'
defaultIconSet = 'AppIcon-Release.appiconset'
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
                    help = 'File path to icons')

parser.add_argument('-is', '--iconSet',
                    action = 'store',
                    dest = 'iconSet',
                    default = defaultIconSet,
                    help = 'Icon set name')

parser.add_argument('-if', '--icon',
					action = 'store',
					dest = 'icon',
					default = defaultIcon,
                    help = 'File path to Icon file')

args = parser.parse_args()

file = args.icon
output = os.path.join(args.iconPath, args.iconSet)

saveIcon(output,file,1024,1,"AppStore-1024.png")

saveIcon(output,file,1024,1,"iTunesArtwork-512@2x.png")
saveIcon(output,file,512,1,"iTunesArtwork-512.png")

saveIconSize(output,file,76,2)
saveIconSize(output,file,76,1)

saveIconSize(output,file,60,3)
saveIconSize(output,file,60,2)

saveIconSize(output,file,83.5,2)

saveIconSize(output,file,20,2)
saveIconSize(output,file,20,3)

saveIconSize(output,file,20,1)
saveIconSize(output,file,20,2,"-1")

saveIconSize(output,file,40,3)
saveIconSize(output,file,40,2)
saveIconSize(output,file,40,2,"-1")
saveIconSize(output,file,40,1)

saveIconSize(output,file,29,3)
saveIconSize(output,file,29,2)
saveIconSize(output,file,29,2,"-1")
saveIconSize(output,file,29,1)

saveIcon(output,file,20,3, "Icon-20@3x_notifications.png")
saveIcon(output,file,20,2, "Icon-20@2x_notifications.png")
saveIcon(output,file,20,2, "Icon-20@2x_ipad_notifications.png")
saveIcon(output,file,20,2, "Icon-20_ipad_notifications.png")

