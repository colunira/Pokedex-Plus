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
    @State var pokemon: Pokemon
    @State var showAbilities: Bool = true
    @State var showMoves: Bool = false
        
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
                                self.pokemon.isFavourite = false
                            } else {
                                self.viewModel.doPokemonFavourite(id: self.pokemon.id)
                                self.pokemon.isFavourite = true
                            }
                            
                        }) {
                            if self.pokemon.isFavourite! {
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
                
                // Pokemon name & type
                VStack(alignment: .center) {
                    Text(pokemon.name.capitalized.replacingOccurrences(of: "-", with: " "))
                        .font(.title)
                    HStack {
                        Text(self.pokemon.types[0].type.name.capitalized)
                            .foregroundColor(Color(pokemon.types[0].type.name))
                            .font(.headline)
                        if (self.pokemon.types.capacity > 1){
                            Text(self.pokemon.types[1].type.name.capitalized)
                                .font(.headline)
                                .foregroundColor(Color(pokemon.types[1].type.name))
                        }
                    }
                    .padding()
                }
                .padding()
                
                // Stats icons
                HStack {
                    IconImage(image: "heart (2)")
                    Text(pokemon.stats[Pokemon.HP].baseStat.description).font(.subheadline)
                    IconImage(image: "sword (1)")
                    Text(pokemon.stats[Pokemon.ATTACK].baseStat.description).font(.subheadline)
                    IconImage(image: "shield")
                    Text(pokemon.stats[Pokemon.DEFENSE].baseStat.description).font(.subheadline)
                    IconImage(image: "speed (1)")
                    Text(pokemon.stats[Pokemon.SPEED].baseStat.description).font(.subheadline)
                }
                
                // Abilities and Moves
                
                HStack {

                    Button(action: {
                        self.showAbilities.toggle()
                        self.showMoves.toggle()
                    }){
                        HStack {
                            Text("Abilities").font(.headline)
                            Spacer()
                        }
                    }.buttonStyle(GradientButtonStyle(isActive: showAbilities, color: pokemon.types[0].type.name))
                        
                    
                    Button(action: {
                        self.showAbilities.toggle()
                        self.showMoves.toggle()
                    }) {
                        HStack {
                            Text("Moves").font(.headline)
                            Spacer()
                        }
                    }.buttonStyle(GradientButtonStyle(isActive: showMoves, color: pokemon.types[0].type.name))
                    
                } .padding(.top)
                
                
                if (self.showAbilities) {
                    List(pokemon.abilities, id: \.ability.name) { item in
                        Text(item.ability.name.capitalized.replacingOccurrences(of: "-", with: " "))
                    }.frame(height: 200)
                }
                
                
                if (self.showMoves) {
                    List(pokemon.moves, id: \.move.name) { item in
                        Text(item.move.name.capitalized.replacingOccurrences(of: "-", with: " "))
                            .animation(Animation.easeInOut(duration: 3).delay(1))
                    }
                    .frame(height: 200)
                }
                
                Spacer()
                    .navigationBarTitle(Text(pokemon.name.capitalized), displayMode: .inline)
            }
            
        }
    }
}

struct GradientButtonStyle: ButtonStyle {
    var isActive: Bool
    var color: String
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .shadow(radius: isActive ? 2 : 0)
            .background(isActive ? Color(color) : Color("lightgray"))
        
        
    }
}

struct PokemonDetails_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetails(pokemon: ViewModel.getStaticPokemon())
            .environmentObject(ViewModel())
    }
}
