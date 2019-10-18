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

    private let player = QuietPlayer()

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("method : \(call.method), argument : \(call.arguments ?? "NULL")")

        switch call.method {
        case "init":
            break
        case "skipToNext":
            player.skipToNext()
            break
        case "skipToPrevious":
            player.skipToPrevious()
            break
        case "pause":
            player.pause()
            break
        case "play":
            player.play()
            break
        case "playFromMediaId":
            let argument = call.arguments as! [String: Any]
            let mediaId: String = argument["mediaId"] as! String
            let playList: [MediaMetadata] = (argument["queue"] as! [Any]).map { map in
                MediaMetadata(data: map as! [String: AnyObject])
            }
            let queueTitle: String? = argument["queueTitle"] as? String
            player.seQueueTitle(queueTitle)
            player.setQueue(queue: playList)
            player.playFromMediaId(mediaId)
            break
        case "seekTo":
            player.seekTo(call.arguments as! Int)
            break
        case "setShuffleMode":
            player.setShuffleMode(call.arguments as! Int)
            break
        case "setRepeatMode":
            player.setRepeatMode(call.arguments as! Int)
            break
                // media controller
        case "getPlaybackState":
            //TODO
            break
        case "getQueue":
            result(player.getQueue().map {
                $0.data
            })
            return
        case "getQueueTitle":
            result(player.getQueueTitle())
            return
        case "getPlaybackInfo":
            result(player.getPlaybackInfo())
            return
        case "getRepeatMode":
            result(player.getRepeatMode())
            return
        case "getShuffleMode":
            result(player.getShuffleMode())
            return
        case "addQueueItem":
            let index: Int = (call.arguments as! Dictionary)["index"] ?? 0
            let item: MediaMetadata? = (call.arguments as! Dictionary<String, Any>)["item"].map { item in
                MediaMetadata(data: item as! [String: Any])
            }
            if let insert = item {
                player.addQueueItem(metadata: insert, index: index)
            }
            break
        case "removeQueueItem":
            return
        default:
            result(FlutterMethodNotImplemented)
            return
        }
        result(nil)
    }


    public func applicationWillEnterForeground(_ application: UIApplication) {

    }

    public func applicationDidEnterBackground(_ application: UIApplication) {

    }


}

