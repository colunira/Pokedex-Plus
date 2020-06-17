//
//  Generation.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 15/06/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import Foundation

struct Generation:Decodable {
    var pokemons:[Simplemon]
    
    enum CodingKeys: String, CodingKey {
        case pokemons = "pokemon_species"
    }
    
    public var description: String {
        var rrr: String = ""
        pokemons.forEach{ pokemon in
            rrr += "\(pokemon.name) "
        }
        return rrr
    }

}
