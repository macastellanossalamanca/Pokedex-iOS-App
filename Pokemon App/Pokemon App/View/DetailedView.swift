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
    var body: some View {
        if let safePokemon = pokemon {
            VStack{
                KFImage(URL(string: safePokemon.sprites.front_default)!);
                Text(safePokemon.name.capitalized).bold().italic().font(.title)
                HStack{
                    VStack{
                        Text("Types").bold().font(.title2).foregroundColor(Color.indigo);
                        ForEach(safePokemon.types, id: \.type.name) { type in
                            Text(type.type.name.capitalized).italic()
                        }
                    }
                    .frame(maxWidth: .infinity);
                    VStack{
                        Text("Abilities").bold().font(.title2).foregroundColor(Color.indigo);
                        ForEach(safePokemon.abilities, id: \.ability.name) { ability in
                            Text(ability.ability.name.capitalized).italic()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity);
            
            List {
                HStack(alignment: .center){
                    Spacer();
                    Text("Moves").bold().font(.title).multilineTextAlignment(.center).foregroundColor(Color.indigo);
                    Spacer()
                };
                ForEach(safePokemon.moves, id: \.move.name) { move in
                    HStack(alignment: .center){
                        Spacer();
                        Text(move.move.name.capitalized);
                        Spacer()
                    }
                }
            }
            .navigationTitle("Pokemon Info")
        }
    }
}


struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView()
    }
}
