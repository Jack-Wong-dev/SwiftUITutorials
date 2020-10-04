//
//  ContentView.swift
//  Kavsoft
//
//  Created by Jack Wong on 8/18/20.
//

import SwiftUI

struct NavigationWithCustomTab: View {
    var body: some View {
        NavigationView{
            
            CustomTabView()
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        }
    }
}

struct CustomTabView: View {
    @State var selectedTab = "home"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            /*
             TabView for Swipe Gestures.
             Note:  Use Switch Cases instead if you don't need swipe gestures to navigate
             */
            TabView(selection: $selectedTab) {
                CustomTabHomeView().tag("home")
                
                Email().tag("email")
                
                Folder().tag("folder")
                
                Settings().tag("settings")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never
            ))
            .ignoresSafeArea(.all, edges: .bottom)
            .padding(.bottom, 70)
            //for bottom overflow
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    TabButton(image: image, selectedTab: $selectedTab)
                    
                    //equal spacing
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
            .padding(.horizontal)
            
            //For smaller iphones, adjust elevation
            //            .padding(.bottom, edge!.bottom == 0 ? 20 : 10)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom) //ignore tabview elevation
    }
}

struct CustomTabHomeView: View {
    @State var text = ""
    
    var body: some View {
        VStack {
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Hello Jack")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Let's upgrade your skill!")
                }
                .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                //Profile Button
                Button(action: {}) {
                    Image("profile")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                }
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    //SearchBar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Seach Courses", text: $text)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(Capsule())
                    
                    //Categories - View All
                    HStack {
                        Text("Categories")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {} ) {
                            Text("View All")
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.top, 25)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing : 20) {
                        ForEach(courses) { course in
                            CourseCardView(course: course)
                        }
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        
    }
}

struct CourseCardView: View {
    
    var course: Course
    
    var body: some View {
        VStack {
            VStack {
                Image(course.asset)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .background(Color(course.asset))
                
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(course.name)
                            .font(.title3)
                        Text("\(course.numCourse) Courses")
                    }
                    .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(15)
            
            Spacer(minLength: 0)
            //Or use max height in flexible in grid item
        }
    }
}




var tabs = ["home", "email", "folder","settings"]

struct TabButton: View {
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {selectedTab = image}) {
            Image(image)
                .renderingMode(.template)
                .foregroundColor(selectedTab == image ? Color("tab") : Color.black.opacity(0.4))
                .padding()
        }
    }
}

// TabViews...

struct Email : View {
    
    var body: some View{
        
        VStack{
            
            Text("Email")
        }
    }
}

struct Folder : View {
    
    var body: some View{
        
        VStack{
            
            Text("Folder")
        }
    }
}

struct Settings : View {
    
    var body: some View{
        
        VStack{
            
            Text("Settings")
        }
    }
}


// Model Data...

struct Course : Identifiable {
    
    var id = UUID().uuidString
    var name : String
    var numCourse : Int
    var asset : String
}

// both image and color name is same so i used common word asset...

var courses = [
    
    Course(name: "Coding", numCourse: 12,asset: "coding"),
    Course(name: "Trading", numCourse: 12,asset: "trading"),
    Course(name: "Cooking", numCourse: 12,asset: "cooking"),
    Course(name: "Marketing", numCourse: 12,asset: "marketing"),
    Course(name: "UI/UX", numCourse: 12,asset: "ux"),
    Course(name: "Digital Marketing", numCourse: 12,asset: "digital")
]

struct DetailView : View {
    
    var course : Course
    
    var body: some View{
        
        VStack{
            
            Text(course.name)
                .font(.title2)
                .fontWeight(.bold)
        }
        .navigationTitle(course.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {}, label: {
            
            Image("menu")
                .renderingMode(.template)
                .foregroundColor(.gray)
        }))
    }
}
