//
//  DesignCodeApp.swift
//  DesignCode
//
//  Created by Jack Wong on 7/21/20.
//

import SwiftUI
import Firebase

@main
struct DesignCodeApp: App {
    var body: some Scene {
        FirebaseApp.configure()
        return WindowGroup {
            Home().environmentObject(UserStore())
        }
    }
}
