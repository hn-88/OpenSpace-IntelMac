#!/bin/bash
echo "------------------------------------------"
echo "Install dependencies..."
brew update
brew install git cmake glm glew boost freeimage mpv vulkan-headers vulkan-loader brotli gdal qt@6

echo "------------------------------------------"
echo "Get patched OpenSpace code..."
git clone --recursive https://github.com/hn-88/OpenSpace.git
cd OpenSpace
git checkout ToCompileOnMacOS --recurse-submodules

echo "------------------------------------------"
echo "Get patched Ghoul code..."
cd ext
rm -rf ghoul
git clone https://github.com/hn-88/Ghoul.git --branch MacOSfixes --recursive
cd ..
mkdir build
cd build

echo "------------------------------------------"
echo "Generate XCode project, configure cmake..."
cmake -G Xcode -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_CXX_STANDARD=20 -DONLY_ACTIVE_ARCH=YES -DCMAKE_OSX_ARCHITECTURES=x86_64 -DCMAKE_OSX_DEPLOYMENT_TARGET=13.3 -DCMAKE_CXX_FLAGS="-Wno-error -D_FILE_OFFSET_BITS=64" -DCMAKE_C_FLAGS="-Wno-error -Wno-dev -D_FILE_OFFSET_BITS=64" -DCMAKE_BUILD_TYPE="Release" -DCMAKE_PREFIX_PATH=/opt/homebrew -DBUILD_TESTS=OFF -DCOMPILE_WARNING_AS_ERROR=OFF -DOPENSPACE_HAVE_TESTS=OFF -DSGCT_BUILD_TESTS=OFF ..

echo "------------------------------------------"
echo "Compile with XCode..."
cmake --build . --config Release -- -DCMAKE_OSX_ARCHITECTURES=x86_64 -DCMAKE_OSX_DEPLOYMENT_TARGET=13.3



