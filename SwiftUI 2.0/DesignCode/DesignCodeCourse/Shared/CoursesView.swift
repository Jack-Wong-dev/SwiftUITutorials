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
        ZStack {
            CourseItem()
                .matchedGeometryEffect(id: "Card", in: namespace, isSource: !show) //always must be before frame
                .frame(width: 335, height: 250)
            VStack {
                if show {
                    ScrollView {
                        CourseItem()
                            .matchedGeometryEffect(id: "Card", in: namespace) //always must be before frame
                            .frame(height: 300)
    
                        VStack {
                            ForEach(0 ..< 20) { item in
                                CourseRow()
                            }
                        }
                        .padding()
                    }
                    .transition(.opacity)
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .onTapGesture {
            //withAnimation is preferred over .animation when Matched Geoemetry Effect is involved.
            //.animation creates lag, here the card behind would try to play catch up instead of being directly behind
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

