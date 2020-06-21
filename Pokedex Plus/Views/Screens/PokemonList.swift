//
//  PokemonListView.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 29/05/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    @EnvironmentObject var viewModel: ViewModel
    var genId: Int
    var genName: String
    
    //    @State var showLoading = true
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .center) {
                
                VStack {
                    Text("Loading...")
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .transition(.slide)
                    .opacity(self.viewModel.isLoading ? 1 : 0)
                
                
                VStack {
                    List {
                        if (self.genId != 0) {
                            Toggle(isOn: self.$viewModel.showFavouritesOnly) {
                                Text("Favourites only")
                                    .padding(.horizontal)
                            }
                        }
                        ForEach(self.viewModel.pokemons) { pokemon in
                            if !self.viewModel.showFavouritesOnly || pokemon.isFavourite ?? false {
                                NavigationLink(destination: PokemonDetails(pokemon: pokemon)) {
                                    PokemonRow(pokemon: pokemon)
                                }
                            }
                        }
                    }
                }
                .opacity(self.viewModel.isLoading ? 0 : 1)
                
            }
        }
            .onAppear(perform: loadData)
            .onDisappear(perform: cleanData)
            .navigationBarTitle(Text(self.genName), displayMode: .inline)
            
        }
        
        func loadData() {
            if (self.genId == 0) {
                viewModel.getFavourites()
            } else {
                viewModel.getGenerationByID(id: self.genId)
            }
        }
        
        func cleanData() {
            viewModel.pokemons = [Pokemon]()
            viewModel.isLoading = true
        }
    }
    
    
    struct PokemonList_Previews: PreviewProvider {
        static var previews: some View {
            PokemonList(genId: 1, genName: "TestGen")
                .environmentObject(ViewModel())
        }
}
