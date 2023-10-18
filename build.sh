#!/bin/bash



echo "Loading modules updates..............."
git submodule update --init --recursive


# Check if the 'build' directory exists, and if not, create it
if [ ! -d "build" ]; then
  echo "Creating build directory..............."
  mkdir build
fi

cd build

cmake ../ -DLINPHONESDK_PLATFORM=Android -DLINPHONESDK_ANDROID_ARCHS=arm64 -DENABLE_GPL_THIRD_PARTIES=NO -DENABLE_NON_FREE_CODECS=ON -DENABLE_G729=ON
echo "================================ Start build ============================================"
cmake --build .

