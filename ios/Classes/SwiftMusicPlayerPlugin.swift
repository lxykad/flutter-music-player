import Flutter
import UIKit
import AVFoundation

public class SwiftMusicPlayerPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tech.soit.quiet/player", binaryMessenger: registrar.messenger())
        let instance = SwiftMusicPlayerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("method : \(call.method), argument : \(call.arguments ?? "NULL")")
        result("iOS " + UIDevice.current.systemVersion)

        result(FlutterMethodNotImplemented)
    }

    private var player: AVAudioPlayer?


    private func newPlayer() -> AVAudioPlayer {
        if player == nil {
            player = AVAudioPlayer()
        }
        return player!
    }

    public func applicationWillEnterForeground(_ application: UIApplication) {

    }

    public func applicationDidEnterBackground(_ application: UIApplication) {

    }


}

protocol TransportController {


    func skipToNext()

    func skipToPrevious()

    func pause()

    func play()

    func playFromMediaId()

    func seekTo()

    func setShuffleMode()

    func setRepeatMode()


}

protocol MediaController {

    func isSessionReady() -> Bool

    // TODO playback state
    func getPlaybackState() -> Int


    func getQueue() -> [MediaMetadata]

    func getQueueTitle() -> String

    // TODO playback info
    func getPlaybackInfo() -> String


    func getRepeatMode() -> Int

    func getShuffleMode() -> Int

}


protocol PlaylistController {

    func addQueueItem(metadata: MediaMetadata)


    func removeQueueItem(metadata: MediaMetadata)

}