//
//  AppSideBarNavigation.swift
//  iOS14Practice
//
//  Created by Jack Wong on 7/30/20.
//

import SwiftUI

struct AppSideBarNavigation: View {
    
    enum NavigationItem {
        case list
        case grid
    }
    
    @State private var selection: Set<NavigationItem> = [.list]
    
    var body: some View {
        NavigationView {
            sidebar
            Text("Select Content Style")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    var sidebar: some View {
        List(selection: $selection) {
            NavigationLink(destination: UnsplashedPhotoView()) {
                Label("List", systemImage: "list.bullet")
                    .accessibility(label: Text("List Layout"))
                    .tag(NavigationItem.list)
            }
            NavigationLink(destination: ImageGridView()) {
                Label("Grid", systemImage: "rectangle.3.offgrid")
                    .accessibility(label: Text("Grid Layout"))
                    .tag(NavigationItem.grid)
            }
        }
        .navigationTitle("Content Options")
        .listStyle(SidebarListStyle())
    }
}

struct AppSideBarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSideBarNavigation()
    }
}
