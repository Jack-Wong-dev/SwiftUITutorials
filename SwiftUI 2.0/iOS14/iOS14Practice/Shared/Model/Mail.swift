//
//  Mail.swift
//  iOS14Practice (iOS)
//
//  Created by Jack Wong on 7/30/20.
//

import SwiftUI

struct Mail: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let subject: String
    let body: String
    var isFavorited = false
}

final class MailStore: ObservableObject {
    @Published var allMails: [String: [Mail]] = [
        "Inbox": [ .init(date: Date(), subject: "Subject1", body: "Very long body...") ],
        "Sent": [ .init(date: Date(), subject: "Subject2", body: "Very long body...") ],
    ]
}
