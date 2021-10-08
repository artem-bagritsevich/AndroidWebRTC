This branch contains **WebRTC** native libraries for **arm**, **arm64**, **x86** and **x86_64** built for **Android**, 
and **jar** library to communicate with them via JNI.

To use it in the Android project put native libs to **jniLibs** Android folder and java library to **libs** Android folder.
Don't forget to include java library in the **Gradle** sctipt. As for the native libraries use: https://developer.android.com/reference/java/lang/System#loadLibrary(java.lang.String) at the runtime.
