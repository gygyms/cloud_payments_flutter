import Flutter
import UIKit
//import SDK_iOS

public class SwiftCloudpaymentsflutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cloudpaymentsflutter", binaryMessenger: registrar.messenger())
    let instance = SwiftCloudpaymentsflutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  //  let card = Card()
  //  let cardCryptogramPacket = card.makeCryptogramPacket(cardNumber, andExpDate: expDate, andCVV: cvv, andMerchantPublicID: Constants.merchantPulicId)
    result("iOS " + UIDevice.current.systemVersion)
  }
}
