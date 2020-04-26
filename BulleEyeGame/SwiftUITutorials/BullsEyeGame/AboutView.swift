//
//  AboutView.swift
//  SwiftUITutorials
//
//  Created by Jack Wong on 4/26/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct AboutHeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", size: 30))
                .padding([.top,.bottom], 20)
        }
    }
    
    struct AboutBodyStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", size: 16))
                .padding([.leading,.trailing], 60)
                .padding(.bottom, 20)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(AboutHeadingStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider")
                    .modifier(AboutBodyStyle()).lineLimit(nil)
                Text("Your goal is to place the slider as close as possible to the target value.  The closer you are, the more points you score").modifier(AboutBodyStyle()).lineLimit(nil)
                Text("Enjoy!").modifier(AboutBodyStyle())
            }
        .background(beige)
        }
    .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
