#!/bin/bash -e

#Setting up common constants
ROOT_DIR=`pwd`
SRC_DIR="${ROOT_DIR}/src"
OUT_DIR="${ROOT_DIR}/artifacts"

#Setting GN arguments for the release android build
GN_ARGS="target_os=\"android\" is_debug=false is_official_build=true"

#Component builds are not supported anymore
GN_ARGS+=" is_component_build=false"
#We dont need tests
GN_ARGS+=" rtc_include_tests=false"

# Declaring dictionary of supported architectures to fill architecture name
declare -A ARCHITECTURES=( ["arm"]="armeabi-v7a" ["arm64"]="arm64-v8a" ["x86"]="x86" ["x64"]="x86_64" )

#Entering source directory
pushd ${SRC_DIR}

#Installing sysroot
./build/linux/sysroot_scripts/install-sysroot.py --arch=amd64

# Building for each architecture
for ARCH in ${!ARCHITECTURES[@]}
do
    # declare build directory
    BUILD_DIR="jniLibs/${ARCHITECTURES[$ARCH]}"
    # set arcutecture as a GN parameter
    GN_ARGS="${GN_ARGS} target_cpu=\"$ARCH\""
    echo "INFO: building WebRTC for $ARCH"
    # First step of the build: Generating ninja files with GN
    gn gen "${BUILD_DIR}" --args="${GN_ARGS}"
    # Second step of the build: assembling everything with ninja
    ninja -C "${BUILD_DIR}"

    # copying generated artifacts to artifacts dir
    NATIVE_OUT_DIR="${OUT_DIR}/${BUILD_DIR}"
    mkdir -p ${NATIVE_OUT_DIR}
    cp ${BUILD_DIR}/libjingle_peerconnection_so.so \
       ${NATIVE_OUT_DIR}/libjingle_peerconnection_so.so
    echo "INFO: $ARCH has successfully built"
done

# Copying java library
echo "Copying java library"
mkdir -p ${OUT_DIR}/java
    cp ${BUILD_DIR}/lib.java/sdk/android/libwebrtc.jar \
       ${OUT_DIR}/java/libwebrtc.jar
echo "BUILD SUCCESS"

