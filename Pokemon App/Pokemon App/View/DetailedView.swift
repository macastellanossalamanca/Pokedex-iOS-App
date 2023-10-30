//
//  DetailedView.swift
//  Pokemon App
//
//  Created by Sandra Salamanca on 21/10/23.
//

import SwiftUI
import Kingfisher

struct DetailedView: View {
    @State var pokemon: PokemonModel?
    @State var color: Color?
    var body: some View {
        if let safePokemon = pokemon, let safeColor = color {
            VStack{
                KFImage(URL(string: safePokemon.sprites.other.artwork.front_default)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(safeColor);
                Text(safePokemon.name.capitalized).bold().italic().font(.title).foregroundColor(Color.black)
                HStack{
                    VStack{
                        Text("Types").bold().font(.title2).foregroundColor(Color.black);
                        ForEach(safePokemon.types, id: \.type.name) { type in
                            Text(type.type.name.capitalized).italic()
                        }
                    }
                    .frame(maxWidth: .infinity);
                    VStack{
                        Text("Abilities").bold().font(.title2).foregroundColor(Color.black);
                        ForEach(safePokemon.abilities, id: \.ability.name) { ability in
                            Text(ability.ability.name.capitalized).italic()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }.foregroundColor(safeColor)
            .frame(maxWidth: .infinity);
            List {
                HStack(alignment: .center){
                    Spacer();
                    Text("Moves").bold().font(.title).multilineTextAlignment(.center).foregroundColor(Color.black);
                    Spacer()
                };
                ForEach(safePokemon.moves, id: \.move.name) { move in
                    HStack(alignment: .center){
                        Spacer();
                        Text(move.move.name.capitalized);
                        Spacer()
                    }
                }
            }.foregroundColor(safeColor)
            .navigationTitle("Pokemon Info")
        }
    }
}


struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView()
    }
}
