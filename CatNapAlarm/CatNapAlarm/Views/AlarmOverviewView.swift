//
//  AlarmOverviewView.swift
//  CatNapAlarm
//
//  Created by Jack Wong on 4/28/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI

struct AlarmOverviewView: View {
    @State private var showNewAlarm = false
    @State private var alarmList = [Alarm]()
    
    var body: some View {
        NavigationView {
            VStack {
                AlarmResetView(alarmList: $alarmList)
                    .accessibility(addTraits: .isHeader)
                AlarmList(alarmList: $alarmList)
                    .accessibility(addTraits: .isHeader)
                    .navigationBarTitle("CapNap Alarms")
                    .navigationBarItems(trailing:
                        Button(action: {
                            self.showNewAlarm.toggle()
                            let newAlarm = Alarm(name: "New Alarm", startTime: Date(), endTime: Date())
                            self.alarmList.append(newAlarm)
                        }, label: {
                            Image(systemName: "plus.circle")
                            .accessibility(label: Text("Add new alarm"))
                        })
                )
                    .sheet(isPresented: $showNewAlarm) {
                        AlarmView(alarm: self.alarmList.last!)
                }
            }
        }
    }
}

struct AlarmOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmOverviewView()
    }
}
