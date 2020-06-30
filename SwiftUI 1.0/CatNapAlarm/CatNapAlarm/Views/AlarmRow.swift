//
//  AlarmRow.swift
//  CatNapAlarm
//
//  Created by Jack Wong on 4/28/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI

struct AlarmRow: View {
    
    @ObservedObject var alarm: Alarm
    
    var body: some View {
        HStack {
            Image(decorative: "clock")
            .resizable()
            .frame(width: 40, height: 40)
                .opacity(alarm.isActive ? 1 : 0.2)
            
            VStack(alignment: .leading) {
                Text(alarm.name)
                .lineLimit(nil)
                Text("\(alarm.startTime.formatted) - \(alarm.endTime.formatted)")
                    .fontWeight(.bold)
                    .font(.body)
                    .minimumScaleFactor(0.5)
                    .accessibility(value: Text("Start \(alarm.startTime), end: \(alarm.endTime)"))
            }
            .opacity(alarm.isActive ? 1 : 0.2)
            Toggle(isOn: $alarm.isActive) {
                Text("Enable Alarm")
            }
        }
    }
}

//struct AlarmRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmRow()
//    }
//}
