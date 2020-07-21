//
//  ContentView.swift
//  DesignCode
//
//  Created by Jack Wong on 7/21/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            TitleView()
//                .blur(radius: 20)
            
            //Layer underneath card
            BackCardView()
                .background(Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: -40)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(10))
                .rotation3DEffect(
                    .degrees(5),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight)
            
            
            BackCardView()
                .background(Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: -20)
                .scaleEffect(0.95)
                .rotationEffect(.degrees(5))
                .rotation3DEffect(
                    .degrees(5),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight)
            
            //Card
            CardView()
                .blendMode(.hardLight)
            
            ButtonCardView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }.frame(width: 340, height: 220)
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(width: 340, height: 220)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.all)
            Image("Background1")
            Spacer()
        }
    }
}

struct ButtonCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            Text("This certificate is proof that this individual has acheived the UI Design course with approval  from a Design+Code instructor")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.subheadline)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
        .offset(x: 0, y: 500)
    }
}
