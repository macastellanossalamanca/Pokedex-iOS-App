
import Foundation

protocol DataManagerDelegate: AnyObject {
    func handlePokemon(pokemon: PokemonModel)
    func handleInitialInfo(info: InitialPokedexInfo)
}

protocol DataManagerProtocol {
    var delegate: DataManagerDelegate? { get set }
    func fetchPokemons()
    func fetchPokemon(url: String)
}

struct DataManager: DataManagerProtocol {
    weak var delegate: DataManagerDelegate?
    
    func fetchPokemons() {
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let initialInfo = try decoder.decode(InitialPokedexInfo.self, from: safeData)
                            DispatchQueue.main.async {
                                delegate?.handleInitialInfo(info: initialInfo)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchPokemon(url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let pokemon = try decoder.decode(PokemonModel.self, from: safeData)
                                print("Pokemon Handled \(pokemon.name)")
                            DispatchQueue.main.async {
                                delegate?.handlePokemon(pokemon: pokemon)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}
