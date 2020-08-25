//
//  SettingsLabelView.swift
//  Fructus
//
//  Created by Jack Wong on 8/24/20.
//

import SwiftUI

struct SettingsLabelView: View {
    // MARK: - Properties
    
    var labelText: String
    var labelImage: String
    
    var body: some View {
        HStack {
            Text(labelText.uppercased())
            Spacer()
            Image(systemName: labelImage)
        }
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "Fructus", labelImage: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
