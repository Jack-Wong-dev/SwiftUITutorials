//
//  TravelUI.swift
//  Kavsoft
//
//  Created by Jack Wong on 8/19/20.
//

import SwiftUI

struct Home : View {
    
    var animation : Namespace.ID
    @Binding var show : Bool
    @Binding var selected : Model
    
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                
                HStack{
                    
                    Text("Discover a \nDifferent World")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color("txt"))
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {}) {
                        
                        Image("search")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("Color"))
                        .clipShape(Circle())
                        }
                }
                .padding()

                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack{
                        
                        ForEach(1...5,id: \.self){i in
                            
                            Image("r\(i)")
                                .renderingMode(.original)
                                .onTapGesture {
                                    
                                    // do some stuff....
                                }
                        }
                    }
                    .padding()

                }

                
                HStack{
                    
                    Text("Destinations")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("txt"))
                    
                    Spacer()
                    
                    Button(action: {}) {
                        
                        Text("See All")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                ForEach(data){travel in
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        
                        Image(travel.img)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .cornerRadius(25)
                            .matchedGeometryEffect(id: travel.img, in: animation)
                        
                        
                        VStack(alignment: .trailing, spacing: 8) {
                            
                            Text(travel.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: travel.title, in: animation)
                            
                            Text(travel.country)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: travel.country, in: animation)
                        }
                        .padding()
                    }
                    .padding()
                    // setting detail Data...
                    .onTapGesture {
                        
                        withAnimation(.spring()){
                            
                            selected = travel
                            show.toggle()
                        }
                    }
                }
            }
        }
    }
}

struct Liked : View {
    
    var body: some View{
        
        VStack{
            
            Spacer()
            
            Text("Liked")
            
            Spacer()
        }
    }
}

struct Account : View {
    
    var body: some View{
        
        VStack{
            
            Spacer()
            
            Text("Account")
            
            Spacer()
        }
    }
}

// Creating Tab Views...

struct TravelUI : View {
    
    @State var tab = "Explore"
    @Namespace var animation
    @State var show = false
    @State var selected : Model = data[0]
    
    var body: some View{
        
        ZStack{
            
            VStack(spacing: 0){
                
                // changing Views Based On tab....
                
                switch(tab){
                
                case "Explore": Home(animation: animation, show: $show, selected: $selected)
                case "Liked": Liked()
                default: Account()
                    
                }
                
                Spacer()
                
                HStack(spacing: 0){
                    
                    tabButton(title: "Explore", tab: $tab)
                    
                    Spacer(minLength: 0)
                    
                    tabButton(title: "Liked", tab: $tab)
                    
                    Spacer(minLength: 0)
                    
                    tabButton(title: "Account-1", tab: $tab)
                }
                .frame(height: 20)
                .padding()
                .background(Color.white)
//                .clipShape(TravelRoundedShape(corners: [.topLeft,.topRight]))
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0.0, y: 0.0)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            
            // Detail View....
            
            if show{
                
                Detail(selected: $selected, show: $show, animation: animation)
            }
        }
        .background(Color("bg").edgesIgnoringSafeArea(.all))
    }
}

// Detail View...

struct Detail : View {
    
    @Binding var selected : Model
    @Binding var show : Bool
    var animation : Namespace.ID
    
    var body: some View{
        
        VStack{
            
            VStack{
                
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    
                    Image(selected.img)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 330)
                        .clipShape(TravelRoundedShape(corners: [.bottomLeft,.bottomRight]))
                        .matchedGeometryEffect(id: selected.img, in: animation)
                    
                    HStack{
                        
                        Button(action: {
                            
                            withAnimation(.spring()){show.toggle()}
                            
                        }) {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            
                            Image(systemName: "suit.heart")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }
                    .padding()

                }

                
                // Details View...
                
                HStack(alignment: .top){
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text(selected.title)
                            .font(.title)
                            .foregroundColor(Color("txt"))
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: selected.title, in: animation)
                        
                        HStack(spacing: 10){
                            
                            Image("map")
                            
                            Text(selected.country)
                                .foregroundColor(.black)
                                .matchedGeometryEffect(id: selected.country, in: animation)
                            
                            HStack(spacing: 5){
                                
                                Text(selected.ratings)
                                    .foregroundColor(.black)
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                    
                    Spacer(minLength: 0)
                    
                    Text(selected.price)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("txt"))
                }
                .padding()
                .padding(.bottom)
            }
            .background(Color.white)
            .clipShape(TravelRoundedShape(corners: [.bottomLeft,.bottomRight]))
            
            // ScrollView For Smaller Size Phones....
            
            GeometryReader() { geo in
                
                if geo.size.height < 750 {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        BottomView()
                    }
                    .onAppear(perform: {
                        print(geo.size.height)
                    })
                } else {
                    BottomView()
                }
            }
            
            Spacer(minLength: 0)
        }
        .background(Color("bg"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct BottomView : View {
    
    @State var index = 1
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 15) {
            
            Text("People")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("txt"))
            
            Text("Member Of Your Group")
                .font(.caption)
            
            HStack(spacing: 15){
                
                ForEach(1...6,id: \.self){i in
                    
                    Button(action: {index = i}) {
                        
                        Text("\(i)")
                            .fontWeight(.bold)
                            .foregroundColor(index == i ? .white : .gray)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color("Color").opacity(index == i ? 1 : 0.07))
                            .cornerRadius(4)
                    }
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top)
            
            Text("Description")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("txt"))
                .padding(.top,10)
            
            Text("The Caribbean is a region of the Americas that consists of the Caribbean Sea, its islands and the surrounding coasts")
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
            
            Spacer(minLength: 0)
            
            HStack{
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    
                    Text("Book Now")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)

                        .padding(.vertical)
                        .background(Color("Color"))
                        .clipShape(Capsule())
                }
              
                Spacer(minLength: 0)
            }
            .padding([.top, .bottom])
        }
        .padding([.horizontal,.top])
    }
}

// Tab Buttons...

struct tabButton : View {
    
    var title : String
    @Binding var tab : String
    
    var body: some View{
        
        Button(action: {tab = title}) {
            
            HStack(spacing: 8){
                
                Image(title)
                    .renderingMode(.template)
                    .foregroundColor(tab == title ? .white : .gray)
                
                
                Text(tab == title ? title : "")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(Color("Color").opacity(tab == title ? 1 : 0))
            .clipShape(Capsule())
        }
    }
}

// bottom only corners....

struct TravelRoundedShape : Shape {
    
    // for resuable.....
    var corners : UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 45, height: 45))
        
        return Path(path.cgPath)
    }
}

// Model And Sample Data...

struct Model : Identifiable {
    
    var id = UUID().uuidString
    var title : String
    var country : String
    var ratings : String
    var price : String
    var img : String
}

var data = [
    
    Model(title: "Carribean", country: "French", ratings: "4.9", price: "$200", img: "p1"),
    Model(title: "Big Sur", country: "USA", ratings: "4.1", price: "$150", img: "p2"),
]


