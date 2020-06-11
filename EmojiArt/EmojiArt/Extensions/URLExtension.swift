//
//  URLExtension.swift
//  EmojiArt
//
//  Created by Jack Wong on 6/11/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import Foundation

extension URL {
    var imageURL: URL {
        // check to see if there is an embedded imgurl reference
        
        for query in query?.components(separatedBy: "&") ?? [] {
            let queryComponents = query.components(separatedBy: "=")
            if queryComponents.count == 2 {
                if queryComponents[0] == "imgurl", let url = URL(string: queryComponents[1].removingPercentEncoding ?? "") {
                    return url
                }
            }
        }
        return self.baseURL ?? self
    }
}
