//
//  LoadingView.swift
//  DesignCode
//
//  Created by Jack Wong on 7/26/20.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(filename: "loading")
                .frame(width: 200, height: 200)
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .previewDevice("iPhone 11 Pro")
    }
}
