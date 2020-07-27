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
    
    var body: some View {
        //Card to Full Screen ScrollView (with list) and vice versa
        ZStack {
            #if os(iOS)
            content
                .navigationBarHidden(true)
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
        }
        .zIndex(1)
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
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}

