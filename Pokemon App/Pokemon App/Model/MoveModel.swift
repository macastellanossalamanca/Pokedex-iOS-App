
import Foundation

struct MoveInfo: Decodable {
    var move: MoveModel
}

struct MoveModel: Decodable {
    var name: String
    var url: String
}
