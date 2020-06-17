//
//  CircleImage.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 29/05/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI
import URLImage

struct CircleImage: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .background(Color.white)
            .frame(width: 300.0, height: 300.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("Pikachu"))
    }
}
