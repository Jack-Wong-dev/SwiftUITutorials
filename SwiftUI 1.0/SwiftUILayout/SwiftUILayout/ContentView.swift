//
//  ContentView.swift
//  SwiftUILayout
//
//  Created by Jack Wong on 4/27/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Image("Cake VStack")
                .resizable()
                .scaledToFit()
            Text("Hello, \nWorld\n!")
            Image("Pancake VStack")
                .resizable()
                .frame(width: 100.0, height: 100.0)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
