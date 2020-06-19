//
//  Service2.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 16/06/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI
import Combine
import SQLite

final class ViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()
    @Published var showFavouritesOnly = false
    
    
    private var baseURL = "https://pokeapi.co/api/v2/"
    private let session = URLSession.shared
    
    func getFavourites() {
        do {
            let dir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = dir.appendingPathComponent("pokemons").appendingPathExtension("sqlite3")
            let db = try Connection(fileUrl.path)
            let poketable = Table("pokemons")
            let id_e = Expression<Int>("id")
            let dbaccess = DBAccess(db: db, table: poketable, expression: id_e)
            let favs = dbaccess.getAllPokemons()
            for id in favs {
                getPokemonByName(name: id.description)
            }
        }
        catch {
            print(error)
        }
    }
    
    func getGenerationByID(id: Int) {
        let url = URL(string: baseURL + "generation/" + id.description)!
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            do {
                let generation = try JSONDecoder().decode(Generation.self, from: data!)
                generation.pokemons.forEach{ poke in
                    self.getPokemonByName(name: poke.description)
                }
                DispatchQueue.main.async {
                    // update our UI
                }
            }
            catch {
                print("Error decoing: \(error)")
            }
            
        }
        task.resume()
    }
    
    func getPokemonByName(name: String) {
        let url = URL(string: baseURL + "pokemon/" + name)!
        let task = session.dataTask(with: url) { data, res, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = res as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                let aaa = res as? HTTPURLResponse
                print(name)
                print(aaa?.statusCode.description)
                return
            }
            
            do {
                var pokemon = try JSONDecoder().decode(Pokemon.self, from: data!)
                let dir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let fileUrl = dir.appendingPathComponent("pokemons").appendingPathExtension("sqlite3")
                let db = try Connection(fileUrl.path)
                let pokemons = Table("pokemons")
                let id = Expression<Int>("id")
                let dbaccess = DBAccess(db: db, table: pokemons, expression: id)
                let isFav = dbaccess.isPokemonFavourite(id: pokemon.id)
                    pokemon.isFavourite = isFav
                DispatchQueue.main.async {
                    // update our UI
                    self.pokemons.append(pokemon)
                    self.pokemons.sort(by: {$0.id < $1.id})
                }
            }
            catch {
                print("Error decoing: \(error)")
            }
            
        }
        task.resume()
    }
    
    func doPokemonFavourite(id: Int) {
        do {
            let dir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = dir.appendingPathComponent("pokemons").appendingPathExtension("sqlite3")
            let db = try Connection(fileUrl.path)
            let pokemons = Table("pokemons")
            let id_e = Expression<Int>("id")
            let dbaccess = DBAccess(db: db, table: pokemons, expression: id_e)
            dbaccess.doPokemonFavourite(id: id)
        }
        catch {
            print(error)
        }
    }
    
    func undoPokemonFavourite(id: Int) {
        do {
            let dir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = dir.appendingPathComponent("pokemons").appendingPathExtension("sqlite3")
            let db = try Connection(fileUrl.path)
            let pokemons = Table("pokemons")
            let id_e = Expression<Int>("id")
            let dbaccess = DBAccess(db: db, table: pokemons, expression: id_e)
            dbaccess.undoPokemonFavourite(id: id)
        }
        catch {
            print(error)
        }
    }
    
    static func getStaticPokemon() -> Pokemon {
        let species = Species(name: "specii")
        let ability = Ability(ability: species)
        let move = Move(move: species)
        let sprites = Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png")
        let stat = Stat(baseStat: 0, stat: species)
        let typeElement = TypeElement(slot: 0, type: species)
        let pokemon = Pokemon(id: 12, name: "Kujozaur", abilities: [ability], moves: [move], sprites: sprites, stats: [stat,stat,stat,stat,stat,stat], types: [typeElement], isFavourite: true)
        return pokemon
    }
    
    static func getStaticPokemonList() -> [Pokemon] {
        let species = Species(name: "specii")
        let ability = Ability(ability: species)
        let move = Move(move: species)
        let sprites = Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png")
        let stat = Stat(baseStat: 0, stat: species)
        let typeElement = TypeElement(slot: 0, type: species)
        let pokemon = Pokemon(id: 12, name: "Kujozaur", abilities: [ability], moves: [move], sprites: sprites, stats: [stat,stat,stat,stat,stat,stat], types: [typeElement], isFavourite: true)
        return [pokemon, pokemon]
    }
}
