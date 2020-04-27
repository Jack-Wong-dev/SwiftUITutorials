//
//  Task.swift
//  TaskList
//
//  Created by Jack Wong on 4/26/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//
import Foundation

struct Task: Identifiable {
    let id = UUID()
    var name: String
    var completed = false
}
