//
//  Camera.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 09/06/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import SwiftUI

struct Camera: View {
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = true
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                GeometryReader { geo in
                    self.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width-20)
                        .shadow(radius: 10)
                        .overlay(Text("Pokédex Plus")
                            .foregroundColor(Color.white)
                            .shadow(radius: 5)
                            .padding()
                            , alignment: .bottomTrailing)
                        .padding(10)
                        
                    
                }
                Spacer()
            }
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image)
            }
        }
    }
    
}

struct Camera_Previews: PreviewProvider {
    static var previews: some View {
        Camera()
    }
}
