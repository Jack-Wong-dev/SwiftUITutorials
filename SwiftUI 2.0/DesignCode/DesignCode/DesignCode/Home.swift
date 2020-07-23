//
//  Home.swift
//  DesignCode
//
//  Created by Jack Wong on 7/22/20.
//

import SwiftUI

struct Home: View {
    
    @State private var showProfile = false
    @State private var viewState = CGSize.zero
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: $showProfile)
            .padding(.top, 44)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .offset(y: showProfile ? -450 : 0)
            .rotation3DEffect(
                Angle(degrees: showProfile ? Double(viewState.height/10)-10 : 0),
                axis: (x: 10.0, y: 0.0, z: 0.0)
            )
            .scaleEffect(showProfile ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .edgesIgnoringSafeArea(.all)
            
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    showProfile.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        viewState = value.translation
                    }
                    .onEnded { value in
                        
                        if viewState.height > 50 {
                            showProfile = false
                        }
                        
                        viewState = .zero
                    }
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .previewDevice("iPhone 11 Pro")
    }
}

struct AvatarView: View {
    
    @Binding var showProfile: Bool
        
    var body: some View {
        Button(action: {showProfile.toggle()}, label: {
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        })
    }
}

let screen = UIScreen.main.bounds

