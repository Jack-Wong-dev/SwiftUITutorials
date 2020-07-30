//
//  MailView.swift
//  iOS14Practice (iOS)
//
//  Created by Jack Wong on 7/30/20.
//

import SwiftUI

struct MailView: View {
    let mail: Mail

    var body: some View {
        VStack(alignment: .leading) {
            Text(mail.subject)
                .font(.headline)
            Text(mail.date, style: .date)
            Text(mail.body)
        }
    }
}

//struct MailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MailView()
//    }
//}
