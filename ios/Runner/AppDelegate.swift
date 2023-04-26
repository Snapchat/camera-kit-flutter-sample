import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var supportedOrientations: UIInterfaceOrientationMask = .allButUpsideDown
    private let flutterHelper = FlutterCameraViewControllerFactory()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = (window?.rootViewController as! FlutterViewController)
        let methodChannel = FlutterMethodChannel(name: "com.camerakit.flutter.sample.simple", binaryMessenger: controller.binaryMessenger)
        GeneratedPluginRegistrant.register(with: self)
        methodChannel
            .setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                if call.method == "openCameraKitLenses" {
                    let cameraViewController = FlutterCameraViewControllerFactory.cameraViewController(with: result)
                    self.present(cameraViewController) {captureConfig in
                        let captureConfigAsDictionary = captureConfig as! Dictionary<String, String>
                        result(captureConfigAsDictionary)
                    }
                } else {
                    result(FlutterMethodNotImplemented)
                }
            })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func present(_ viewController: FlutterCameraViewController, result: @escaping FlutterResult) {
        let rootViewController = (self.window?.rootViewController as! FlutterViewController)
        rootViewController.present(viewController, animated: false)
    }
}

// MARK: Helper Orientation Methods
extension AppDelegate: AppOrientationDelegate {
    func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        supportedOrientations = orientation
    }

    func unlockOrientation() {
        supportedOrientations = .allButUpsideDown
    }
}
