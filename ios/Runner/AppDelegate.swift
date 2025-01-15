
import UIKit
import Flutter
import Photos

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController

        // Initialize PhotoGalleryApiHandler
        let photoGalleryApiHandler = PhotoGalleryApiHandler()

        // Set up the PhotoGalleryNativeHostApi channel
        PhotoGalleryNativeHostApiSetup.setUp(
            binaryMessenger: controller.binaryMessenger,
            api: photoGalleryApiHandler
        )

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}




