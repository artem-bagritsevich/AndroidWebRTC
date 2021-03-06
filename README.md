**NOTE:** Don't clone this repository! If you want to build WebRTC manually just download single `build_webrtc.sh` file and follow the steps listed below.

**In case if you need ready libraries just clone artifacts branch:** 
`git clone git@github.com:artem-bagritsevich/AndroidWebRTC.git --branch artifacts --single-branch`

According to the official docs only Linux supported, so I highly recommend using Ubuntu.

Here are the instructions on how to get content of this repository manually step by step:

- **Step 1.** Clone the latest depot tools from the official repository.
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

- **Step 2.** Add depot_tools to the front of your PATH (you will probably want to put this in your ~/.bashrc or ~/.zshrc). 

- **Step 3.** Get WebRTC sources (after this step src folder should appear):
`fetch --nohooks webrtc_android`

- **Step 4.** Sync projects:
`gclient sync`

- **Step 5.** Run the build! Note that build_webrtc.sh script and src dir should be on the same level:
`./build_webrtc.sh`

- **Step 6.** After the build artifacts can be found under ROOT_DIR/artifacts

**This repo is part of WebRTC examples, see also:**
- WebRTC Signaling server in Ktor - https://github.com/artem-bagritsevich/WebRTCKtorSignalingServerExample
- P2P Android client based on WebRTC - https://github.com/artem-bagritsevich/WebRTCAndroidAppExample
