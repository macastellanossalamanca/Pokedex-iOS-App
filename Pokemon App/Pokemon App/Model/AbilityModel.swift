
import Foundation

struct AbilityInfo: Decodable {
    var ability: AbilityModel
}

struct AbilityModel: Decodable {
    var name: String
    var url: String
}
