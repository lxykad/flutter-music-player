//
// Created by Boyan01 on 2019/10/17.
//

import Foundation
import Flutter

typealias BackgroundRegistrarCallback = (FlutterPluginRegistry) -> Void

/// This is the background service for MusicPlayer.
/// Provider dart api when app entry background status, such as :
///   loadImage() for loading cover for current playing music
///   getPlayUrl() for fetch the url when music is ready to play.
public class SwiftBackgroundPlugin: NSObject, FlutterPlugin {

    static var registrarCallback: BackgroundRegistrarCallback?

    public static func startBackground() {
        let engine = FlutterEngine(name: "PlayerBackground", project: FlutterDartProject())!
        if !engine.run(withEntrypoint: "playerBackgroundService") {
            print("can not start background isolate from music player")
            return
        }
        register(with: engine.registrar(forPlugin: "tech.soit.quiet.Background"))
        registrarCallback?(engine)
    }


    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tech.soit.quiet/background_callback", binaryMessenger: registrar.messenger())
        let plugin = SwiftBackgroundPlugin()
        registrar.addMethodCallDelegate(plugin, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    }
}

