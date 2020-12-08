import Flutter
import UIKit

protocol isAbleToReceiveData {
  func pass(data: String)  //data: string is an example parameter
}

public class SwiftFlutterPluginScanPlugin: NSObject, FlutterPlugin ,FlutterStreamHandler{
    
    var eventSink: FlutterEventSink?
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_scan", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPluginScanPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    let eventChannel = FlutterEventChannel(name: "scan_event", binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    if (call.method == "startScan"){
        let vc = ScanViewController()
        let homeView:UINavigationController = UINavigationController(rootViewController:vc)
        UIApplication.shared.keyWindow?.rootViewController?.present(homeView, animated: true, completion: nil)
        vc.getBlock{(value) in
            
            self.eventSink!(value)
        }
    } else {
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
