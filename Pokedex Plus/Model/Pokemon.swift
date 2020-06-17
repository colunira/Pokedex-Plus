//
//  Pokemon.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 29/05/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI

extension Pokemon {
    static let HP = 5
    static let SPEED = 0
    static let ATTACK = 4
    static let DEFENSE = 3
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Pokemon.self, from: jsonData)

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable, Identifiable {
    
    let id: Int
    let name: String
    let abilities: [Ability]
    let moves: [Move]
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
    var isFavourite: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, abilities, moves
        case sprites, stats, types, isFavourite
    }
}

// MARK: - Ability
struct Ability: Codable {

    let ability: Species

    enum CodingKeys: String, CodingKey {
        case ability
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String
}

// MARK: - Move
struct Move: Codable {
    let move: Species

    enum CodingKeys: String, CodingKey {
        case move
    }
}

// MARK: - Sprites
struct Sprites: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat: Int
    let stat: Species

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: Species
}
