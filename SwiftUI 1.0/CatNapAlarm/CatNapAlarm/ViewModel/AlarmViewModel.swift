//
//  AlarmViewModel.swift
//  CatNapAlarm
//
//  Created by Jack Wong on 4/28/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI
import Combine


class AlarmViewModel: ObservableObject {
    
    @Published var alarms: [Alarm]
    
    func add(_ alarm: Alarm) {
        alarms.append(alarm)
    }
    
    init(alarms: [Alarm]) {
        self.alarms = alarms
    }
}


