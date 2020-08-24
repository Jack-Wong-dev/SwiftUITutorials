//
//  CoursesView.swift
//  DesignCodeCourse
//
//  Created by Jack Wong on 7/27/20.
//

import SwiftUI

struct CoursesView: View {
    @State var show = false
    @Namespace var namespace //Set a collection of matched elements
    @State var selectedItem : Course? = nil
    @State var isDisabled = false
    @Namespace var namespace2
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    var body: some View {
        //Card to Full Screen ScrollView (with list) and vice versa
        ZStack {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                tabBar
            }else {
                sidebar
            }
            fullContent
                .background(VisualEffectBlur(blurStyle: .systemMaterial).edgesIgnoringSafeArea(.all))
            #else
            content
            fullContent
                .background(VisualEffectBlur().edgesIgnoringSafeArea(.all)) //blurStyle doesn't exit on Mac
            #endif
        }
        .navigationTitle("Courses")
    }
    
    var content: some View {
        ScrollView {
            VStack(spacing: 0) {
                /*Fits as many 160 size items with gap value (spacing: 16 between columns), with 16 spacing between rows */
                LazyVGrid(
                    columns: [ GridItem(.adaptive(minimum: 160),spacing: 16)],
                    spacing: 16
                ) {
                    //Cards
                    ForEach(courses) { item in
                        VStack {
                            CourseItem(course: item) //Matched Geometry Effect always before frame. isSource is optional, helps determine where to animation from.  e.g. Card to Other Card, Other Card to Card
                                .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                                .frame(height: 200)
                                .onTapGesture {
                                    /* withAnimation is preferred over .animation when Matched Geoemetry Effect is involved.
                                     .animation creates lag (may change in the future), here the card behind would try to play catch up instead of being directly behind */
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                        show.toggle()
                                        selectedItem = item
                                        isDisabled = true
                                    }
                                }
                                .disabled(isDisabled)  //Disable card
                        }
                        .matchedGeometryEffect(id: "container\(item.id)", in: namespace, isSource: !show)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                
                Text("Latest Sections")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 240))]) {
                    ForEach(courseSections) { item in
                        
                        #if os(iOS)
                        NavigationLink(destination: CourseDetail(namespace: namespace2)) {
                            CourseRow(item: item)
                        }
                        #else
                        CourseRow(item:item)
                        #endif
                    }
                }
                .padding()
            }
        }
        .zIndex(1)
        .navigationTitle("Courses")
    }
    
    
    @ViewBuilder
    var fullContent: some View {
        if selectedItem != nil {
            //Full Screen
            ZStack(alignment: .topTrailing) {
                
                CourseDetail(course: selectedItem!, namespace: namespace)
                
                CloseButton()
                    .padding(16)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            show.toggle()
                            selectedItem = nil
                            /*tapping too fast will reveal that selectedItem change before than the animation is over
                             Used DispatchQueue to prevent breaking the UI
                             */
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isDisabled = false
                            }
                        }
                    }
            }
            .zIndex(2)
            .frame(maxWidth: 712) //Modal width cannot be larger than 712 (Apple Standard)
            .frame(maxWidth: .infinity) //Blur effect in the background
        }
    }
    
    var tabBar: some View {
        TabView {
            NavigationView {
                content
            }
            .tabItem {
                Image(systemName: "book.closed")
                Text("Courses")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("Tutorials")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "tv")
                Text("Livestreams")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "mail.stack")
                Text("Certificates")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
    
    @ViewBuilder
    var sidebar: some View {
        #if os(iOS)
        NavigationView {
            List {
                NavigationLink(destination: content) {
                    Label("Courses", systemImage: "book.closed")
                }
                NavigationLink(destination: CourseList()) {
                    Label("Tutorials", systemImage: "list.bullet.rectangle")
                }
                Label("Livestreams", systemImage: "tv")
                Label("Certificates", systemImage: "mail.stack")
                Label("Search", systemImage: "magnifyingglass")
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Learn")
            .toolbar(items: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "person.crop.circle")
                }
            })
            
            content
        }
        #endif
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            CoursesView()
                .previewDevice("iPhone 11 Pro")
            CoursesView()
                .previewDevice("iPad Pro (11-inch) (2nd generation)")
        }
    }
}

