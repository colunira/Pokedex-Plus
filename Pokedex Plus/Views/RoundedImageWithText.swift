//
//  RoundedImageWithText.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 29/05/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI

struct RoundedImageWithText: View {
    let image: Image
    let text: String
    let color: Color
    var body: some View {
        VStack {
            image
                .resizable()
                .background(Color.white)
                .frame(width: 300.0, height: 300.0)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            Text(text)
                .foregroundColor(Color.white)
                .fontWeight(.heavy)
                .shadow(radius: 6)
                .font(Font.system(size: 36, design: .rounded))
                .padding(.vertical, -80)
        
                
        }
        .padding(.vertical, 0)
        
    }
}

struct RoundedImageWithText_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImageWithText(image: Image("background"), text: "Kento", color: Color.green)
    }
}
