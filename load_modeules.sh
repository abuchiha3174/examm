#!/bin/bash

# === Load modules with Spack ===

# GCC (9.3)

spack load gcc/lhqcen5

# CMake
spack load cmake/pbddesj

# OpenMPI
spack load openmpi/xcunp5q

# libtiff
spack load libtiff/gnxev37

# === Build EXAMM ===

# Create build directory if it doesn't exist
rm -rf build
mkdir build
cd build

# Run cmake and make
cmake ..
make 
