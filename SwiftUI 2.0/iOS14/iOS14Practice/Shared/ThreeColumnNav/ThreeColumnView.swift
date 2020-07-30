//
//  ThreeColumnView.swift
//  iOS14Practice (iOS)
//
//  Created by Jack Wong on 7/30/20.
//

import SwiftUI

struct ThreeColumnView: View {
    @StateObject var store = MailStore()
    @State private var selectedLabel: String? = "Inbox"
    @State private var selectedMail: Mail?
    
    var body: some View {
        NavigationView {
            Sidebar(
                store: store,
                selectedFolder: $selectedLabel,
                selectedMail: $selectedMail
            )
            
            if let label = selectedLabel {
                FolderView(
                    title: label,
                    mails: store.allMails[label, default: []],
                    selectedMail: $selectedMail
                )
            } else {
                Text("Select label...")
            }
            
            if let mail = selectedMail {
                MailView(mail: mail)
            } else {
                Text("Select mail...")
            }
        }
    }
}


struct ThreeColumnView_Previews: PreviewProvider {
    static var previews: some View {
        ThreeColumnView()
    }
}
