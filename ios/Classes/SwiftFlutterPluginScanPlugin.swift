import Flutter
import UIKit

protocol isAbleToReceiveData {
  func pass(data: String)  //data: string is an example parameter
}

public class SwiftFlutterPluginScanPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_scan", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPluginScanPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    if (call.method == "startScan"){
        let vc = ScanViewController()
        let homeView:UINavigationController = UINavigationController(rootViewController:vc)
        UIApplication.shared.keyWindow?.rootViewController?.present(homeView, animated: true, completion: nil)
        vc.getBlock{(value) in
            result(value)
        }
    } else {
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
