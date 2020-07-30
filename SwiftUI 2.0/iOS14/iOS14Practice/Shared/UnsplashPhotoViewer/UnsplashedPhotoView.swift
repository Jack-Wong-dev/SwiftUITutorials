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
                    WebImage(url: URL(string: photo.urls["thumb"]!))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200, alignment: .center)
                        .cornerRadius(15)
                    
                    Text(photo.alt_description).font(.footnote)
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
