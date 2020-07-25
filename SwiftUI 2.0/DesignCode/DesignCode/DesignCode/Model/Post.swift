//
//  Model.swift
//  DesignCode
//
//  Created by Jack Wong on 7/24/20.
//

import Foundation

struct Post: Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
}

