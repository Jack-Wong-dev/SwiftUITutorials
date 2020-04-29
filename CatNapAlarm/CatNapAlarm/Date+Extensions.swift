//
//  Date+Extensions.swift
//  CatNapAlarm
//
//  Created by Jack Wong on 4/28/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import Foundation

extension Date {
    var formatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH-mm a"
        return dateFormatter.string(from: self)
    }
}
