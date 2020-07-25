//
//  DataStore.swift
//  DesignCode
//
//  Created by Jack Wong on 7/24/20.
//

import SwiftUI
import Combine

class DataStore: ObservableObject{
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}

