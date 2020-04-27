//
//  Binding.swift
//  TaskList
//
//  Created by Jack Wong on 4/26/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI

public extension Binding where Value: CaseIterable & Equatable {
    var caseIndex: Binding<Value.AllCases.Index> {
        Binding<Value.AllCases.Index>(
            get: { Value.allCases.firstIndex(of: self.wrappedValue)! },
            set: { self.wrappedValue = Value.allCases[$0] }
        )
    }
}
