from PIL import Image
import os
import re
import shutil

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
        if item == ".git":
            continue

        fullPath = os.path.join(dire, item)

        if os.path.isfile(fullPath):
            os.makedirs(drive, exist_ok=True)
            shutil.copy(fullPath, os.path.join(drive, item))
        elif not os.path.isfile(fullPath):
            copyFilesFromDir(os.path.join(drive, item), fullPath)

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

    if os.path.exists("app.lua"):
        with open("app.lua", "r") as file:
            lines = file.readlines()
            for line in lines:
                search = re.match("^lv1lua.dataloc = \"(.+)\"", line)
                if search:
                    name = re.sub("/dev_usb/", "",search.group(1))
                    name = name[0:-1] + "\\"
                    shutil.copy("app.lua", driveInput + ":\\")

    print(driveInput + ":\\" + name)

    #copyFilesFromDir(driveInput + ":\\" + name)