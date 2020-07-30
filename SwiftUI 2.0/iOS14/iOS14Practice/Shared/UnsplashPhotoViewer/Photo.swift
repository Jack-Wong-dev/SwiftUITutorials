//
//  Photo.swift
//  iOS14Practice
//
//  Created by Jack Wong on 7/30/20.
//

import Foundation

struct Photo: Identifiable, Decodable {
    var id: String
    var alt_description: String
    var urls: [String:String]
}

class UnsplashData: ObservableObject {
    @Published var photos = [Photo]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "https://api.unsplash.com/photos/random/?count=30&client_id=\(unsplashAPIkey)") else {return}
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                print("DEBUG: URLSesion data task error", error ?? "nil")
                return
            }
            do {
                let json = try JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    for photo in json {
                        self.photos.append(photo)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
