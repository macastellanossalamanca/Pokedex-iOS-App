
import Foundation

class PokemonViewModel: ObservableObject, DataManagerDelegate {
    
    var initialInfo: InitialPokedexInfo?
    @Published var pokemons = [PokemonModel]()
    var dataManager: DataManagerProtocol = DataManager()
    
    init() {
        dataManager.delegate = self
        dataManager.fetchPokemons()
    }
    
    func handlePokemon(pokemon: PokemonModel) {
        pokemons.append(pokemon)
    }
    
    func handleInitialInfo(info: InitialPokedexInfo) {
        initialInfo = info
        initialInfo?.results.forEach { pokemon in
            dataManager.fetchPokemon(url: pokemon.url)
        }
    }
}
