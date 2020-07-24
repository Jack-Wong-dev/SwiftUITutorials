//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Jack Wong on 7/23/20.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
