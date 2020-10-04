//
//  ContentView.swift
//  Kavsoft
//
//  Created by Jack Wong on 8/17/20.
//

import SwiftUI

struct FitnessDashBoard: View {
    var body: some View {
        DashBoard()
    }
}

struct FitnessDashBoard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FitnessDashBoard()
                .previewDevice("iPhone 11 Pro Max")
        }
    }
}

struct DashBoard: View {
    @State var selected = 0
    var colors = [Color("Color1"), Color("Color")]
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Text("Hello Emma")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        Image("menu")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                //MARK: -- Bar Chart
                VStack(alignment: .leading, spacing: 25) {
                    Text("Daily Workouts in hours")
                        .font(.system(size:32))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 10) {
                        
                        ForEach(workout_Data) { work in
                            //Bars
                            
                            VStack {
                                
                                VStack {
                                    
                                    Spacer(minLength: 0)
                                    
                                    if selected == work.id {
                                        Text(getHours(value: work.workout_In_Min))
                                            .foregroundColor(Color("Color"))
                                            .padding(.bottom, 5)
                                    }
                                    
                                    RoundedShape()
                                        .fill(LinearGradient(gradient: .init(colors: selected == work.id ? colors : [Color.white.opacity(0.06)]), startPoint: .top, endPoint: .bottom))
                                        .frame(height: getHeight(value: work.workout_In_Min)) //Max Height of 200
                                }
                                .frame(height: 220)
                                .onTapGesture {
                                    withAnimation(.easeOut) {
                                        selected = work.id
                                    }
                                }
                                
                                Text(work.day)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.06))
                .cornerRadius(10)
                .padding()
                
                HStack {
                    Text("Statistics")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                
                //MARK: -- Stats Grid
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(stats_Data) { stat in
                        VStack(spacing: 32) {
                            HStack {
                                Text(stat.title)
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Spacer(minLength: 0)
                            }
                            
                            ZStack {
                                Circle()
                                    .trim(from: 0, to: 1)
                                    .stroke(stat.color.opacity(0.05), lineWidth: 10)
                                    .frame(height: 160)
                                
                                Circle()
                                    .trim(from: 0, to: (stat.currentData / stat.goal))
                                    .stroke(stat.color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .frame(height: 160)
                                    .rotationEffect(.init(degrees: -90))
                                
                                Text("\(getPercentage(current: stat.currentData, goal: stat.goal)) %")
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(stat.color)
                            }
                            
                            Text("\(getDecimal(value: stat.currentData)) \(getType(value: stat.title))")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                        .shadow(color: Color.white.opacity(0.1), radius: 10, x: 0, y: 0)
                    }
                }
                .padding()
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .preferredColorScheme(.dark)
        //Status bar color is not changing, still in beta
    }
    
    func getHeight(value: CGFloat) -> CGFloat {
        /* Value in minutes
         24 hours in minutes = 1440
         */
        let hours = (value / 1440) * 200
        
        return hours
    }
    
    func getHours(value: CGFloat) -> String {
        let hours = value / 60
        
        return String(format: "%.1f", hours)
    }
    
    func getPercentage(current: CGFloat, goal: CGFloat) -> String {
        let percentage = current / goal
        return String(format: "%.1f", percentage)
    }
    
    func getType(value: String) -> String {
        switch value {
        case "Water" : return "L"
        case "Sleep" : return "Hrs"
        case "Running" : return "Km"
        case "Steps" : return "stp"
        default: return "Kcal"
        }
    }
    
    func getDecimal(value: CGFloat) -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format.string(from: NSNumber.init(value: Float(value)))!
    }
}

struct RoundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5))
        
        return Path(path.cgPath)
    }
    
    
}


//MARK: -- Mock Data
struct Daily : Identifiable {
    
    var id : Int
    var day : String
    var workout_In_Min : CGFloat
}

var workout_Data = [
    
    Daily(id: 0, day: "Day 1", workout_In_Min: 480),
    Daily(id: 1, day: "Day 2", workout_In_Min: 880),
    Daily(id: 2, day: "Day 3", workout_In_Min: 250),
    Daily(id: 3, day: "Day 4", workout_In_Min: 360),
    Daily(id: 4, day: "Day 5", workout_In_Min: 1220),
    Daily(id: 5, day: "Day 6", workout_In_Min: 750),
    Daily(id: 6, day: "Day 7", workout_In_Min: 950)
]

// stats Data...

struct Stats : Identifiable {
    
    var id : Int
    var title : String
    var currentData : CGFloat
    var goal : CGFloat
    var color : Color
}

var stats_Data = [
    
    Stats(id: 0, title: "Running", currentData: 6.8, goal: 15, color: Color("running")),
    
    Stats(id: 1, title: "Water", currentData: 3.5, goal: 5, color: Color("water")),
    
    Stats(id: 2, title: "Energy Burn", currentData: 585, goal: 1000, color: Color("energy")),
    
    Stats(id: 3, title: "Sleep", currentData: 6.2, goal: 10, color: Color("sleep")),
    
    Stats(id: 4, title: "Cycling", currentData: 12.5, goal: 25, color: Color("cycle")),
    
    Stats(id: 5, title: "Steps", currentData: 16889, goal: 20000, color: Color("steps")),
]
