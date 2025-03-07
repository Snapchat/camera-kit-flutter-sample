
# Camera Kit sample app using Flutter wrapper
> [!IMPORTANT] 
> This repository contains example projects to help you get started with Camera Kit integrations. The software is provided "as is" without any warranties or guarantees, and it is not officially supported for production use.

The sample apps in this repository show how to integrate Camera Kit in a Flutter app. They use Flutter's wrapper `MethodChannel` to invoke Camera Kit APIs in native android/ios. All the Live Camera view and Lenses are currently implemented in native Android using Camera Kit's `CameraActivity` class. For iOS, they are implemented using `FlutterCameraViewController`, a custom viewcontroller similar to CameraViewController in the ReferenceUI module in Snap's Camera Kit SDK. 

Once user takes a photo or a video, final result is shown back in Flutter layer.

**How it works**: On Android, when the floating action button is clicked it calls `invokeMethod` on Flutter stack which takes the control to Android implementation on Kotlin to open Camera Kit's `CameraActivity`. When the user takes a picture a video, file path from the cache is then passed back to Fluter layer using `MethodChannel.Result`. Flutter layer then use this file path result to show captured photo or video in Flutter UI using `Image` or `VideoPlayerController` plugins.

On iOS the app works in a similar fashion. After the floating action button calls `invokeMethod` on Flutter, the app opens FlutterCameraViewController. Once the user takes a picture or video, its file path on device is passed back and in Flutter's' UI using `Image` or `VideoPlayerController` plugins.   

**Demo**:
https://youtube.com/shorts/YyQwRUQA71I?feature=share

## Building and running the app
These instruction assume your Flutter installed on your machine. If you do not have Flutter or encounter any issues with it, see the installation [instructions](https://docs.flutter.dev/get-started/install).

1. Clone or download the project folder
2. In the terminal, change your directory to where you cloned or unzipped the project folder
3. Run `flutter run`

You have now installed the app on your machine

### iOS Configuration


1. Once `flutter run` is finished, navigate to the `iOS` folder and open `Running.xcworkspace` using Xcode. You should see two projects: Runner and Pods
2. Navigate to Configuration.swift and enter your app's Camera Kit credentials
3. Navigate to the Runner project and open the Signing & Capabilities Tab. Fill out the Signing section with your Apple Developer credentials 
4. Plug in an iOS device and run the target `Runner`

The app should now be running on your device.     


---
We don’t plan to regularly update this code, but rather we provide it as sample code that you can adapt to your needs. Thus, we will allow forks to this repo which can be up/downvoted, but we will not be accepting PRs. If you have questions, please use the [Community Forum](https://community.snap.com/snapar/categories/camera-kit).

