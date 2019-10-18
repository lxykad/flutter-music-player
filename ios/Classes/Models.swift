//
// Created by BoYan01 on 2019/10/16.
//

import Foundation


struct MediaDescription: Codable {
    let mediaId: String
    let title: String?
    let subtitle: String?
    let description: String?
    var iconUri: URL?
//    var extras: [String: AnyObject]
    var mediaUri: URL?
}

class MediaMetadata: Equatable, CustomStringConvertible {

    static func ==(lhs: MediaMetadata, rhs: MediaMetadata) -> Bool {
        lhs.mediaId == rhs.mediaId
    }

    let data: [String: Any]

    private var mediaDescription: MediaDescription {
        var text = Array<String?>(repeating: nil, count: 3)
        if displayTitle?.isEmpty != false {
            // use whatever fields we can
            var textIndex = 0;
            var keyIndex = 0;
            let description: [String?] = [title, artist, album, albumArtist, writer, author, composer]
            while (textIndex < text.count && keyIndex < description.count) {
                let next = description[keyIndex]
                keyIndex += 1
                if (next != nil && !next!.isEmpty) {
                    text[textIndex] = next;
                    textIndex += 1
                }
            }
        } else {
            text[0] = displayTitle
            text[1] = displaySubtitle
            text[2] = displayDescription
        }

        var iconUri: URL?
        let iconUrl = [displayIconUri, artUri, albumArtUri].first {
            $0 != nil && !$0!.isEmpty
        } ?? nil
        if let url = iconUrl {
            iconUri = URL(string: url)
        }

        //TODO extra data

        let mediaUrl = self.mediaUri.map {
            URL(string: $0)
        } ?? nil
        return MediaDescription(
                mediaId: mediaId,
                title: text[0],
                subtitle: text[1], description: text[2],
                iconUri: iconUri,
                mediaUri: mediaUrl)
    }


    init(data: [String: Any]) {
        self.data = data

    }

    var title: String? {
        data["title"] as? String
    }

    var artist: String? {
        data["artist"] as? String
    }

    var duration: Int? {
        data["duration"] as? Int
    }

    var album: String? {
        data["album"] as? String
    }
    var writer: String? {
        data["writer"] as? String
    }
    var composer: String? {
        data["composer"] as? String
    }
    var author: String? {
        data["author"] as? String
    }
    var compilation: String? {
        data["compilation"] as? String
    }
    var date: String? {
        data["date"] as? String
    }
    var year: Int? {
        data["year"] as? Int
    }
    var genre: String? {
        data["genre"] as? String
    }
    var trackNumber: Int? {
        data["trackNumber"] as? Int
    }
    var numTracks: Int? {
        data["numTracks"] as? Int
    }
    var discNumber: Int? {
        data["discNumber"] as? Int
    }
    var albumArtist: String? {
        data["albumArtist"] as? String
    }
    var artUri: String? {
        data["artUri"] as? String
    }
    var albumArtUri: String? {
        data["albumArtUri"] as? String
    }
//    let userRating: AnyObject
//    let rating: AnyObject

    var displayTitle: String? {
        data["displayTitle"] as? String
    }
    var displaySubtitle: String? {
        data["displaySubtitle"] as? String
    }
    var displayDescription: String? {
        data["displayDescription"] as? String
    }
    var displayIconUri: String? {
        data["displayIconUri"] as? String
    }
    var mediaId: String {
        data["mediaId"] as! String
    }
    var btFolderType: Int? {
        data["btFolderType"] as? Int
    }
    var mediaUri: String? {
        data["mediaUri"] as? String
    }
    var advertisement: Int? {
        data["advertisement"] as? Int
    }
    var downloadStatus: Int? {
        data["downloadStatus"] as? Int
    }
    var description: String {
        "MediaMetadata(data: \(data))"
    }
}

extension MediaMetadata {

    /// Get [MediaMetadata] description
    func getDescription() -> MediaDescription {
        mediaDescription
    }

}
