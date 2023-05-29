#!/bin/sh

# The default execution directory of this script is the ci_scripts directory.
cd $CI_WORKSPACE

# Install Flutter using git.
git clone --depth 1 --single-branch https://github.com/flutter/flutter.git -b 3.7.10 $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios

# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew"s automatic updates.
brew install cocoapods

# Install CocoaPods dependencies.
cd ios && pod deintegrate && pod install # run `pod install` in the `ios` directory.

echo "{
	\"apiKey\": \"$API_KEY\",
	\"appId\": \"$APP_ID\",
	\"messagingSenderId\": \"$SENDER_ID\",
	\"projectId\": \"$PROJ_ID\",
	\"storageBucket\": \"$BUCKET_NAME\",
	\"iosClientId\": \"$IOS_CLIENT_ID\",
	\"iosBundleId\": \"$IOS_BUNDLE_ID\"
}" > $CI_WORKSPACE/assets/firebase_config.json

exit 0