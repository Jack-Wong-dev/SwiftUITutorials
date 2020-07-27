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
    
    var body: some View {
        //Card to Full Screen ScrollView (with list) and vice versa
        ZStack {
            ScrollView {
                VStack(spacing: 20.0) {
                    ForEach(courses) { item in
                        CourseItem(course: item) //Matched Geometry Effect always before frame. isSource is optional, helps determine where to animation from.  e.g. Card to Other Card, Other Card to Card
                            .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                            .frame(width: 335, height: 250)
                    }
                    
                }
                .frame(maxWidth: .infinity)
            }
            
            if show {
                //Full Screen
                ScrollView {
                    CourseItem(course: courses[0])
                        .matchedGeometryEffect(id: courses[0].id, in: namespace) //always must be before frame
                        .frame(height: 300)
                    
                    //Content
                    VStack {
                        ForEach(0 ..< 20) { item in
                            CourseRow()
                        }
                    }
                    .padding()
                }
                .background(Color("Background 1"))
                .transition(
                    .asymmetric(
                        insertion: AnyTransition
                            .opacity
                            .animation(Animation.spring().delay(0.3)),
                        removal: AnyTransition
                            .opacity
                            .animation(.spring()))
                    
                    /* Content shows up 0.3 seconds after the transition from card to scrollview.  .asymmetric is required so that the delay doesn't apply when going from scrollview to card */
                )
                .edgesIgnoringSafeArea(.all)
            }
        }
        
        .onTapGesture {
            /* withAnimation is preferred over .animation when Matched Geoemetry Effect is involved.
             .animation creates lag (may change in the future), here the card behind would try to play catch up instead of being directly behind */
            withAnimation(.spring()) {
                show.toggle()
            }
        }
        //        .animation(.spring())
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}

