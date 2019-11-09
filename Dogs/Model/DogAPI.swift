//
//  DogAPI.swift
//  Dogs
//
//  Created by Ahmed Sultan on 8/25/19.
//  Copyright © 2019 Ahmed Sultan. All rights reserved.
//

import Foundation
import UIKit
class DogAPI {
    enum EndPoint {
        case randamImageByBread(String)
        case listOfBread
        var url:URL {
            return URL(string: self.stringValue)!
        }
        var stringValue:String {
            switch self {
            case .randamImageByBread(let bread):
                return "https://dog.ceo/api/breed/\(bread)/images/random"
            case .listOfBread:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    class func requestRandomImageByBread(bread:String, completionHandler: @escaping (String?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: DogAPI.EndPoint.randamImageByBread(bread).url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let dogImage = try decoder.decode(DogImage.self, from: data)
                completionHandler(dogImage.message, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    class func fetchRandomDogImage(url:URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        }
        task.resume()    
    }
    class func fetchListOfAllBread(completionHandler: @escaping ([String], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: DogAPI.EndPoint.listOfBread.url) { (data, response, error) in
            guard let data = data else {
                completionHandler([], error)
              return
            }
            let decoder = JSONDecoder()
            do {
               let breadsData = try decoder.decode(BreadList.self, from: data)
                let breadList = breadsData.message.keys.map({$0})
                completionHandler(breadList, nil)
            } catch {
                completionHandler([], error)
            }
        }
        task.resume()
    }
}
