//
//  Alarm.swift
//  CatNapAlarm
//
//  Created by Jack Wong on 4/28/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI
import Combine

class Alarm: ObservableObject, Identifiable {
    var id = UUID()
    
    @Published var name: String
    @Published var startTime: Date
    @Published var endTime: Date
    @Published var isActive: Bool
    
    init(name: String, startTime: Date, endTime: Date, isActive: Bool = true) {
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.isActive = isActive
    }
}

