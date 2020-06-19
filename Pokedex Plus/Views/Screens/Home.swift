//
//  Home.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 29/05/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    var items: [MenuItem] = [
        MenuItem(id: 1, name: "Kanto", color: "lightblue", image: "kanto"),
        MenuItem(id: 2, name: "Johto", color: "lightblue", image: "johto"),
        MenuItem(id: 3, name: "Hoenn", color: "lightblue", image: "hoenn"),
        MenuItem(id: 4, name: "Sinnoh", color: "lightblue", image: "sinnoh"),
        MenuItem(id: 5, name: "Unova", color: "lightblue", image: "unova"),
        MenuItem(id: 6, name: "Kalos", color: "lightblue", image: "kalos"),
    ]
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading) {
                    Text("Menu")
                        .font(.headline)
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            
                            NavigationLink(destination: PokemonList(genId: 0, genName: "Favs")) {
                                RoundedImageWithText(image: Image("favs"), text: "Favs", color: Color.white)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: Camera()) {
                                RoundedImageWithText(image: Image("photo"), text: "Photo", color: Color.white)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    Text("Generations")
                        .font(.headline)
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(items) { item in
                                NavigationLink(destination: PokemonList(genId: item.id, genName: item.name)) {
                                    RoundedImageWithText(image: Image(item.image), text: item.name, color: Color(item.color))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
                
            .navigationBarTitle(Text("Pokédex Plus"))
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
