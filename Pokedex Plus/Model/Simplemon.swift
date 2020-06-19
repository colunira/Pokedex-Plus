//
//  Simplemon.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 15/06/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import Foundation
class Simplemon: Decodable {
    var name: String
    public var description: String { return "\(name)"}
}
