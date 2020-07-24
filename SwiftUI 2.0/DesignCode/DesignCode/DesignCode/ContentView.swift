//
//  ContentView.swift
//  DesignCode
//
//  Created by Jack Wong on 7/21/20.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var showCard = false
    @State var showFull = false
    
    @State var viewState = CGSize.zero
    @State var bottomState = CGSize.zero
    
    //Like Animation States, drag states can be declared the same way.  Using CGSize to store x and y positions.  Value can be reset using the zero property
    
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: show ? 20 : 0) //blur out view when cards are revealed
                .opacity( showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0) //Moved off of the visible area
                .animation(
                    Animation
                        .default
                        .delay(0.1)  //Animation delay, so that the bottom card would animate first
                    //                        .speed(2)
                    //                        .repeatCount(3, autoreverses: false)
                )
            
            //Cards underneath
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40) //reveal card
                .offset(x: viewState.width, y: viewState.height) //change as user drags main Card
                .offset(y: showCard ? -180 : 0)
                .scaleEffect( showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10)) //cards are angled
                .rotationEffect(Angle(degrees: showCard ? -10 : 0))
                .rotation3DEffect(
                    .degrees( showCard ? 0 : 5),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight) //blending colors
                .animation(.easeInOut(duration: 0.5))
            
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background( show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect( showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                .rotation3DEffect(
                    .degrees( showCard ? 0 : 5),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            //Card
            CardView()
                .frame(width: showCard ? 370 : 340, height: 220)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous)) //Expand/Shrink effect
                //                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) //Card would snap back into place after gesture end
                .onTapGesture {
                    showCard.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            viewState = value.translation
                            show = true
                        }
                        .onEnded { value in
                            viewState = .zero
                            show = false
                        }
                )
            
            //Debug View
//            Text("\(bottomState.height)").offset(y: -300)
            
            ButtonCardView(show: $showCard)
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(
                    DragGesture().onChanged { value in
                        bottomState = value.translation
                        if showFull {
                            bottomState.height += -300
                        }
                        if bottomState.height < -300 {  //Maximum drag
                            bottomState.height = -300  //snaps to that anchor, card would not go above that
                        }
                    }
                    .onEnded { value in
                        if bottomState.height > 50 {
                            showCard = false
                        }
                        if (bottomState.height < -100  && !showFull) || (bottomState.height < -250 && showFull) {
                            bottomState.height = -300
                            showFull = true
                        } else {
                            bottomState = .zero
                            showFull = false
                        }
                    }
                )
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
        }
        
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
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
    
    @Binding var show: Bool
    
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

            HStack {
                RingView(color1: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 88, height: 88, percent: 78, show: $show)
                    .animation( Animation.easeInOut.delay(0.3))
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("SwiftUI").fontWeight(.bold)
                    Text("12 of 12 sections completed \n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
                
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}
