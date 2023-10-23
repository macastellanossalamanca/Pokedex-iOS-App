
import Foundation

struct PokemonModel: Decodable {
    var id: Int
    var name: String
    var abilities: [AbilityInfo]
    var moves: [MoveInfo]
    var types: [TypeInfo] 
    var sprites: Sprites
}

struct PokemonInfo: Decodable {
    var name: String
    var url: String
}

struct InitialPokedexInfo: Decodable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [PokemonInfo]
}

