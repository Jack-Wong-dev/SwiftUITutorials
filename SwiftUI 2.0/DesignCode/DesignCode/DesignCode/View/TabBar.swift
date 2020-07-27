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
            CourseList().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Courses")
            }
        }
//        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar()
                .environmentObject(UserStore())
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 11 Pro Max")
            TabBar()
                .environmentObject(UserStore())
                .previewDevice("iPhone 11 Pro Max")
        }
    }
}
