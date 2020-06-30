//
//  AlarmView.swift
//  CatNapAlarm
//
//  Created by Jack Wong on 4/28/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI
import Combine

struct AlarmView: View {
    
    @ObservedObject var alarm: Alarm
    
    var body: some View {
        VStack {
            TextField("Alarm Name", text: $alarm.name)
                .padding()
                .foregroundColor(.white)
                .background(Color.catPurple)
                .cornerRadius(10)
            
            DatePicker(selection: $alarm.startTime, displayedComponents: .hourAndMinute) {
                Text("Start Date")
            }
            
            DatePicker(selection: $alarm.endTime, displayedComponents: .hourAndMinute) {
                Text("End Date")
            }
            
            Toggle(isOn: $alarm.isActive) {
                Text("Alarm is Active")
            }
        }
    .padding()
    }
}

struct AlarmView_Previews: PreviewProvider {
    
    static var alarm = Alarm(name: "Test", startTime: Date(timeIntervalSinceNow: -200), endTime: Date())
    
    static var previews: some View {
        AlarmView(alarm: alarm)
    }
}
