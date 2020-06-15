import Flutter
import UIKit

public class SwiftCloudpaymentsflutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cloudpaymentsflutter", binaryMessenger: registrar.messenger())
    let instance = SwiftCloudpaymentsflutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
