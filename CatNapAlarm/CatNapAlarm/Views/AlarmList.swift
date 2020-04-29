//
//  AlarmList.swift
//  CatNapAlarm
//
//  Created by Jack Wong on 4/28/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI

struct AlarmList: View {
    
    @Binding var alarmList: [Alarm]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Alarms")) {
                    ForEach(alarmList) { alarm in
                        NavigationLink(destination: AlarmView(alarm: alarm)) {
                            AlarmRow(alarm: alarm)
                        }
                    .accessibility(label: Text("Edit Alarm"))
                    }
                }
            }
        }
    }
}

struct AlarmList_Previews: PreviewProvider {
   static var alarmList: [Alarm] = [Alarm(name: "Test", startTime: Date(timeIntervalSinceNow: -200), endTime: Date())]

    static var previews: some View {
      AlarmList(alarmList: .constant(alarmList))
    }
}
