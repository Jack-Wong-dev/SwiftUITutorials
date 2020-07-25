//
//  CourseStore.swift
//  DesignCode
//
//  Created by Jack Wong on 7/24/20.
//

import SwiftUI
import Contentful
import Combine

let client = Client(spaceId: "0ge8xzmnbp2c", accessToken: "03010b0d79abcb655ca3fda453f2f493b5472e0aaa53664bc7dea5ef4fce2676")

//Fetch collection of type Entry.  Entry is the data model from Contentful
func getArray(id: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: "course")
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .failure(let error ):
            print("\(error)")
        }
    }
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    
    init() {
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(Course(title: item.fields["title"] as! String,
                                      subtitle: item.fields["subtitle"] as! String,
                                      image: #imageLiteral(resourceName: "Card2"),
                                      logo: #imageLiteral(resourceName: "Logo1"),
                                      color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
                                      show: false))
            }
        }
    }
}
