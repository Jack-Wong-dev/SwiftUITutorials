//
//  LibraryContent.swift
//  DesignCodeCourse
//
//  Created by Jack Wong on 7/28/20.
//

import SwiftUI

struct LibraryContent: LibraryContentProvider {
    @LibraryContentBuilder
    var views: [LibraryItem] {
        LibraryItem(
            CloseButton(),
            title: "Close Button View",
            category: .control
        )
    }
    
    @LibraryContentBuilder
    func modifiers(base: Image) -> [LibraryItem] {
        LibraryItem(
            base.cardStyle(color: Color.blue, cornerRadius: 22),
            title: "Card Style",
            category: .effect
        )
    }
}

extension View {
    func cardStyle(color: Color, cornerRadius: CGFloat) -> some View {
        return self
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 20, y: 10)
    }
}
