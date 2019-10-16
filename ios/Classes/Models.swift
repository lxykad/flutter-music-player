//
// Created by BoYan01 on 2019/10/16.
//

import Foundation


struct MediaDescription: Codable {
    let mediaId: String
    var title: String
    var subtitle: String
    var description: String
    var iconUri: URL
    var extras: [String: AnyObject]
    var mediaUri: URL

    init(from decoder: Decoder) throws {

    }

    func encode(to encoder: Encoder) throws {

    }
}

struct MediaMetadata: Codable {
    let title: String
    let artist: String
    let duration: Int
    let album: String
    let writer: String
    let composer: String
    let author: String
    let compilation: String
    let date: String
    let year: Int
    let genre: String
    let trackNumber: Int
    let numTracks: Int
    let discNumber: Int
    let albumArtist: String
    let artUri: String
    let albumArtUri: String
    let userRating: AnyObject
    let rating: AnyObject
    let displayTitle: String?
    let displaySubtitle: String
    let displayDescription: String
    let displayIconUri: String
    let mediaId: String
    let btFolderType: Int
    let mediaUri: String?
    let advertisement: Int

    private var description: MediaDescription? = nil

    init(from decoder: Decoder) throws {

    }

    func encode(to encoder: Encoder) throws {
    }
}

extension MediaMetadata {

    func getDescription() -> MediaDescription {
        if (description != nil) {
            return description!;
        }
        var text = Array<String?>(repeating: nil, count: 3)
        if displayTitle?.isEmpty != false {
            // use whatever fields we can
            var textIndex = 0;
            var keyIndex = 0;
            let description: [String?] = [title, artist, album, albumArtist, writer, author, composer]
            while (textIndex < text.count && keyIndex < description.count) {
                let next = description[keyIndex]
                keyIndex += 1
                if (next?.isEmpty != false) {
                    text[textIndex] = next;
                    textIndex += 1
                }
            }
        } else {
            text[0] = displayTitle
            text[1] = displaySubtitle
            text[2] = displayDescription
        }

        var mediaUri: URL?;
        if (self.mediaUri != nil) {
            mediaUri = URL(string: self.mediaUri!)
        }
    }

}