//
//  TaskPriority.swift
//  TaskList
//
//  Created by Jack Wong on 4/26/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import Foundation

extension Task {
    enum Priority: String, CaseIterable {
        case no, low, medium, high
    }
}
