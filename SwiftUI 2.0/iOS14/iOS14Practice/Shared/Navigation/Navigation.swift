//
//  Navigation.swift
//  iOS14Practice
//
//  Created by Jack Wong on 7/30/20.
//

import SwiftUI

struct Navigation: View {
 
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    
    @ViewBuilder
    var body: some View {
       
        if horizontalSizeClass == .compact {
            AppTabNavigation()
        }else {
            AppSideBarNavigation()
        }
 
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
