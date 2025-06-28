#!/bin/bash

# Script to rebuild project from scratch

echo "=== Cleaning previous build directory ==="
rm -rf build
rm -rf test_output

echo "=== Creating new build directory ==="
mkdir build

echo "=== Entering build directory ==="
cd build

echo "=== Running CMake ==="
cmake ..

echo "=== Starting build (make) ==="
make

echo "=== Build complete ==="

cd ..
sh scripts/base_run/coal_mpi.sh
