# MyCatholicSGApp

## Setup

This setup process has been tested on Windows 10/11 for Android as well as macOS (M2 Chip) for both Android and IOS

### Prerequisites

This assumes that Flutter SDK ([Windows](https://docs.flutter.dev/get-started/install/windows), [macOS](https://docs.flutter.dev/get-started/install/macos)) and Android Studio ([Windws](https://developer.android.com/studio/install#windows), [macOS](https://developer.android.com/studio/install#mac)) has already been installed. Also, you should already have a Firebase project from the MyCatholicSG web app.

1. Install [Java 18](https://www.oracle.com/java/technologies/javase/jdk18-archive-downloads.html) and make sure that the `JAVA_HOME` variable is mapped to Java 18.
      - Check this by running `echo %JAVA_HOME%` (Windows), `echo $JAVA_HOME` (macOS)
2. Install [Flutter Version Manager](https://fvm.app/documentation/getting-started/installation) `fvm` and make sure that it is added to `PATH`.
      - Check this by running `fvm -v`. It should give you an output.
3. Clone the MyCatholicSGApp repository. If `.fvm` directory exists at the root directory, delete it.

### Running and Compiling for Android and IOS

1. Until further notice, `root` directory will refer to `/path/to/MyCatholicSGApp/`.
2. In the `root` directory, downgrade Flutter to `3.7.10`
      - Install it, `fvm install 3.7.10` (this will take a while and there will be a bunch of warnings due to outdated dependencies).
      - Kill Terminal and Restart VSCode
      - Use it, `fvm use 3.7.10` (this will take a while).
      - Kill Terminal and start a new one. Then run `flutter --version`, it should say `Flutter 3.7.10`
3. In the `assets` directory, create a `firebase_config.json` file.
      - From the Firebase console, go to your web app and copy over your firebaseConfig into the `json` file.
        - (For IOS) Ensure that the fields in the `assets/firebase_config.json` file matches that of the `/ios/Runner/GoogleService-Info.plist` file.
          You may leave the field for `measurementId` empty if you are not able to get the value for it.
      - **If on prod branch, this step is not needed.**
4. In the `/android/app/build.gradle`, remove/comment out the `signingConfigs`'s `storeFile`, `storePassword`, `keyAlias`, and `keyPassword`.

```
signingConfigs {
    release {
        // storeFile file(localProperties.getProperty('RELEASE_KEYSTORE_PATH'))
        // storePassword localProperties.getProperty('RELEASE_KEYSTORE_PASSWORD')
        // keyAlias localProperties.getProperty('RELEASE_KEY_ALIAS')
        // keyPassword localProperties.getProperty('RELEASE_KEY_PASSWORD')
    }
}
```

5. In `/lib/main.dart`, add a `name` parameter to `Firebase.initializeApp` in the `main` function.
      - This `name` should follow the name of your Firebase project
      - **If on prod branch, this step is not needed.**

```dart
await Firebase.initializeApp(
    name: '<ProjectID>', // no need if on prod
    options: firebaseOptions.currentPlatform,
);
```

6. Open up the command palette `Ctrl + Shift + P`, and enter `Flutter: Select Device`.
7. Select the Android/IOS device wanted and it wait for it to boot up.
8. Finally, click the top right hand corner and `Start Debugging` or run `flutter run` (this will take a while and there will be a bunch of warnings due to outdated dependencies).
