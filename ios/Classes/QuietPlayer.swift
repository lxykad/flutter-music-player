//
// Created by FF on 2019/10/17.
//

import Foundation
import AVFoundation

/// MusicPlayer
public class QuietPlayer {

    private var player: AVAudioPlayer?

    var playList: PlayList = PlayList(queue: [])

    func play() {
        if player == nil {
            return
        }
        if(player!.isPlaying){

        }
        player?.play()

        player?.prepareToPlay()

        let session = AVAudioSession.sharedInstance()
        try! session.setActive(true)



    }

    func playFromMediaId(mediaId: String) {

    }

    private func preformPlay(metadata: MediaMetadata) {
        self.player?.stop()
        let newPlayer = try! AVAudioPlayer(contentsOf: URL(string: metadata.mediaUri!)!);
        newPlayer.play()
        self.player = newPlayer
    }

}


class PlayList {

    init(queue: [MediaMetadata]) {
        self.queue = queue
    }

    /// The music could be play
    var queue: [MediaMetadata]

    var playMode: Int = 0

    func addQueueItem(_ metadata: MediaMetadata, index: Int = -1) {
        if (index < 0 || index >= queue.count) {
            queue.append(metadata)
        } else {
            queue.insert(metadata, at: index)
        }
    }

    func remoteQueueItem(index: Int) {
        queue.remove(at: index)
    }

    func getNext(anchor: MediaMetadata?) -> MediaMetadata? {
        if queue.isEmpty {
            return nil
        }

        if anchor == nil {
            return queue.first
        }
        let next = queue.lastIndex {
            anchor! == $0
        }
        if (next == nil) {
            return queue.first
        }
        //TODO
        return nil
    }

    func getPrevious(anchor: MediaMetadata?) -> MediaMetadata? {
        return nil
    }

}