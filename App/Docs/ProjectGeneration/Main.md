## Project Generation (XcodeGen)

### Definition

We use XcodeGen to take every file from the file system, and generate the project file, file linking, customer customization and signing configuration.
[XcodeGen](https://github.com/yonaskolb/XcodeGen)

### How to install

We need to install XcodeGen from the gem bundle

Requirement (Bundler):
```
gem install bundler
```

XcodeGen:
```
bundle install
```
If this fails, try 
```
bundle update
```

### Run the scripts

Python3 is needed

Setup the project using `generateProject.py`:

- Generates the .xcodeproj file using XcodeGen
- Adds a verbose parameter (if needed)

Sample Use
```
./generateProject.py\
    --verbose
```

Make sure the file has execution permissions:
```
chmod +x setup.py
```

### How are XcodeGen files organized

- Main file: `project.yml` ~> Imports every subfile
- XcodeGen folder ~> Contains a file per target definition & SPM definition

### How to update XcodeGen embedded binary

1) Download or clone the desired version from the repo:
```
git clone https://github.com/yonaskolb/XcodeGen.git
```

2) Build the binary (It should be universal by default arm64 and x86_64)
```
cd XcodeGen
make install
```

3) Find the recentely created binary and move it to the root folder of the main project's repository

4) Remove the old file

5) Rename xcodegen to include the version like:
```
xcodegen-2.28.0
``` 

6) Modify the script `setup.py` line that calls XcodeGen to that binary:
```
generateXcodeproj = './xcodegen-{YOUR_VERSION} generate'
```
 
