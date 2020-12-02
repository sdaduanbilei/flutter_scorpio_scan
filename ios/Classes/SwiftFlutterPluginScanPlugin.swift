import Flutter
import UIKit

public class SwiftFlutterPluginScanPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_scan", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPluginScanPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "getPlatformName"){
        let homeView:UINavigationController = UINavigationController(rootViewController: HomeViewController())
        UIApplication.shared.keyWindow?.rootViewController?.present(homeView, animated: true, completion: nil)
        
    } else {
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
