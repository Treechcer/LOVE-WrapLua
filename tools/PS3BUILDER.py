from PIL import Image
import os
import re

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

goThroughDir()