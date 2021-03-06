//
//  ContentView.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 29/05/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pokemon!")
                .font(.title)
            HStack {
                Text("Pokemon description")
                    .font(.subheadline)
                Spacer()
                Text("Next important thing")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
