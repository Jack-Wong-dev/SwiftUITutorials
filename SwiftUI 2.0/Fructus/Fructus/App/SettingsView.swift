//
//  SettingsView.swift
//  Fructus
//
//  Created by Jack Wong on 8/24/20.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // MARK: - Section 1
                    
                    GroupBox(
                        label:
                            SettingsLabelView(labelText: "Fructus", labelImage: "info.circle")
                    ) {
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 10) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            
                            Text("Most fruits are naturally low in fat, sodium, and calories. None have cholesterol.  Fruits are sources of many essential nutrients, including potassium, dietary fiber, vitamins, and so much more. ")
                        }
                    }
                    
                    // MARK: - Section 2
                    
                    // MARK: - Section 3
                    
                    GroupBox(
                        label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")
                    ) {
                       SettingsRowView(name: "Developer", content: "John / Jane")
                       SettingsRowView(name: "Designer", content: "Robert Petras")
                       SettingsRowView(name: "Compatibility", content: "iOS 14")
                        SettingsRowView(name: "Website", linkLabel: "SwiftUI Masterclass", linkDestination: "swiftuimasterclass.com")
                        SettingsRowView(name: "Twitter", linkLabel: "@RobertPetras", linkDestination: "twitter.com/robertpetras")
                        SettingsRowView(name: "SwiftUI", content: "2.0")
                        SettingsRowView(name: "Version", content: "1.1.0")
                    }
                }
                .navigationBarTitle("Settings")
                .navigationBarItems(trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()}
                    ){
                        Image(systemName: "xmark")
                    }
                )
                .padding()
            } //: ScrollView
        }//: Navigation
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11 Pro")
    }
}
