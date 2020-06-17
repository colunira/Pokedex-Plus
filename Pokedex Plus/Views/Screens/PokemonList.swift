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
    // @ObservedObject var viewModel = ViewModel()
    var genId: Int
    
    //TODO: IF FAV VIEW IS OPENED
    //THERE IS NO NEED FOR FAV_TOOGLE :)
    
    var body: some View {
            List {
                Toggle(isOn: $viewModel.showFavouritesOnly) {
                    Text("Favourites only")
                        .padding(.horizontal)
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
            .navigationBarTitle(Text("Pokémons"), displayMode: .inline)
        
    }
    
    func loadData() {
        viewModel.pokemons = [Pokemon]()
        viewModel.getGenerationByID(id: self.genId)
    }
}



/*struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList(pokemons: Pokemon.getExamplePokemons())
        .environmentObject(UserData())
        
    }
}*/
