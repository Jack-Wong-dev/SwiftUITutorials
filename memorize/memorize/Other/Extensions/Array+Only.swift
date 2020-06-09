//
//  Array+Only.swift
//  memorize
//
//  Created by Jack Wong on 6/8/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
