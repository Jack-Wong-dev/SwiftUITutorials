//
//  FruitModel.swift
//  Fructus
//
//  Created by Jack Wong on 8/24/20.
//

import SwiftUI

//MARK: - Fruits Data Model

struct Fruit: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var gradientColors: [Color]
    var description: String
    var nutrition: [String]
}
