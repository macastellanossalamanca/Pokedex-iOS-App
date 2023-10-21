
import Foundation

struct PokemonModel: Decodable {
    var name: String
    var abilities: [AbilitieInfo]
    var moves: [MoveInfo]
    var types: [TypeInfo]
}

struct PokemonInfo: Decodable {
    var name: String
    var url: String
}

