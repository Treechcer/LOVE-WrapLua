from PIL import Image
import os
import re
import math

global curDir

curDir = os.getcwd()

def writeLuaFileFromImage(imagePath):
    img = Image.open(imagePath)
    with open (re.sub(r"\.png$", ".lua", imagePath), "w", encoding="utf8") as f:
        fileThing = f"""img = {{
    w = {img.width},
    h = {img.height}
}}

return img"""
        f.write(fileThing)

def goThroughDir(dire = curDir):
    for item in os.listdir(dire):
        fullPath = os.path.join(dire, item)
        if os.path.isfile(fullPath) and re.search(r"\.png$", str(item)):
            writeLuaFileFromImage(fullPath)
        elif not os.path.isfile(fullPath):
            goThroughDir(fullPath)

def copyFilesFromDir(drive, dire = curDir):
    for item in os.listdir(dire):
        fullPath = os.path.join(dire, item)
        os.rename(fullPath, drive + item)

def getInputValue(correctInputs, message, typeF = str):
    while True:
        i = typeF(input(message).strip())

        if i in correctInputs:
            return i

def deDriveDrives(drives):
    for i in range(len(drives)):
        drives[i] = re.sub(r":\\", "", drives[i])

    return drives

drives = deDriveDrives(os.listdrives())
driveInput = getInputValue(drives, "Which of these drive letters is your PS3 USB?: " + str(drives) + ": ")

if os.path.exists(driveInput + ":\\"):
    copyFilesFromDir(driveInput + ":\\")