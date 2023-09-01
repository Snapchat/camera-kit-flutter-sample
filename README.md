
# Camera Kit sample app using Flutter wrapper
Sample app showcasing how to integrate Camera Kit in a Flutter app. It is using Flutter's wrapper `MethodChannel` to invoke Camera Kit APIs in native android/ios. All the Live Camera view and Lenses are currently implemented in native Android using Camera Kit's `CameraActivity` class. For iOS they are implemented using FlutterCameraViewController. This is a custom viewcontroller similar to CameraViewController in Snap's ReferenceUI. 

Once user takes a photo or a video, final result is shown back in Flutter layer.

**What's supported:** This currently only works Android. WIP for iOS.

**How it works**: On Android, when the floating action button is clicked it calls `invokeMethod` on Flutter stack which takes the control to Android implementation on Kotlin to open Camera Kit's `CameraActivity`. When the user takes a picture a video, file path from the cache is then passed back to Fluter layer using `MethodChannel.Result`. Flutter layer then use this file path result to show captured photo or video in Flutter UI using `Image` or `VideoPlayerController` plugins.

On iOS the app works in a similar fashion. After the floating action button calls `invokeMethod` on Flutter, the app opens FlutterCameraViewController. Once the user takes a picture or video, its file path on device is passed back and in Flutter's' UI using `Image` or `VideoPlayerController` plugins.   

**Demo**:
https://youtube.com/shorts/YyQwRUQA71I?feature=share

## Building and running the app
These instruction assume your Flutter installed on your machine. If you do not or encounter any issues with Flutter, see the installation instructions

1. Clone or download the project folder
2. In the terminal, change your directory to where you cloned or unzipped the project folder
3. Run `flutter run`

You have now installed the app on your machine

### iOS Configuration

1. Once, the project is compiled, navigate to the `iOS` folder and open `Running.xcworkspace` using Xcode. You should two projects: Runner and Pods
2. Navigate to Configuration.swift and enter your app's Camera Kit credentials
3. Navigate to the Runner project and open the Signing & Capabilities Tab. Fill out the Signing section with your Apple Developer credentials 
5. Plug in an iOS device and run the target `Runner`
6. Add you credentials to `Configuration.swift`

The app should now be running on your device.     

