//
//  Arcticle.swift
//  iosLab2
//
//  Created by Алексей on 20.10.2021.
//

import Foundation

struct Arcticle {
    var author: String
    var category: [String]
    var description: String
    var image: String
    var url: String
    var title: String
    init(dictionary: Dictionary<String,Any>){
        author = dictionary["author"] as? String ?? ""
        category = dictionary["category"] as? [String] ?? [""]
        description = dictionary["description"] as? String ?? ""
        image = dictionary["urlToImage"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
    }
}
