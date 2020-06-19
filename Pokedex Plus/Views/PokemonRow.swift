//
//  PokemonRowView.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 29/05/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI
import URLImage

struct PokemonRow: View {
    var pokemon: Pokemon
    var body: some View {
        HStack {
            
            URLImage(URL(string: pokemon.sprites.frontDefault)!, content: {
                $0.image
            })
            
            VStack(alignment: .leading) {
                HStack {
                    Text(pokemon.name.capitalized.replacingOccurrences(of: "-", with: " "))
                    .font(.title)
                    Spacer()
                    if (pokemon.isFavourite ?? false) {
                        Image("star").resizable()
                            .frame(width: 25, height: 25)
                        .shadow(radius: 1)
                    }
                }
                
                HStack {
                    Text(pokemon.types[0].type.name.capitalized)
                    .foregroundColor(Color(pokemon.types[0].type.name))
                    if (pokemon.types.capacity > 1){
                        Spacer()
                        Text(pokemon.types[1].type.name.capitalized)
                            .foregroundColor(Color(pokemon.types[1].type.name))
                    }
                    
                }
            }
            .padding()
            
            
            
        }
        .padding(.horizontal)
    }
}

struct PokemonRow_Previews: PreviewProvider {
 static var previews: some View {
 Group {
    PokemonRow(pokemon: ViewModel.getStaticPokemon() )
    PokemonRow(pokemon: ViewModel.getStaticPokemon() )
 }
 .previewLayout(.fixed(width: 300, height: 70))
 
 }
 }
