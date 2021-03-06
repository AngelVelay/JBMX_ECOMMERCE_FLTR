import UIKit
import Flutter
import GoogleMaps
import FacebookCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate,UIResponder, UIApplicationDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   
    GMSServices.provideAPIKey("AIzaSyDHeOy56eJmeDpjwpjAZsDebgJW04QEv0s")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    return true
  }

  func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }  
}

