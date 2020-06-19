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
    
    
    var body: some View {
            List {
                if (self.genId != 0) {
                    Toggle(isOn: $viewModel.showFavouritesOnly) {
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
    }
}



struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList(genId: 1, genName: "TestGen")
        .environmentObject(ViewModel())
    }
}
