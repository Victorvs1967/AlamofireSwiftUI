//
//  Observer.swift
//  AlamoSwiftui
//
//  Created by Victor Smirnov on 11.11.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct JokesData: Identifiable {
  
  public var id: Int
  public var joke: String
}

class Observer: ObservableObject {
  
  @Published var jokes = [JokesData]()
  
  let url = "http://api.icndb.com/jokes/random/"
  
  init() {
    
    getJokes()
  }
  
  func getJokes(count: Int = 5) {
    
    AF.request("\(url)\(count)").validate().responseJSON { response in
      
// My code with SwiftyJSON

      switch response.result {
      case .success(let value):
        let json = JSON(value)
        self.jokes += json["value"].map { JokesData(id: $0.1["id"].intValue, joke: $0.1["joke"].stringValue) }
      case .failure(let error):
        print(error.localizedDescription)
      }

// Original code with manual parsing!!!!!!

//      if let json = response.result.value {
//          if  (json as? [String : AnyObject]) != nil{
//              if let dictionaryArray = json as? Dictionary<String, AnyObject?> {
//                  let jsonArray = dictionaryArray["value"]
//                  if let jsonArray = jsonArray as? Array<Dictionary<String, AnyObject?>>{
//                      for i in 0..<jsonArray.count{
//                          let json = jsonArray[i]
//                          if let id = json["id"] as? Int, let jokeString = json["joke"] as? String{
//                          self.jokes.append(JokesData(id: id, joke: jokeString))
//                          }
//                      }
//                  }
//              }
//          }
//      }
      
    }
  }
}
