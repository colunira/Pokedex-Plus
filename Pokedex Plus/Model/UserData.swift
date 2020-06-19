//
//  UserData.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 29/05/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject  {
    @Published var showFavouritesOnly = false
}
