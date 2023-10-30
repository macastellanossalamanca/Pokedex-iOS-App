
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
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100)),GridItem(.adaptive(minimum: 100))], content: {
                    ForEach(pokemons, id: \.id) { pokemon in
                        let color: Color = getTypeColor(type: pokemon.types.first?.type.name ?? "")
                        NavigationLink(destination: DetailedView(pokemon: pokemon, color: color)) {
                            VStack(alignment: .center) {
                                HStack{
                                    Text(pokemon.name.capitalized)
                                        .foregroundColor(.white);
                                    Spacer()
                                    Text(String(formatId(id: pokemon.id))).foregroundColor(.white)
                                }
                                HStack{
                                    VStack{
                                        ForEach(pokemon.types, id: \.type.name) { type in
                                            Label {
                                                Text(type.type.name.capitalized)
                                                    .foregroundColor(.white)
                                            } icon: {
                                                
                                            }
                                            .padding(EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3))
                                            .background(.black.opacity(0.1))
                                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                                        }
                                    }
                                    .frame(maxWidth: .infinity);
                                    KFImage(URL(string: pokemon.sprites.front_default)!);
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .background(color)
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    }
                })
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(leading:
                                    Image("Logo").resizable()
                .scaledToFit()
            )
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Filter by name, type or ability")
            
            HStack{
                if (viewModel.initialInfo?.previous) != nil {
                    Button("Previous <<") {
                        viewModel.previousPage()
                    }
                }
                Spacer()
                    .frame(width: 90);
                if (viewModel.initialInfo?.next) != nil {
                    Button(">> Next") {
                        viewModel.nextPage()
                    }
                }
            }
        }
    }
}

extension ContentView {
    func formatId(id: Int) -> String {
        var result = ""
        if id < 10 {
            result = "#00\(id)"
        } else if id > 9 && id < 100 {
            result = "#0\(id)"
        } else {
            result = "#\(id)"
        }
        return result
    }
    
    func getTypeColor(type: String) -> Color {
        switch type {
        case "grass":
            return Color.green
        case "fire":
            return Color.orange
        case "water":
            return Color.blue
        case "bug":
            return Color.green.opacity(0.8)
        case "normal":
            return Color.brown.opacity(0.9)
        case "poison":
            return Color.purple
        case "ground":
            return Color.brown
        case "electric":
            return Color.yellow
        case "fairy":
            return Color.pink.opacity(0.5)
        case "rock":
            return Color.gray
        case "psychic":
            return Color.yellow.opacity(0.9)
        case "ghost":
            return Color.purple.opacity(0.7)
        case "fighting":
            return Color.brown.opacity(0.6)
        default:
            return Color.white
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
