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
        let colors = [#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)]
        var index = 0
        
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(Course(title: item.fields["title"] as! String,
                                      subtitle: item.fields["subtitle"] as! String,
                                      image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                                      logo: #imageLiteral(resourceName: "Logo1"),
                                      color: colors[index],
                                      show: false))
                index += 1
            }
        }
    }
}
