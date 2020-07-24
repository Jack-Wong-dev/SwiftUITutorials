//
//  Course.swift
//  DesignCode
//
//  Created by Jack Wong on 7/24/20.
//

import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: UIImage
    var logo: UIImage
    var color: UIColor
    var show: Bool
}
