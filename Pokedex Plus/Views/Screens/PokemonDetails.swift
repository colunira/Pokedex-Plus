//
//  PokemonDetailsView.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 29/05/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI
import URLImage

struct PokemonDetails: View {
    @EnvironmentObject var viewModel: ViewModel
    var pokemon: Pokemon
    var colors: [Color] {
        if (pokemon.types.capacity > 1){
            return [Color(pokemon.types[0].type.name), Color(pokemon.types[1].type.name)]
        } else {
            return [Color(pokemon.types[0].type.name), Color.white]
        }
        
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        Button(action: {
                            if (self.pokemon.isFavourite!) {
                                self.viewModel.undoPokemonFavourite(id: self.pokemon.id)
                            } else {
                                self.viewModel.doPokemonFavourite(id: self.pokemon.id)
                            }
                        }) {
                            if pokemon.isFavourite ?? false {
                                Image("star")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .shadow(radius: 10)
                            } else {
                                Image("star unchecked")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.gray)
                                    .padding()
                                    .shadow(radius: 10)
                            }
                            
                        } .buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                }
                .frame(height: 250)
                .background(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .topLeading, endPoint: .bottomTrailing))
                
                URLImage(URL(string: pokemon.sprites.frontDefault)!,placeholder: Image("star"), content: {
                    $0.image
                        .resizable()
                        .background(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 250.0, height: 250.0)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .offset(y: -200)
                        .padding(.bottom, -200)
                })
                
                VStack(alignment: .center) {
                    Text(pokemon.name.capitalized)
                        .font(.title)
                    HStack {
                        Text(self.pokemon.types[0].type.name)
                            .font(.subheadline)
                        if (self.pokemon.types.capacity > 1){
                            Text(self.pokemon.types[1].type.name)
                                .font(.subheadline)
                        }
                    }
                    .padding()
                }
                .padding()
                HStack {
                    IconImage(image: "heart (2)")
                    Text(pokemon.stats[Pokemon.HP].baseStat.description).font(.caption)
                    IconImage(image: "sword (1)")
                    Text(pokemon.stats[Pokemon.ATTACK].baseStat.description).font(.caption)
                    IconImage(image: "shield")
                    Text(pokemon.stats[Pokemon.DEFENSE].baseStat.description).font(.caption)
                    IconImage(image: "speed (1)")
                    Text(pokemon.stats[Pokemon.SPEED].baseStat.description).font(.caption)
                }
                Spacer()
                    .navigationBarTitle(Text(pokemon.name.uppercased()), displayMode: .inline)
            }
            
        }
        //.navigationBarHidden(true)
    }
}

struct PokemonDetails_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetails(pokemon: ViewModel.getStaticPokemon())
            .environmentObject(ViewModel())
    }
}
