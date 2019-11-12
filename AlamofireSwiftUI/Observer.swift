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
      
      switch response.result {
        
      case .success(let value):

        let json = JSON(value)
        self.jokes += json["value"].map { JokesData(id: $0.1["id"].intValue, joke: $0.1["joke"].stringValue) }
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
