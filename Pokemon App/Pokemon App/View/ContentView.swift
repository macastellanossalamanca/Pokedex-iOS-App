
import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    @State var searchText: String = ""
    
    var pokemons: [PokemonModel] {
        if searchText.isEmpty {
            return viewModel.pokemons
        } else {
            return viewModel.pokemons.filter{$0.name.lowercased().contains(searchText.lowercased())}
        }
    }
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(pokemons, id: \.id) { pokemon in
                    NavigationLink(destination: DetailedView(pokemon: pokemon)) {
                        HStack(alignment: .center) {
                            VStack{
                                KFImage(URL(string: pokemon.sprites.front_default)!);
                                Text(pokemon.name.capitalized).bold().italic()
                            }
                            .frame(maxWidth: .infinity);
                            VStack{
                                ForEach(pokemon.types, id: \.type.name) { type in
                                    Text(type.type.name.capitalized).bold().italic()
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                    }
                }
                .navigationTitle("PokeDex")
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Ingresa el nombre del Pokemon")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
