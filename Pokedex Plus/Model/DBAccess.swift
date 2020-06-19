//
//  DBAccess.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 17/06/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import Foundation
import SQLite

class DBAccess: ObservableObject {
    
    init(db: Connection, table: Table, expression: Expression<Int>) {
        self.db = db
        self.table = table
        self.id = expression
    }
    
    let db: Connection
    let table: Table
    let id: Expression<Int>
    
    func isPokemonFavourite(id: Int) -> Bool {
        var counter = 0
        let curretId = table.filter(self.id == id)
        do {
            for _ in try db.prepare(curretId) {
                counter += 1
            }
        } catch {
            print(error)
        }
        return counter > 0
    }
    
    func doPokemonFavourite(id: Int) {
        do {
            let insert = table.insert(self.id <- id)
            try db.run(insert)
        } catch {
            print(error)
        }
    }
    
    func undoPokemonFavourite(id: Int) {
        do {
            let curretId = table.filter(self.id == id)
            try db.run(curretId.delete())
        } catch {
            print(error)
        }
    }
    
    func getAllPokemons() -> [Int] {
        var ids = [Int]()
        do {
            for pokeId in try db.prepare(self.table) {
                ids.append(pokeId[id])
            }
        } catch {
            print(error)
        }
        return ids
    }
    
}
