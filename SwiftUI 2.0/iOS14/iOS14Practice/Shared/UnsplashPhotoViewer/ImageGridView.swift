//
//  ImageGridView.swift
//  iOS14Practice
//
//  Created by Jack Wong on 7/30/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageGridView: View {
    
    @ObservedObject var randomImages = UnsplashData()
    
    var columns = [
        GridItem(.adaptive(minimum: 160),spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(randomImages.photos) { photo in
                    WebImage(url: URL(string: photo.urls["thumb"]!))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
//                    Text(photo.alt_description).font(.footnote)
                }
            }.onAppear {
                print(randomImages.photos.count)
            }
            .padding()
        }.navigationTitle("Random Grid")
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView()
    }
}
