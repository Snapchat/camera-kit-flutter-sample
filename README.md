
# Camera Kit sample app using Flutter wrapper
Sample app showcasing how to integrate Camera Kit in a Flutter app. It is using Flutter's wrapper `MethodChannel` to invoke Camera Kit APIs in native android\ios. All the Live Camera view and Lenses are currently implemented in native Android using Camera Kit's `CameraActivity` class. Once user takes a photo or a video, final result is shown back in Flutter layer.

**What's supported:** This currently only works Android. WIP for iOS.

**How it works**: When the floating action button is clicked it calls `invokeMethod` on Flutter stack which takes the control to Android implemention on Kotlin to open Camera Kit's `CameraActivity`. When user takes a picture a video, file path from the cache is then passed back to Fluter layer using `MethodChannel.Result`. Flutter layer then use this file path result to show captured photo or video in Flutter UI using `Image` or `VideoPlayerController` plugins.

**Demo**:
https://youtube.com/shorts/YyQwRUQA71I?feature=share

