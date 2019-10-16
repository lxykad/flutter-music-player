import Flutter
import UIKit

public class SwiftMusicPlayerPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tech.soit.quiet/player", binaryMessenger: registrar.messenger())
        let instance = SwiftMusicPlayerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("method : \(call.method), argument : \(call.arguments ?? "NULL")")
        result("iOS " + UIDevice.current.systemVersion)
    }
}
