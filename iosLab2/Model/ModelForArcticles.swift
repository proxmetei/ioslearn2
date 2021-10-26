//
//  ModelForArcticles.swift
//  iosLab2
//
//  Created by Алексей on 20.10.2021.
//

import Foundation
var arcticles: [Arcticle] = []
var UrlData: URL{
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}
func loadArcs(completionHandler: (()->Void)?){
    let url = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2021-10-21&sortBy=popularity&apiKey=e35466fb2c2c4233a38b07c0891d88de".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
    let session = URLSession(configuration: .default)
    let downloadedTask = session.dataTask(with: url!) { (data, response, error) in
        if data != nil{
            
  //          print(UrlData)
            parseNews(with: data)
            completionHandler?()
       //     print(arcticles.count)
        }
    }
    downloadedTask.resume()
}
func parseNews(with data : Data?) {
    if data == nil{
        return
    }
    let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
    if rootDictionaryAny == nil{
        return
    }
    let rootDictionary = rootDictionaryAny as? Dictionary<String,Any>
    if rootDictionary == nil {
        return
    }
    if let array = rootDictionary!["articles"] as? [Dictionary<String, Any>]{
    var returnArray: [Arcticle] = []
    for dict in array {
        let newArc = Arcticle(dictionary: dict)
        returnArray.append(newArc)
    }
    arcticles=returnArray
    }
}
