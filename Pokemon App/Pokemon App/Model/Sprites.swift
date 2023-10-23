
import Foundation

struct Sprites: Decodable {
    var front_default: String
    var other: SpriteDetails
}

struct SpriteDetails: Decodable {
    var artwork: FullImage
    enum CodingKeys: String, CodingKey {
            case artwork = "official-artwork"
    }
}

struct FullImage: Decodable {
    var front_default: String
}
