//
//  TabBar.swift
//  DesignCode
//
//  Created by Jack Wong on 7/23/20.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                    Image(systemName: "play.circle.fill")
                    Text("Home")
                }
            ContentView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Certificates")
            }
        }
//        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .previewDevice("iPhone 11 Pro Max")
    }
}
