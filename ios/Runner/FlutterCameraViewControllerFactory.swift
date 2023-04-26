import Foundation
import SCSDKCameraKit
import SCSDKCameraKitReferenceUI

final class FlutterCameraViewControllerFactory {
    static func cameraViewController(with result: @escaping FlutterResult) -> FlutterCameraViewController {
        let cameraController = CameraController(sessionConfig: SessionConfig(
            applicationID: Configuration.applicationId, apiToken: Configuration.apiToken))
        cameraController.groupIDs = [Configuration.lensGroupId]
        let cameraViewController = FlutterCameraViewController(cameraController: cameraController)
        cameraViewController.modalPresentationStyle = .fullScreen
        cameraViewController.onDismiss = {
            guard let lastPath = cameraViewController.url?.path,
                  let mimeType = cameraViewController.mimeType
            else {
                fatalError("Container must have url path and mimeType")
            }
            
            result(["path": lastPath,
                    "mime_type": mimeType])
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        cameraViewController.appOrientationDelegate = appDelegate
        return cameraViewController
    }
}
