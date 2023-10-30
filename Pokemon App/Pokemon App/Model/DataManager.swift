
import Foundation

struct DataManager: DataManagerProtocol {
    weak var delegate: DataManagerDelegate?
    let cache = NSCache<NSString, StructWrapper<PokemonModel>>()
    
    func fetchPokemons(url: String) {
        if let url = URL(string: url) {
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
    
    func fetchPokemon(name: String, url: String) {
        if let cachedPokemon = cache.object(forKey: name as NSString) {
            print("Pokemon Handled from CACHE \(cachedPokemon.name)")
            DispatchQueue.main.async {
                delegate?.handlePokemon(pokemon: cachedPokemon.value)
            }
            return
        }
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let pokemon = try decoder.decode(PokemonModel.self, from: safeData)
                            print("Pokemon Handled in fetch \(pokemon.name)")
                            DispatchQueue.main.async {
                                let wrapper = StructWrapper(pokemon, name: pokemon.name)
                                self.cache.setObject(wrapper, forKey: wrapper.name as NSString)
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

protocol DataManagerDelegate: AnyObject {
    func handlePokemon(pokemon: PokemonModel)
    func handleInitialInfo(info: InitialPokedexInfo)
}

protocol DataManagerProtocol {
    var delegate: DataManagerDelegate? { get set }
    var cache: NSCache<NSString, StructWrapper<PokemonModel>> { get }
    func fetchPokemons(url: String)
    func fetchPokemon(name: String, url: String)
}

class StructWrapper<T>: NSObject {
    let value: T
    let name: String

    init(_ _struct: T, name: String) {
        value = _struct
        self.name = name
    }
}
