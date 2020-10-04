//
//  CustomTabView.swift
//  Kavsoft
//
//  Created by Jack Wong on 9/8/20.
//

import SwiftUI

struct CustomTabController: View {
    var body: some View {
        NavigationView {
            CustomTabControllerHome()
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabController()
    }
}

struct CustomTabControllerHome: View {
    
    @State var selectedTab = "Home"
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geo in
                ZStack {
                    Text("Hello World")
                    //Tabs goes here
                }
            }
            
            HStack(spacing: 0){
                ForEach(customTabs, id: \.self) {
                    tab in
                    CustomTabButton(title: tab, selectedTab: $selectedTab, animation: animation)
                    
                    if tab != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 30)
            .background(Color.white)
        }
    }
}

var customTabs = ["Home", "Restaurants", "Orders", "Rewards"]

struct CustomTabButton: View {
    
    var title: String
    @Binding var selectedTab: String
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation() {
                selectedTab = title
            }
        }){
            VStack(spacing: 6){
                
                ZStack {
                    CustomShape()
                        .fill(Color("tint").opacity(selectedTab == title ? 1 : 0))
                        .frame(width: 45, height: 6)
                        
                    if selectedTab == title {
                        CustomShape()
                            .fill(Color("tint"))
                            .frame(width: 45, height: 6)
                            .matchedGeometryEffect(id: "Tab_Change", in: animation)
                    }
                }
                .padding(.bottom, 10)

                
                Image("Tab\(title)")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(selectedTab == title ? Color("tint") : Color.black.opacity(0.2))
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(selectedTab == title ? 0.6 : 0.2))
                
            }
        }
    }
}

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        return Path(path.cgPath)
    }
}
