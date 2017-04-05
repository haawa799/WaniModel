import os

def editedFileText(fileName, originalText):
  sep = 'extension '
  inputString = originalText.split(sep, 1)[0]

  lines = inputString.split('\n')
  filteredLines = []
  for line in lines:
    if (("let" in line) or ("var" in line)) and ("static" not in line) and ("{" not in line):
      newLine = line.split(':', 1)[0]
      newLine = newLine.split(' ')[-1]
      filteredLines.append(newLine)
    continue

  bodyString = ""
  for propertyStr in filteredLines:
    newLine = "(lhs." + propertyStr + " == rhs." + propertyStr + ") && \n"
    bodyString += newLine
  bodyString = bodyString[:-5]

  hatString = '''\n\npublic func ==(lhs: ''' + fileName + ''', rhs: ''' + fileName +''') -> Bool {
  return '''

  bottomString = '''
  }'''

  finalString = originalText + hatString + bodyString + bottomString
  return finalString


files = filter(os.path.isfile, os.listdir( os.curdir ) )
swiftFiles = []
for file in files:
    parts = file.split('.', 1)
    if "swift" in parts[1]:
        swiftFiles.append(file)
print(swiftFiles)
for file in swiftFiles:
    parts = file.split('.', 1)
    name = parts[0]
    updatedFile = ""
    with open (file, "r") as myfile:
        text = myfile.read()
        updatedFile = editedFileText(name, text)
    with open(file, "w") as myfile:
        myfile.write(updatedFile)
