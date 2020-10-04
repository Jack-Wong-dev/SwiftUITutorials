//
//  DashBoardUI.swift
//  Kavsoft
//
//  Created by Jack Wong on 8/20/20.
//

import SwiftUI

struct DashBoardUI: View {
    let subTabs = ["Today","Yesterday","Last Week"]
    
    @Namespace var animation
    @State var tab = "USA"
    @State var subTab = "Today"
    @State var dailySaled = [
        
        // Last 7 Days....
        DailySales(day: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: 200, show: true),
        DailySales(day: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: 710, show: false),
        DailySales(day: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: 330, show: false),
        DailySales(day: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: 519, show: false),
        DailySales(day: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: 150, show: false),
        DailySales(day: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: 229, show: false),
        DailySales(day: Date(), value: 669, show: false)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {}) {
                    Image("menu")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
                Spacer(minLength: 0)
                Button(action: {}) {
                    Image("bell")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
            }
            .padding()
            
            HStack {
                Text("Dashboard")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack {
                DashBoardTab(selected: $tab, title: "USA", animation: animation)
                DashBoardTab(selected: $tab, title: "Global", animation: animation)
            }
            .background(Color.white.opacity(0.08))
            .clipShape(Capsule())
            .padding(.horizontal)
        
            HStack {
                ForEach(subTabs, id: \.self) { tab in
                    Button(action: {}) {
                        Text(tab)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white.opacity(subTab == tab ? 1 : 0.4))
                    }
                    
                }
            }
            .padding()
            
            VStack(spacing: 20){
                HStack(spacing: 15){
                    SalesView(sale: salesData[0])
                    SalesView(sale: salesData[1])
                }
                HStack(spacing: 15){
                    SalesView(sale: salesData[2])
                    SalesView(sale: salesData[3])
                    SalesView(sale: salesData[4])
                }
            }
            .padding(.horizontal)
            
            ZStack{
                
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], size: 45))
                    .ignoresSafeArea(.all, edges: .bottom)
                
                VStack{
                    
                    HStack{
                        
                        Text("Daily Sold Units")
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                    }
                    .padding()
                    .padding(.top,10)
                    
                    HStack(spacing: 10){
                        
                        ForEach(dailySaled.indices,id: \.self){i in
                            
                            // For Toggling Show Button....
                            
                            GraphView(data: dailySaled[i], allData: dailySaled)
                                .onTapGesture {
                                    
                                    withAnimation{
                                        
                                        // toggling all other...
                                        
                                        for index in 0..<dailySaled.count{
                                            
                                            dailySaled[index].show = false
                                        }
                                        
                                        dailySaled[i].show.toggle()
                                    }
                                }
                            
                            // sample Sapcing For Spacing Effect..
                            
                            if dailySaled[i].value != dailySaled.last!.value{
                                
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    .padding(.horizontal,30)
                }
            }
            .padding(.top,20)
        
            Spacer(minLength: 0)
        }
        .background(Color.black.ignoresSafeArea(.all, edges: .all))
        .preferredColorScheme(.dark)
    }
    
    struct SalesView : View {
        
        var sale : Sales
        
        var body: some View{
            
            ZStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 22) {
                        
                        Text(sale.title)
                            .foregroundColor(.white)
                        
                        Text(sale.value)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .background(sale.color)
            .cornerRadius(10)
        }
    }
    
    struct DashBoardTab: View {
        
        @Binding var selected: String
        var title: String
        var animation : Namespace.ID
        
        var body: some View {
            Button(action: {
                withAnimation(.spring()) {
                    selected = title
                }
            }) {
                ZStack {
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 45)
                        .matchedGeometryEffect(id: "Tab", in: animation)
                    
                    if selected == title{
                        
                        Capsule()
                            .fill(Color.white)
                            .frame(height: 45)
                        // Mathced Geometry Effect...
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                    
                    Text(title)
                        .foregroundColor(selected == title ? .black : .white)
                        .fontWeight(.bold)
                    
                }
            }
        }
    }

    
    struct CustomCorners : Shape {
        
        var corners : UIRectCorner
        var size : CGFloat
        
        func path(in rect: CGRect) -> Path {
            
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
            
            return Path(path.cgPath)
        }
    }
}


struct GraphView : View {
    
    var data : DailySales
    var allData : [DailySales]
    
    var body: some View{
        
        VStack(spacing: 5){
            
            GeometryReader{reader in
                
                VStack(spacing: 0){
                    
                    Spacer(minLength: 0)
                    
                    Text("\(Int(data.value))")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        // default Height For Graph...
                        .frame(height: 20)
                        .opacity(data.show ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.red.opacity(data.show ? 1 : 0.4))
                        .frame(height: calulateHeight(value: data.value, height: reader.frame(in: .global).height - 20))
                }
            }
            
            Text(customDateStyle(date: data.day))
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
    
    func customDateStyle(date: Date)->String{
        
        let format = DateFormatter()
        format.dateFormat = "MMM dd"
        return format.string(from: date)
    }
    
    func calulateHeight(value: CGFloat,height: CGFloat)->CGFloat{
        
        let max = allData.max { (max, sale) -> Bool in
            
            if max.value > sale.value{return false}
            else{return true}
        }
        
        let percent = value / max!.value
        
        return percent * height
    }
}


struct DashBoardUI_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardUI()
    }
}

// Sample Model Data....
 
 struct Sales : Identifiable {
     
     var id = UUID().uuidString
     var title : String
     var value : String
     var color : Color
 }
 
 var salesData = [
 
     Sales(title: "Sold", value: "18,789", color: Color.orange),
     Sales(title: "Returned", value: "1,089", color: Color.red),
     Sales(title: "Delivered", value: "8,500", color: Color.blue),
     Sales(title: "Transit", value: "2,000", color: Color.pink),
     Sales(title: "Cancelled", value: "1,700", color: Color.purple),
 ]
 
 // Daily Sold Model And Data....
 
 struct DailySales : Identifiable {
     var id = UUID().uuidString
     var day : Date
     var value : CGFloat
     var show : Bool
 }

