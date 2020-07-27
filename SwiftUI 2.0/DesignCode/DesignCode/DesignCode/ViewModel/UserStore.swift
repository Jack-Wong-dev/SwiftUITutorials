//
//  UserStore.swift
//  DesignCode
//
//  Created by Jack Wong on 7/26/20.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    //"Cookies"
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(isLogged, forKey: "isLogged")
        }
    }
 
    @Published var showLogin = false
}
