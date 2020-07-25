//
//  Model.swift
//  DesignCode
//
//  Created by Jack Wong on 7/24/20.
//

import Foundation

struct Post: Codable, Identifiable {
    var id = UUID()
    var title: String
    var body: String
}

