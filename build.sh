#!/bin/bash



echo "Loading modules updates..............."
git submodule update --init --recursive

echo "Environment vars............"
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$PATH:$JAVA_HOME
export ANDROID_NDK_HOME=/home/khidrew/Android/Sdk/ndk/20.0.5594570/
export PATH=$PATH:$ANDROID_NDK_HOME
export ANDROID_SDK_ROOT=/home/khidrew/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT


# Check if the 'build' directory exists, and if not, create it
if [ ! -d "build" ]; then
  echo "Creating build directory..............."
  mkdir build
fi

cd build

cmake ../ -DLINPHONESDK_PLATFORM=Android -DLINPHONESDK_ANDROID_ARCHS=arm64 -DENABLE_GPL_THIRD_PARTIES=NO -DENABLE_NON_FREE_CODECS=ON -DENABLE_G729=ON
echo "================================ Start build ============================================"
cmake --build .

