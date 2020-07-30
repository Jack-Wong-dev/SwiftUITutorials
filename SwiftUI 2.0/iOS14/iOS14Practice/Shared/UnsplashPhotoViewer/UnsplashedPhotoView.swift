//
//  UnsplashedPhotoView.swift
//  iOS14Practice
//
//  Created by Jack Wong on 7/30/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct UnsplashedPhotoView: View {
    @ObservedObject var randomImages = UnsplashData()
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(randomImages.photos) { photo in
                    HStack {
                        WebImage(url: URL(string: photo.urls["thumb"]!))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200, alignment: .center)

                        Spacer()
                        
                        if let description = photo.alt_description {
                            Text(description).font(.footnote)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(maxWidth: 200, alignment: .center)
                    .padding()
                }
            }
        }
    }
}

struct UnsplashedPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        UnsplashedPhotoView()
    }
}
