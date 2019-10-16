# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "CImGui"
version = v"1.73.0"

# Collection of sources required to build CImGui
sources = [
    "https://github.com/ocornut/imgui.git" =>
    "688cf868ea83db6c2958dd6bf7a20d471d00940b",

    "https://github.com/cimgui/cimgui.git" =>
    "1c65ee2bdc719fb3ef62b4615d66fe8effa21148",

    "wrapper",
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
mv imgui cimgui/
mv helper.c cimgui/
mv helper.h cimgui/
cd cimgui/
rm CMakeLists.txt
mv ../CMakeLists.txt ./
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=${prefix} -DCMAKE_TOOLCHAIN_FILE=/opt/${target}/${target}.toolchain
make
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:i686, libc=:glibc),
    Linux(:x86_64, libc=:glibc),
    Linux(:aarch64, libc=:glibc),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf),
    Linux(:i686, libc=:musl),
    Linux(:x86_64, libc=:musl),
    Linux(:aarch64, libc=:musl),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf),
    MacOS(:x86_64),
    FreeBSD(:x86_64),
    Windows(:i686),
    Windows(:x86_64)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libcimgui", :libcimgui)
    LibraryProduct(prefix, "libcimgui_helper", :libcimgui_helper)
]

# Dependencies that must be installed before this package can be built
dependencies = [

]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
