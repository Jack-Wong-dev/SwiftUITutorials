//
//  Arrays+Identifiable.swift
//  memorize
//
//  Created by Jack Wong on 6/8/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
