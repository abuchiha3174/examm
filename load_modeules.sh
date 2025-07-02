#!/bin/bash

echo "======================================"
echo "🔧 Loading required modules with Spack"
echo "======================================"

# Load modules
echo "Loading GCC (9.3)..."
spack load gcc/lhqcen5

echo "Loading CMake..."
spack load cmake/pbddesj

echo "Loading OpenMPI..."
spack load openmpi/xcunp5q

echo "Loading libtiff..."
spack load libtiff/gnxev37

echo "======================================"
echo "📁 Setting up a safe TMPDIR"
echo "======================================"

export TMPDIR=$HOME/tmp
mkdir -p $TMPDIR

echo "======================================"
echo "🏗️  Building EXAMM"
echo "======================================"

echo "Cleaning previous build directory..."
rm -rf build

echo "Creating new build directory..."
mkdir build
cd build

echo "Running CMake configuration with TMPDIR=$TMPDIR..."
TMPDIR=$TMPDIR cmake ..

echo "Compiling with make using TMPDIR=$TMPDIR..."
TMPDIR=$TMPDIR make -j$(nproc)

echo "✅ Build complete."
echo "======================================"