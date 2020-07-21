//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Jack Wong on 7/4/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    var body: some View {
        Group{
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}
