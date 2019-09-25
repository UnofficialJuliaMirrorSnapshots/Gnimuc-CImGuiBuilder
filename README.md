# CImGuiBuilder

[![Build Status](https://travis-ci.com/Gnimuc/CImGuiBuilder.svg?branch=master)](https://travis-ci.com/Gnimuc/CImGuiBuilder)

This repository builds binary artifacts for the [cimgui](https://github.com/cimgui/cimgui) project. Binary artifacts are automatically uploaded to
[this repository's GitHub releases page](https://github.com/Gnimuc/CImGuiBuilder/releases) whenever a tag is created
on this repository.

This repository was created using [BinaryBuilder.jl](https://github.com/JuliaPackaging/BinaryBuilder.jl)

## How to build locally
```
# clone cimgui and imgui
cd wrapper
git clone --recursive https://github.com/cimgui/cimgui.git
cd cimgui
git checkout 1.72b
git submodule update

# for patched or extended imgui versions, you might need to regenerate C89 wrappers using cimgui, see https://github.com/cimgui/cimgui#using-generator for further details  

# copy helpers to cimgui folder and replace CMakeLists
cp ../helper.c ./
cp ../helper.h ./
rm CMakeLists.txt
cp ../CMakeLists.txt ./

# build and install
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=./
make
make install
```
