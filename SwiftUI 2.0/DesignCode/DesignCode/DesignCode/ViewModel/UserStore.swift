//
//  UserStore.swift
//  DesignCode
//
//  Created by Jack Wong on 7/26/20.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var isLogged = false
    @Published var showLogin = false
}
