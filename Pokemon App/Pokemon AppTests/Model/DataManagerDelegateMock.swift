
import Foundation
import Pokemon_App

class DataManagerDelegateMock: DataManagerDelegate {
    var initialInfo: InitialPokedexInfo?
    var pokemons = [PokemonModel]()
    var dataManager: DataManagerProtocol = DataManager()
    
    init() {
        dataManager.delegate = self
    }
    
    func handlePokemon(pokemon: PokemonModel) {
        pokemons.append(pokemon)
    }
    
    func handleInitialInfo(info: InitialPokedexInfo){
        print("Fetched Info")
        initialInfo = info
    }
}
