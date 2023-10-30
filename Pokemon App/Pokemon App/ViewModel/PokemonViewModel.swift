
import Foundation

class PokemonViewModel: ObservableObject, DataManagerDelegate {
    
    var initialInfo: InitialPokedexInfo?
    @Published var pokemons = [PokemonModel]()
    var dataManager: DataManagerProtocol = DataManager()
    var initialURL = "https://pokeapi.co/api/v2/pokemon"
    
    init() {
        dataManager.delegate = self
        dataManager.fetchPokemons(url: initialURL)
    }
    
    func handlePokemon(pokemon: PokemonModel) {
        pokemons.append(pokemon)
    }
    
    func handleInitialInfo(info: InitialPokedexInfo) {
        print("ViewModelLoadingInfo")
        initialInfo = info
        initialInfo?.results.forEach { pokemon in
            dataManager.fetchPokemon(name: pokemon.name, url: pokemon.url)
        }
    }
    
    func nextPage() {
        pokemons = [PokemonModel]()
        if let safeURL = initialInfo?.next {
            dataManager.fetchPokemons(url: safeURL)
        }
    }
    
    func previousPage() {
        pokemons = [PokemonModel]()
        if let safeURL = initialInfo?.previous {
            dataManager.fetchPokemons(url: safeURL)
        }
    }
}
