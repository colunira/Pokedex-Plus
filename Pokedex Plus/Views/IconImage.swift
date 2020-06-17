//
//  IconImage.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 29/05/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI

struct IconImage: View {
    let image: String
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 25, height: 25)
    }
}

struct IconImage_Previews: PreviewProvider {
    static var previews: some View {
        IconImage(image: "background")
    }
}
