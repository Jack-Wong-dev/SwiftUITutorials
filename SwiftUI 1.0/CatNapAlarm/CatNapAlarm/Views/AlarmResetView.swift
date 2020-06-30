//
//  AlarmResetView.swift
//  CatNapAlarm
//
//  Created by Jack Wong on 4/28/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI

struct AlarmResetView: View {
    
    @Binding var alarmList: [Alarm]
    
    var body: some View {
        VStack {
            Image("clock", label: Text("Clock Reset"))
            .resizable()
            .frame(width: 200, height: 200)
            .gesture(LongPressGesture()
                .onEnded({ (value) in
                    self.disableAlarms()
                })
            )
            Text("Disable Alarms")
                .font(Font.system(.headline, design: .rounded))
                .minimumScaleFactor(0.85)
                .foregroundColor(.red)
        }
        .accessibilityAction {
            self.disableAlarms()
        }
    }
    
    private func disableAlarms() {
        alarmList.forEach {
            $0.isActive = false
        }
    }
}

struct AlarmResetView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmResetView(alarmList: .constant([Alarm(name: "Test", startTime: Date(timeIntervalSinceNow: -200), endTime: Date())]))
    }
}
