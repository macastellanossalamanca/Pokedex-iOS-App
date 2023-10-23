
import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    @State var searchText: String = ""
    
    var pokemons: [PokemonModel] {
        if searchText.isEmpty {
            return viewModel.pokemons
        } else {
            return viewModel.pokemons.filter{
                var abilityNames = [String]()
                var typeNames = [String]()
                $0.types.forEach { type in
                    typeNames.append(type.type.name.lowercased())
                }
                $0.abilities.forEach { ability in
                    abilityNames.append(ability.ability.name.lowercased())
                }
                return
                $0.name.lowercased().contains(searchText.lowercased()) ||
                typeNames.contains(searchText.lowercased()) ||
                abilityNames.contains(searchText.lowercased())
            }
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
                prompt: "Filter by name, type or ability")
            HStack{
                if (viewModel.initialInfo?.previous) != nil {
                    Button("Previous") {
                        viewModel.previousPage()
                    }
                    .multilineTextAlignment(.leading)
                }
                if (viewModel.initialInfo?.next) != nil {
                    Button("Next") {
                        viewModel.nextPage()
                    }
                    .multilineTextAlignment(.trailing)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
